/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/

--FUNCTION CODE:2790

DROP FUNCTION IF EXISTS SCHEMA_NAME.gw_fct_grafanalytics_check_data(json);
CREATE OR REPLACE FUNCTION SCHEMA_NAME.gw_fct_graphanalytics_check_data(p_data json)
  RETURNS json AS
$BODY$

/*EXAMPLE

SELECT SCHEMA_NAME.gw_fct_graphanalytics_check_data($${
"client":{"device":4, "infoType":1, "lang":"ES"},
"feature":{},"data":{"parameters":{"selectionMode":"userSelectors","graphClass":"SECTOR"}}}$$)

-- fid: main:v_fid,
	other: 176,180,181,192,208,209,367

select * FROM temp_audit_check_data WHERE fid=v_fid AND cur_user=current_user; 

*/

DECLARE

v_record record;
v_project_type text;
v_count	integer;
v_saveondatabase boolean;
v_result text;
v_version text;
v_result_info json;
v_result_point json;
v_result_line json;
v_result_polygon json;
v_querytext text;
v_result_id text;
v_selectionmode text;
v_edit text;
v_config_param text;
v_sector boolean;
v_presszone boolean;
v_dma boolean;
v_dqa boolean;
v_minsector boolean;
v_graphclass text;
v_error_context text;
rec text;
v_fid integer;

