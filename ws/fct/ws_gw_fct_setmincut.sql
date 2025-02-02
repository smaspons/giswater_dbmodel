/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/

--FUNCTION CODE: 2980

DROP FUNCTION IF EXISTS SCHEMA_NAME.gw_fct_setmincut(json);
CREATE OR REPLACE FUNCTION SCHEMA_NAME.gw_fct_setmincut(p_data json)
RETURNS json AS
$BODY$

/*
-- Button networkMincut on mincut dialog
SELECT gw_fct_setmincut('{"data":{"action":"mincutNetwork", "arcId":"2001", "mincutId":"3", "usePsectors":false}}');

-- Button valveUnaccess on mincut dialog
SELECT gw_fct_setmincut('{"data":{"action":"mincutValveUnaccess", "nodeId":1001, "mincutId":"3", "usePsectors":false}}');

-- Button Accept on mincut dialog
SELECT gw_fct_setmincut('{"data":{"action":"mincutAccept", "mincutClass":1, "mincutId":"3", "status":"check", "usePsectors":false}}');

-- Button Accept on mincut conflict dialog
SELECT gw_fct_setmincut('{"data":{"action":"mincutAccept", "mincutClass":1, "mincutId":"3", "status":"continue"}}');

-- Button Accept when is mincutClass = 2
SELECT gw_fct_setmincut('{"data":{"action":"mincutAccept", "mincutClass":2, "mincutId":"3"}}');

-- Button Accept when is mincutClass = 3
SELECT gw_fct_setmincut('{"data":{"action":"mincutAccept", "mincutClass":3, "mincutId":"3"}}');

fid = 216

*/

DECLARE

v_cur_user text;
v_prev_cur_user text;
v_device integer;
v_arc integer;
v_id integer;
v_node integer;
v_mincut integer;
v_status boolean;
v_valveunaccess json;
v_action text;
v_mincut_class integer;
v_version text;
v_error_context text;
v_usepsectors boolean;
v_days integer;
v_querytext text;
v_response json;
v_message text;

v_xcoord double precision;
v_ycoord double precision;
v_epsg integer;
v_client_epsg integer;
v_point public.geometry;

v_sensibility_f float;
v_sensibility float;
v_zoomratio float;

v_tiled boolean;
v_result json;
v_result_init json;
v_result_valve json;
v_result_node json;
v_result_connec json;
v_result_arc json;
v_mincut_version integer;