BEGIN

	--  Search path	
	SET search_path = "SCHEMA_NAME", public;

	-- getting input data 	
	v_selectionmode := ((p_data ->>'data')::json->>'parameters')::json->>'selectionMode'::text;
	v_graphclass := ((p_data ->>'data')::json->>'parameters')::json->>'graphClass'::text;
	v_fid := ((p_data ->>'data')::json->>'parameters')::json->>'fid'::text;

	-- select config values
	SELECT project_type, giswater INTO v_project_type, v_version FROM sys_version order by id desc limit 1;

	-- select config values
	v_sector  := (SELECT (value::json->>'SECTOR')::boolean FROM config_param_system WHERE parameter='utils_graphanalytics_status');
	v_dma  := (SELECT (value::json->>'DMA')::boolean FROM config_param_system WHERE parameter='utils_graphanalytics_status');
	v_dqa  := (SELECT (value::json->>'DQA')::boolean FROM config_param_system WHERE parameter='utils_graphanalytics_status');
	v_presszone  := (SELECT (value::json->>'PRESSZONE')::boolean FROM config_param_system WHERE parameter='utils_graphanalytics_status');
	v_minsector  := (SELECT (value::json->>'MINSECTOR')::boolean FROM config_param_system WHERE parameter='utils_graphanalytics_status');

	-- init variables
	v_count=0;

	IF v_fid is null THEN
		v_fid = 211;
	END IF;

	-- set v_edit_ variable
	IF v_selectionmode='wholeSystem' THEN
		v_edit = '';
	ELSIF v_selectionmode='userSelectors' THEN
		v_edit = 'v_edit_';
	END IF;
	
	IF v_fid = 211 OR v_fid = 101 THEN
		CREATE TEMP TABLE temp_anl_node (LIKE SCHEMA_NAME.anl_node INCLUDING ALL);
		CREATE TEMP TABLE temp_audit_check_data (LIKE SCHEMA_NAME.audit_check_data INCLUDING ALL);
	END IF;

	-- Starting process
	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, null, 4, concat('DATA QUALITY ANALYSIS ACORDING graph ANALYTICS RULES'));
	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, null, 4, '-------------------------------------------------------------');

	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, null, 3, 'CRITICAL ERRORS');
	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, null, 3, '----------------------');

	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, null, 2, 'WARNINGS');
	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, null, 2, '--------------');

	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, null, 1, 'INFO');
	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, null, 1, '-------');

	
	-- Check if there are nodes type 'ischange=1 or 2 (true or maybe)' without changing catalog of arcs (208)
	v_querytext = '(SELECT n.node_id, count(*), nodecat_id, the_geom, a.expl_id FROM 
			(SELECT node_1 as node_id, arccat_id, v_edit_arc.expl_id FROM v_edit_arc WHERE node_1 IN (SELECT node_id FROM v_node JOIN cat_node ON id=nodecat_id WHERE ischange=1)
			  UNION
			 SELECT node_2, arccat_id, v_edit_arc.expl_id FROM v_edit_arc WHERE node_2 IN (SELECT node_id FROM v_node JOIN cat_node ON id=nodecat_id WHERE ischange=1)
			GROUP BY 1,2,3) a	JOIN node n USING (node_id) GROUP BY 1,3,4,5 HAVING count(*) <> 2)';

	EXECUTE concat('SELECT count(*) FROM ',v_querytext,' b') INTO v_count;

	IF v_count > 0 THEN
		EXECUTE concat ('INSERT INTO temp_anl_node (fid, node_id, nodecat_id, descript, the_geom, expl_id)
			SELECT 208, node_id, nodecat_id, ''Node with ischange=1 without any variation of arcs in terms of diameter, pn or material'', the_geom, expl_id FROM (', v_querytext,') b');
		INSERT INTO temp_audit_check_data (fid,  criticity, result_id, error_message, fcount)
		VALUES (v_fid, 2, '208', concat('WARNING-208: There is/are ',v_count,' nodes with ischange on 1 (true) without any variation of arcs in terms of diameter, pn or material. Please, check your data before continue.'),v_count);

	-- is defined as warning because error (3) will break topologic issues of mapzones
	ELSE
		INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
		VALUES (v_fid, 1, '208','INFO: No nodes ''ischange'' without real change have been found.',v_count);
	END IF;
			
	-- Check if there are change of catalog with cat_feature_node 'ischange=0 (false)' (209)
	v_querytext = '(SELECT node_id, nodecat_id, array_agg(arccat_id) as arccat_id, the_geom, node.expl_id FROM ( SELECT count(*), node_id, arccat_id FROM 
			(SELECT node_1 as node_id, arccat_id FROM '||v_edit||'arc UNION ALL SELECT node_2, arccat_id FROM '||v_edit||'arc)a GROUP BY 2,3 HAVING count(*) <> 2 ORDER BY 2) b
			JOIN node USING (node_id) JOIN cat_node ON id=nodecat_id WHERE ischange=0 GROUP By 1,2,4,5 HAVING count(*)=2)';	

	EXECUTE concat('SELECT count(*) FROM ',v_querytext,' b') INTO v_count;

	IF v_count > 0 THEN
		EXECUTE concat ('INSERT INTO temp_anl_node (fid, node_id, nodecat_id, descript, the_geom, expl_id)
		SELECT 209, node_id, nodecat_id, concat(''Nodes with catalog changes without nodecat_id ischange:'',arccat_id), the_geom, expl_id FROM (', v_querytext,') b');

		INSERT INTO temp_audit_check_data (fid,  criticity, result_id, error_message, fcount)
		VALUES (v_fid, 2, '209', concat('WARNING-209: There is/are ',v_count,' nodes where arc catalog changes without nodecat with ischange on 0 or 2 (false or maybe). Please, check your data before continue.'),v_count);
			-- is defined as warning because error (3) will break topologic issues of mapzones
	ELSE
		INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
		VALUES (v_fid, 1, '209','INFO: No nodes without ''ischange'' where arc changes have been found',v_count);
	END IF;

	-- valves closed/broken with null values (176)
	v_querytext = '(SELECT n.node_id, n.nodecat_id, n.the_geom, expl_id FROM man_valve JOIN '||v_edit||'node n USING (node_id) WHERE n.state = 1 AND (broken IS NULL OR closed IS NULL)) a';

	EXECUTE concat('SELECT count(*) FROM ',v_querytext) INTO v_count;
	IF v_count > 0 THEN
		EXECUTE concat ('INSERT INTO temp_anl_node (fid, node_id, nodecat_id, descript, the_geom, expl_id) 
			SELECT 176, node_id, nodecat_id, ''valves closed/broken with null values'', the_geom, expl_id FROM ', v_querytext);
		INSERT INTO temp_audit_check_data (fid, criticity, result_id,  error_message, fcount)
		VALUES (v_fid, 3, '176', concat('ERROR-176: There is/are ',v_count,' valve''s (state=1) with broken or closed with NULL values.'),v_count);
	ELSE
		INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
		VALUES (v_fid, 1, '176', 'INFO: There are not operative valve(s) with null values on closed/broken fields.',v_count);
	END IF;

	-- config_graph_mincut_x_exploitation (177)
	SELECT count(*) INTO v_count FROM config_graph_mincut cgi INNER JOIN node n ON cgi.node_id = n.node_id 
	WHERE n.expl_id NOT IN (SELECT expl_id FROM exploitation WHERE active IS TRUE);

	IF v_count > 0 THEN
		INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
		VALUES (v_fid, 3, '177', concat('ERROR-177: There is/are at least ',v_count,
		' row(s) with exploitation bad configured on the config_graph_mincut table. Please check your data before continue'),v_count);
	ELSE
		INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
		VALUES (v_fid, 1, '177', 'INFO: It seems config_graph_mincut table is well configured. At least, table is filled with nodes from all exploitations.',v_count);
	END IF;


	-- graphanalytics sector (268)
	IF v_sector IS TRUE AND (v_graphclass = 'SECTOR' OR v_graphclass = 'ALL') THEN

		-- check sector.graphconfig values
		v_querytext = 'SELECT * FROM v_edit_sector WHERE graphconfig IS NULL and sector_id > 0 AND active IS TRUE' ;
		EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a') INTO v_count;

		IF v_count > 0 THEN
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount) 
			VALUES (v_fid, 3, '268', concat('ERROR-268: There is/are ',v_count, ' sectors on sector table with graphconfig not configured.'),v_count);
		ELSE
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount) 
			VALUES (v_fid, 1, '268', 'INFO: All sectors has graphconfig values not null.',v_count);
		END IF;	

		-- sector : check coherence against nodetype.graphdelimiter and nodeparent defined on secetor.graphconfig (fid:  180)
		v_querytext ='SELECT node_id, nodecat_id, the_geom, a.active, '||v_edit||'node.expl_id FROM '||v_edit||'node JOIN cat_node c ON id=nodecat_id JOIN cat_feature_node n ON n.id=c.nodetype_id
		LEFT JOIN (SELECT node_id, active FROM '||v_edit||'node JOIN (SELECT (json_array_elements_text((graphconfig::json->>''use'')::json))::json->>''nodeParent'' as node_id, 
		active FROM '||v_edit||'sector WHERE graphconfig IS NOT NULL )a USING (node_id)) a USING (node_id) WHERE graph_delimiter=''SECTOR'' AND (a.node_id IS NULL
		OR node_id NOT IN (SELECT (json_array_elements_text((graphconfig::json->>''ignore'')::json))::text FROM '||v_edit||'sector WHERE active IS TRUE))
		AND '||v_edit||'node.state > 0';
	

	END IF;

	-- graphanalytics dma(269)
	IF v_dma IS TRUE AND (v_graphclass = 'DMA' OR v_graphclass = 'ALL') THEN

		-- check dma.graphconfig values
		v_querytext = 'SELECT * FROM v_edit_dma WHERE graphconfig IS NULL and dma_id > 0  AND active IS TRUE' ;
		EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a') INTO v_count;

		IF v_count > 0 THEN
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount) 
			VALUES (v_fid, 3, '269', concat('ERROR-269: There is/are ',v_count, ' dma on dma table with graphconfig not configured.'),v_count);
		ELSE
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount) 
			VALUES (v_fid, 1, '269','INFO: All dma has graphconfig values not null.',v_count);
		END IF;	

		-- dma : check coherence against nodetype.graphdelimiter and nodeparent defined on dma.graphconfig (fid:  180)
		v_querytext ='SELECT node_id, nodecat_id, the_geom, a.active, '||v_edit||'node.expl_id FROM '||v_edit||'node JOIN cat_node c ON id=nodecat_id JOIN cat_feature_node n ON n.id=c.nodetype_id
		LEFT JOIN (SELECT node_id, active FROM '||v_edit||'node JOIN (SELECT (json_array_elements_text((graphconfig::json->>''use'')::json))::json->>''nodeParent'' as node_id, 
		active FROM '||v_edit||'dma WHERE graphconfig IS NOT NULL )a USING (node_id)) a USING (node_id) WHERE graph_delimiter=''DMA'' AND (a.node_id IS NULL
		OR node_id NOT IN (SELECT (json_array_elements_text((graphconfig::json->>''ignore'')::json))::text FROM '||v_edit||'dma WHERE active IS TRUE))
		AND '||v_edit||'node.state > 0';

		EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a') INTO v_count;
		IF v_count > 0 THEN
			EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a WHERE active IS NULL') INTO v_count;
			IF v_count > 0 THEN
				EXECUTE concat 
				('INSERT INTO temp_anl_node (fid, node_id, nodecat_id, descript, the_geom, expl_id) 
				SELECT 180, node_id, nodecat_id, ''cat_feature_node.graph_delimiter is DMA but node is not configured on dma.graphconfig'', the_geom,expl_id 
				FROM (', v_querytext,')a WHERE active IS NULL');
				INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
				VALUES (v_fid, 2, '180', concat('WARNING-180: There is/are ',v_count,
				' node(s) with cat_feature_node.graph_delimiter=''DMA'' not configured on the dma table.'),v_count);
			END IF;
			EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a WHERE active IS FALSE') INTO v_count;
			IF v_count > 0 THEN
				EXECUTE concat 
				('INSERT INTO temp_anl_node (fid, node_id, nodecat_id, descript, the_geom, expl_id) 
				SELECT 180, node_id, nodecat_id, ''cat_feature_node.graph_delimiter is DMA but node is configured for unactive mapzone'', the_geom,expl_id 
				FROM (', v_querytext,')a WHERE active IS FALSE');
				INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
				VALUES (v_fid, 2, '180', concat('WARNING-180: There is/are ',v_count,
				' node(s) with cat_feature_node.graph_delimiter=''DMA'' configured for unactive mapzone.'),v_count);
			END IF;
		ELSE
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
			VALUES (v_fid, 1, '180','INFO: All nodes with cat_feature_node.graphdelimiter=''DMA'' are defined as nodeParent on dma.graphconfig',v_count);
		END IF;
		
		-- dma, toArc (fid:  84)
	END IF;

	-- graphanalytics dqa (270)
	IF v_dqa IS TRUE AND (v_graphclass = 'DQA' OR v_graphclass = 'ALL') THEN

		-- check dqa.graphconfig values
		v_querytext = 'SELECT * FROM v_edit_dqa WHERE graphconfig IS NULL and dqa_id > 0 AND active IS TRUE' ;
		EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a') INTO v_count;

		IF v_count > 0 THEN
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount) 
			VALUES (v_fid, 3, '270', concat('ERROR-270: There is/are ',v_count, ' dqa on dqa table with graphconfig not configured.'),v_count);
		ELSE
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount) 
			VALUES (v_fid, 1, '270','INFO: All dqa has graphconfig values not null.',v_count);
		END IF;	

		-- dqa : check coherence against nodetype.graphdelimiter and nodeparent defined on dqa.graphconfig (fid:  181)
		v_querytext = 'SELECT node_id, nodecat_id, the_geom, a.active,  '||v_edit||'node.expl_id FROM '||v_edit||'node JOIN cat_node c ON id=nodecat_id JOIN cat_feature_node n ON n.id=c.nodetype_id
		LEFT JOIN (SELECT node_id, active FROM '||v_edit||'node JOIN (SELECT (json_array_elements_text((graphconfig::json->>''use'')::json))::json->>''nodeParent'' as node_id, 
		active FROM '||v_edit||'dqa WHERE graphconfig IS NOT NULL )a USING (node_id)) a USING (node_id) WHERE graph_delimiter=''DQA'' AND (a.node_id IS NULL
		OR node_id NOT IN (SELECT (json_array_elements_text((graphconfig::json->>''ignore'')::json))::text FROM '||v_edit||'dqa WHERE active IS TRUE))
		AND '||v_edit||'node.state > 0';

		EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a') INTO v_count;

		IF v_count > 0 THEN
			EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a WHERE active IS NULL') INTO v_count;
			IF v_count > 0 THEN
				EXECUTE concat 
				('INSERT INTO temp_anl_node (fid, node_id, nodecat_id, descript, the_geom, expl_id) 
				SELECT 181, node_id, nodecat_id, ''cat_feature_node.graph_delimiter is DQA but node is not configured on dqa.graphconfig'', the_geom, expl_id 
				FROM (', v_querytext,')a');
				INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
				VALUES (v_fid, 2, '181',concat('WARNING-181: There is/are ',v_count,
				' node(s) with cat_feature_node.graph_delimiter=''DQA'' not configured on the dqa table.'),v_count);
			END IF;
			EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a WHERE active IS FALSE') INTO v_count;
			IF v_count > 0 THEN
				EXECUTE concat 
				('INSERT INTO temp_anl_node (fid, node_id, nodecat_id, descript, the_geom, expl_id) 
				SELECT 181, node_id, nodecat_id, ''cat_feature_node.graph_delimiter is DQA but node is configured for unactive mapzone'', the_geom, expl_id 
				FROM (', v_querytext,')a WHERE active IS FALSE');
				INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
				VALUES (v_fid, 2, '181', concat('WARNING-181: There is/are ',v_count,
				' node(s) with cat_feature_node.graph_delimiter=''DQA'' configured for unactive mapzone.'),v_count);
			END IF;
		ELSE
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
			VALUES (v_fid, 1, '181', 'INFO: All nodes with cat_feature_node.graphdelimiter=''DQA'' are defined as nodeParent on dqa.graphconfig',v_count);
		END IF;

		-- dqa, toArc (fid:  85)
	END IF;

	-- graphanalytics presszone (271)
	IF v_presszone IS TRUE AND (v_graphclass = 'PRESSZONE' OR v_graphclass = 'ALL') THEN

		-- check presszone.graphconfig values
		v_querytext = 'SELECT * FROM v_edit_presszone WHERE graphconfig IS NULL and presszone_id > 0::text AND active IS TRUE' ;
		EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a') INTO v_count;

		IF v_count > 0 THEN
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount) 
			VALUES (v_fid, 3, '271', concat('ERROR-271: There is/are ',v_count, ' presszone on presszone table with graphconfig not configured.'),v_count);
		ELSE
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount) 
			VALUES (v_fid, 1, '271','INFO: All presszones has graphconfig values not null.',v_count);
		END IF;	

		-- presszone : check coherence between nodetype.graphdelimiter and nodeparent defined on presszone.graphconfig (fid:  182)
		v_querytext = 'SELECT node_id, nodecat_id, the_geom, a.active,'||v_edit||'node.expl_id FROM '||v_edit||'node JOIN cat_node c ON id=nodecat_id JOIN cat_feature_node n ON n.id=c.nodetype_id
		LEFT JOIN (SELECT node_id, active FROM '||v_edit||'node JOIN (SELECT (json_array_elements_text((graphconfig::json->>''use'')::json))::json->>''nodeParent'' as node_id, 
		active FROM '||v_edit||'presszone WHERE graphconfig IS NOT NULL )a USING (node_id)) a USING (node_id) WHERE graph_delimiter=''PRESSZONE'' AND (a.node_id IS NULL
		OR node_id NOT IN (SELECT (json_array_elements_text((graphconfig::json->>''ignore'')::json))::text FROM '||v_edit||'presszone WHERE active IS TRUE))
		AND '||v_edit||'node.state > 0';

		EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a') INTO v_count;
		IF v_count > 0 THEN
			EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a WHERE active IS NULL') INTO v_count;
			IF v_count > 0 THEN
				EXECUTE concat 
				('INSERT INTO temp_anl_node (fid, node_id, nodecat_id, descript, the_geom, expl_id) 
				SELECT 182, node_id, nodecat_id, ''cat_feature_node.graph_delimiter is PRESSZONE but node is not configured on presszone.graphconfig'', the_geom, expl_id 
				FROM (', v_querytext,')a');
				INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
				VALUES (v_fid, 2, '182',concat('WARNING-182: There is/are ',v_count,
				' node(s) with cat_feature_node.graph_delimiter=''PRESSZONE'' not configured on the presszone table.'),v_count);
			END IF;
			EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a WHERE active IS FALSE') INTO v_count;
			IF v_count > 0 THEN
				EXECUTE concat 
				('INSERT INTO temp_anl_node (fid, node_id, nodecat_id, descript, the_geom, expl_id) 
				SELECT 182, node_id, nodecat_id, ''cat_feature_node.graph_delimiter is PRESSZONE but node is configured for unactive mapzone'', the_geom, expl_id 
				FROM (', v_querytext,')a WHERE active IS FALSE');
				INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
				VALUES (v_fid, 2, '182', concat('WARNING-182: There is/are ',v_count,
				' node(s) with cat_feature_node.graph_delimiter=''PRESSZONE'' configured for unactive mapzone.'),v_count);
			END IF;
		ELSE
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
			VALUES (v_fid, 1, '182','INFO: All nodes with cat_feature_node.graphdelimiter=''PRESSZONE'' are defined as nodeParent on presszone.graphconfig',v_count);
		END IF;

	END IF;

	--Check if presszone_id is a numeric value (fid 460)
	IF v_graphclass = 'PRESSZONE' OR v_graphclass = 'ALL' THEN
		v_querytext = 'SELECT presszone_id FROM presszone WHERE presszone_id!=''-1'' AND presszone_id ~''^\d+(\.\d+)?$'' is false' ;
		EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a') INTO v_count;

		IF v_count > 0 THEN
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount) 
			VALUES (v_fid, 3, '460', concat('ERROR-460: There is/are ',v_count, ' presszone with id that is not a numeric value.'),v_count);
		ELSE
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount) 
			VALUES (v_fid, 1, '460','INFO: All presszone_ids are numeric values.',v_count);
		END IF;	
	END IF;	

	--Check if defined nodes and arcs exist in a database (fid 367)

	FOR rec IN SELECT unnest(ARRAY['sector', 'dma', 'dqa', 'presszone']) LOOP
	
		v_querytext = 'SELECT b.arc_id, b.'||rec||'_id as zone_id FROM (
		SELECT '||rec||'_id, json_array_elements_text(((json_array_elements_text((graphconfig::json->>''use'')::json))::json->>''toArc'')::json) as arc_id FROM '||v_edit||rec||')b 
		WHERE arc_id not in (select arc_id FROM arc WHERE state=1)';

		EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a') INTO v_count;
		IF v_count > 0 THEN
			EXECUTE 'INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
			SELECT '||v_fid||', 2, 367, concat(''WARNING-367: There is/are '','||v_count||',
			'' arc(s) that are configured as toArc for '','''||rec||''','' but is not operative on arc table. Arc_id - '',
			string_agg(concat('''||rec||':'',zone_id,''-'',a.arc_id),'', ''),''.''), '||v_count||' FROM('|| v_querytext||')a';
		ELSE
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
			VALUES (v_fid, 1, 367, concat('INFO: All arcs defined as toArc on ',rec,' exists on DB.'), 0);
		END IF;

		v_querytext = 'SELECT b.node_id, b.'||rec||'_id as zone_id FROM (
		SELECT '||rec||'_id, (graphconfig->''use''->0->>''nodeParent'')::text as node_id FROM '||rec||')b 
		WHERE node_id::text not in (select node_id FROM node WHERE state=1)';

		EXECUTE concat('SELECT count(*) FROM (',v_querytext,')a') INTO v_count;
		IF v_count > 0 THEN
			EXECUTE 'INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
			SELECT '||v_fid||', 2, 367, concat(''WARNING-367: There is/are '','||v_count||',
			'' node(s) that are configured as nodeParent for '','''||rec||''','' but is not operative on node table. Node_id - '',
			string_agg(concat('''||rec||':'',zone_id,''-'',a.node_id::text),'', ''),''.''), '||v_count||' FROM('|| v_querytext||')a';
		ELSE
			INSERT INTO temp_audit_check_data (fid, criticity, result_id, error_message, fcount)
			VALUES (v_fid, 1, 367, concat('INFO: All arcs defined as nodeParent on ',rec,' exists on DB.'),0);
		END IF;
	END LOOP;


	-- Removing isaudit false sys_fprocess
	FOR v_record IN SELECT * FROM sys_fprocess WHERE isaudit is false
	LOOP
		-- remove anl tables
		DELETE FROM temp_anl_node WHERE fid = v_record.fid AND cur_user = current_user;

		DELETE FROM temp_audit_check_data WHERE result_id::text = v_record.fid::text AND cur_user = current_user AND fid = v_fid;		
	END LOOP;

	
	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, v_result_id, 4, '');
	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, v_result_id, 3, '');
	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, v_result_id, 2, '');
	INSERT INTO temp_audit_check_data (fid, result_id, criticity, error_message) VALUES (v_fid, v_result_id, 1, '');
	
	IF v_fid = 211 THEN

		-- delete old values on result table
		DELETE FROM audit_check_data WHERE fid=211 AND cur_user=current_user;
		DELETE FROM anl_node WHERE cur_user=current_user AND fid IN (176,180,181,182,208,209);

		INSERT INTO anl_node SELECT * FROM temp_anl_node;
		INSERT INTO audit_check_data SELECT * FROM temp_audit_check_data;

	ELSIF  v_fid = 101 THEN 
		UPDATE temp_audit_check_data SET fid = 211;

		INSERT INTO project_temp_audit_check_data SELECT * FROM temp_audit_check_data;
		INSERT INTO project_temp_anl_node SELECT * FROM temp_anl_node;

	END IF;

	-- get results
	-- info
	SELECT array_to_json(array_agg(row_to_json(row))) INTO v_result 
	FROM (SELECT id, error_message as message FROM temp_audit_check_data WHERE cur_user="current_user"() AND 
	fid=211 order by criticity desc, id asc) row;
	v_result := COALESCE(v_result, '{}'); 
	v_result_info = concat ('{"geometryType":"", "values":',v_result, '}');
	
	--points
	v_result = null;
	SELECT jsonb_agg(features.feature) INTO v_result
	FROM (
  	SELECT jsonb_build_object(
     'type',       'Feature',
    'geometry',   ST_AsGeoJSON(the_geom)::jsonb,
    'properties', to_jsonb(row) - 'the_geom'
  	) AS feature
  	FROM (SELECT id, node_id as feature_id, nodecat_id as feature_catalog, state, expl_id, descript,fid, the_geom
  	FROM  temp_anl_node WHERE cur_user="current_user"() AND fid IN (176,180,181,182,208,209)) row) features;

	v_result := COALESCE(v_result, '{}'); 


	IF v_result = '{}' THEN 
		v_result_point = '{"geometryType":"", "values":[]}';
	ELSE 
		v_result_point = concat ('{"geometryType":"Point", "features":',v_result, '}');
	END IF;
	
	--    Control nulls
	v_result_info := COALESCE(v_result_info, '{}'); 
	v_result_point := COALESCE(v_result_point, '{}'); 
	v_result_line := COALESCE(v_result_line, '{}'); 
	v_result_polygon := COALESCE(v_result_polygon, '{}'); 
	
	IF v_fid = 211 OR v_fid = 101 THEN
		--DROP temp tables
		DROP TABLE IF EXISTS temp_anl_node ;
		DROP TABLE IF EXISTS temp_audit_check_data;
	END IF;

	-- Return
	RETURN gw_fct_json_create_return(('{"status":"Accepted", "message":{"level":1, "text":"Data quality analysis done succesfully"}, "version":"'||v_version||'"'||
             ',"body":{"form":{}'||
		     ',"data":{ "info":'||v_result_info||','||
				'"point":'||v_result_point||','||
				'"line":'||v_result_line||','||
				'"polygon":'||v_result_polygon||'}'||
		       '}'||
	    '}')::json, 2790, null, null, null);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