BEGIN

	-- Search path
	SET search_path = "SCHEMA_NAME", public;
	SELECT giswater INTO v_version FROM sys_version order by id desc limit 1;

	--return current_user;
	-- get input parameters
	v_cur_user := (p_data ->> 'client')::json->> 'cur_user';
	v_device := (p_data ->> 'client')::json ->> 'device';
	v_tiled := ((p_data ->>'client')::json->>'tiled')::boolean;
	v_action := (p_data ->>'data')::json->>'action';
	v_mincut := ((p_data ->>'data')::json->>'mincutId')::integer;
	v_mincut_class := ((p_data ->>'data')::json->>'mincutClass')::integer;
	v_node := ((p_data ->>'data')::json->>'nodeId')::integer;
	v_arc := ((p_data ->>'data')::json->>'arcId')::integer;
	v_usepsectors := ((p_data ->>'data')::json->>'usePsectors')::boolean;
	v_mincut_version := (SELECT value::json->>'version' FROM config_param_system WHERE parameter = 'om_mincut_config');

	v_xcoord := ((p_data ->> 'data')::json->> 'coordinates')::json->>'xcoord';
	v_ycoord := ((p_data ->> 'data')::json->> 'coordinates')::json->>'ycoord';
	v_epsg := (SELECT epsg FROM sys_version ORDER BY id DESC LIMIT 1);
	v_client_epsg := (p_data ->> 'client')::json->> 'epsg';
	v_zoomratio := ((p_data ->> 'data')::json->> 'coordinates')::json->>'zoomRatio';

	IF v_client_epsg IS NULL THEN v_client_epsg = v_epsg; END IF;
	IF v_cur_user IS NULL THEN v_cur_user = current_user; END IF;

	-- get arc_id from click
	IF v_xcoord IS NOT NULL THEN 
		EXECUTE 'SELECT (value::json->>''web'')::float FROM config_param_system WHERE parameter=''basic_info_sensibility_factor'''
		INTO v_sensibility_f;
		v_sensibility = (v_zoomratio / 500 * v_sensibility_f);

		-- Make point
		SELECT ST_Transform(ST_SetSRID(ST_MakePoint(v_xcoord,v_ycoord),v_client_epsg),v_epsg) INTO v_point;
	
		SELECT arc_id INTO v_arc FROM v_edit_arc WHERE ST_DWithin(the_geom, v_point,v_sensibility) LIMIT 1;
	END IF;

	IF v_action = 'mincutNetwork' THEN

		--create new mincut_id
		IF v_device = 5 and v_mincut IS NULL THEN
			SELECT setval('om_mincut_seq', COALESCE((SELECT max(id::integer)+1 FROM om_mincut), 1), true) INTO v_mincut;
			INSERT INTO om_mincut (id) VALUES (v_mincut);
		END IF;

		-- check if there is no cap node_id in the v_edit_node of those registered in config_graph_mincut
		IF EXISTS (
			SELECT 1
			FROM config_graph_mincut
			WHERE node_id NOT IN (
				SELECT node_id
				FROM v_edit_node
			)
		) THEN
			RETURN ('{"status":"Failed", "message":{"level":2, "text":"There are node_id values in config_graph_mincut that are not present in v_edit_node."}}')::json;
		END IF;

		--check if arc exists in database or look for a new arc_id in the same location
		IF (SELECT arc_id FROM arc WHERE arc_id::integer=v_arc) IS NULL THEN
			SELECT arc_id::integer INTO v_arc FROM arc a, om_mincut om WHERE ST_DWithin(a.the_geom, om.anl_the_geom,0.1) AND state=1 and om.id=v_mincut;

			IF v_arc IS NULL AND v_usepsectors is true then
				SELECT arc_id::integer INTO v_arc FROM arc a, om_mincut om WHERE ST_DWithin(a.the_geom, om.anl_the_geom,0.1) AND state=2;
			end if;
		END IF;

		IF v_device = 4 THEN
			IF v_mincut_version = 5 THEN
				RETURN gw_fct_mincut_minsector(v_arc::text, v_mincut, v_usepsectors);
			ELSE 
				RETURN gw_fct_mincut(v_arc::text, 'arc'::text, v_mincut, v_usepsectors);
			END IF;
            
		ELSIF v_device = 5 THEN
			IF v_mincut_version = 5 THEN
				SELECT gw_fct_mincut_minsector(v_arc::text, v_mincut, v_usepsectors)INTO v_response;
			ELSE 
				SELECT gw_fct_mincut(v_arc::text, 'arc'::text, v_mincut, v_usepsectors) INTO v_response;
			END IF;
		
			p_data = jsonb_set(p_data::jsonb, '{data,mincutId}', to_jsonb(v_mincut))::json;
			v_mincut_class = 1;
			v_querytext = concat('UPDATE om_mincut SET mincut_class = ', v_mincut_class, ', ', 
							'anl_the_geom = ''', ST_SetSRID(ST_Point(v_xcoord, v_ycoord), v_client_epsg), ''', ', 
							'anl_user = ''', v_cur_user, ''', ', 
							'anl_feature_type = ''ARC'', ', 
							'anl_feature_id = ', v_arc, ' ',
							'WHERE id = ', v_mincut);
			EXECUTE v_querytext;
			RETURN gw_fct_getmincut(p_data);
		END IF;
	
	ELSIF v_action = 'startMincut' THEN

		IF (SELECT json_extract_path_text(value::json, 'redoOnStart','status')::boolean FROM config_param_system WHERE parameter='om_mincut_settings') is true THEN
			--reexecuting mincut on clicking start
			SELECT json_extract_path_text(value::json, 'redoOnStart','days')::integer INTO v_days FROM config_param_system WHERE parameter='om_mincut_settings';

			IF (SELECT date(anl_tstamp) + v_days FROM om_mincut WHERE id=v_mincut) <= date(now()) THEN 

				--check if arc exists in database or look for a new arc_id in the same location
				IF (SELECT arc_id FROM arc WHERE arc_id::integer=v_arc) IS NULL THEN
					SELECT arc_id::integer INTO v_arc FROM arc a, om_mincut om WHERE ST_DWithin(a.the_geom, om.anl_the_geom,0.1) AND state=1 and om.id=v_mincut;

					IF v_arc IS NULL AND v_usepsectors is true then
						SELECT arc_id::integer INTO v_arc FROM arc a, om_mincut om WHERE ST_DWithin(a.the_geom, om.anl_the_geom,0.1) AND state=2;
					end if;
				END IF;

				IF v_mincut_version = 5 THEN
					RETURN gw_fct_mincut_minsector(v_arc::text, v_mincut, v_usepsectors);
				ELSE 
					RETURN gw_fct_mincut(v_arc::text, 'arc'::text, v_mincut, v_usepsectors);
				END IF;
			ELSE
				RETURN ('{"status":"Accepted", "message":{"level":3, "text":"Start mincut"}, "version":"'||v_version||'","body":{"form":{},"data":{ "info":null,"geometry":null, "mincutDetails":null}}}}')::json;
			END IF;
		ELSE
		    --  Return
	    RETURN ('{"status":"Accepted", "message":{"level":3, "text":"Start mincut"}, "version":"'||v_version||'","body":{"form":{},"data":{ "info":null,"geometry":null, "mincutDetails":null}}}')::json;
		END IF;

	ELSIF v_action = 'mincutValveUnaccess' THEN

		RETURN gw_fct_json_create_return(gw_fct_mincut_valve_unaccess(p_data), 2980, null, null, null);
		
	ELSIF v_action = 'mincutAccept' THEN

		-- call setfields
		v_message = '{"text": "Mincut accepted.", "level": 1}';
		IF v_device = 5 THEN
			v_querytext = concat('SELECT gw_fct_setfields($$', p_data, '$$);');
			EXECUTE v_querytext;
		END IF;

		-- Update table 'selector_mincut_result'
		DELETE FROM selector_mincut_result WHERE cur_user = v_cur_user;
		INSERT INTO selector_mincut_result (cur_user, result_id) VALUES (v_cur_user,v_mincut);

		IF v_mincut_class = 1 THEN

			UPDATE config_param_user SET value = v_mincut::text WHERE parameter = 'inp_options_valve_mode_mincut_result' AND cur_user = v_cur_user;
		
			RETURN gw_fct_mincut_result_overlap(p_data);

		ELSIF v_mincut_class IN (2, 3) THEN
		
			RETURN gw_fct_mincut_connec(p_data);
		
		END IF;

	ELSIF v_action = 'mincutCancel' THEN
		v_message = '{"text": "Mincut to cancel not found.", "level": 2}';
		IF (SELECT id FROM om_mincut WHERE id = v_mincut) IS NOT NULL THEN 
			if (select mincut_state from om_mincut where id = v_mincut) = 4 then
				DELETE FROM om_mincut WHERE id = v_mincut;
			else 
				update om_mincut set mincut_state = 3 where id = v_mincut;
			end if;
			v_message = '{"text": "Mincut cancelled.", "level": 1}';
		END IF;
	
	ELSIF v_action = 'mincutDelete' THEN
		v_message = '{"text": "Mincut to delete not found.", "level": 2}';
		IF (SELECT id FROM om_mincut WHERE id = v_mincut) IS NOT NULL THEN 
			DELETE FROM om_mincut WHERE id = v_mincut;
			v_message = '{"text": "Mincut deleted.", "level": 1}';
		END IF;
	END IF;

	-- build geojson
	IF v_device = 5 THEN 
		--v_om_mincut
		SELECT jsonb_agg(features.feature) INTO v_result
			FROM (
	  	SELECT jsonb_build_object(
	     'type',       'Feature',
	    'geometry',   ST_AsGeoJSON(anl_the_geom)::jsonb,
	    'properties', to_jsonb(row) - 'anl_the_geom' - 'srid',
	    'crs',concat('EPSG:',srid)
	  	) AS feature
	  	FROM (SELECT id, ST_AsText(anl_the_geom) as anl_the_geom, ST_SRID(anl_the_geom) as srid
	  	FROM  v_om_mincut) row) features;

		v_result := COALESCE(v_result, '{}');
		v_result_init = concat('{"geometryType":"Point", "features":',v_result, '}');
		
		--v_om_mincut_valve
		SELECT jsonb_agg(features.feature) INTO v_result
			FROM (
	  	SELECT jsonb_build_object(
	     'type',       'Feature',
	    'geometry',   ST_AsGeoJSON(the_geom)::jsonb,
	    'properties', to_jsonb(row) - 'the_geom' - 'srid',
	    'crs',concat('EPSG:',srid)
	  	) AS feature
	  	FROM (SELECT id, ST_AsText(the_geom) as the_geom, ST_SRID(the_geom) as srid
	  	FROM  v_om_mincut_valve) row) features;

		v_result := COALESCE(v_result, '{}');
		v_result_valve = concat('{"geometryType":"Point", "features":',v_result, '}');

		--v_om_mincut_node
		SELECT jsonb_agg(features.feature) INTO v_result
			FROM (
	  	SELECT jsonb_build_object(
	     'type',       'Feature',
	    'geometry',   ST_AsGeoJSON(the_geom)::jsonb,
	    'properties', to_jsonb(row) - 'the_geom' - 'srid',
	    'crs',concat('EPSG:',srid)
	  	) AS feature
	  	FROM (SELECT id, ST_AsText(the_geom) as the_geom, ST_SRID(the_geom) as srid
	  	FROM  v_om_mincut_node) row) features;

		v_result := COALESCE(v_result, '{}');
		v_result_node = concat('{"geometryType":"Point", "features":',v_result, '}');

		--v_om_mincut_connec
		SELECT jsonb_agg(features.feature) INTO v_result
			FROM (
	  	SELECT jsonb_build_object(
	     'type',       'Feature',
	    'geometry',   ST_AsGeoJSON(the_geom)::jsonb,
	    'properties', to_jsonb(row) - 'the_geom' - 'srid',
	    'crs',concat('EPSG:',srid)
	  	) AS feature
	  	FROM (SELECT id, ST_AsText(the_geom) as the_geom, ST_SRID(the_geom) as srid
	  	FROM  v_om_mincut_connec) row) features;

		v_result := COALESCE(v_result, '{}');
		v_result_connec = concat('{"geometryType":"Point", "features":',v_result, '}');

		--v_om_mincut_arc
		SELECT jsonb_agg(features.feature) INTO v_result
			FROM (
	  	SELECT jsonb_build_object(
	     'type',       'Feature',
	    'geometry',   ST_AsGeoJSON(the_geom)::jsonb,
	    'properties', to_jsonb(row) - 'the_geom' - 'srid',
	    'crs',concat('EPSG:',srid)
	  	) AS feature
	  	FROM (SELECT id, arc_id, ST_AsText(the_geom) as the_geom, ST_SRID(the_geom) as srid
	  	FROM  v_om_mincut_arc) row) features;

		v_result := COALESCE(v_result, '{}');
		v_result_arc = concat('{"geometryType":"LineString", "features":',v_result, '}');

	END IF;

	v_message = COALESCE(v_message, '{}');

	v_response = ('{
	    "status": "Accepted",
        "message": ' || v_message || ',
	    "version": "' || v_version || '",
	    "body": {
	      "form": {},
	      "feature": {},
	      "data": {
	        "mincutId": ' || v_mincut ||','||
			  '"mincutInit":'||v_result_init||','||
			  '"valve":'||v_result_valve||','||
			  '"mincutNode":'||v_result_node||','||
			  '"mincutConnec":'||v_result_connec||','||
			  '"mincutArc":'||v_result_arc||','||
			  '"tiled":'||v_tiled|| '
	      }
	    }
	}');

	return v_response::json;
	
	--  Exception handling
	EXCEPTION WHEN OTHERS THEN
	GET STACKED DIAGNOSTICS v_error_context = pg_exception_context;  
	RETURN ('{"status":"Failed", "SQLERR":' || to_json(SQLERRM) || ',"SQLCONTEXT":' || to_json(v_error_context) || ',"SQLSTATE":' || to_json(SQLSTATE) || '}')::json;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;