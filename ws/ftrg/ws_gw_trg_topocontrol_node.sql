/*
This file is part of Giswater
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/

--FUNCTION CODE: 1136

CREATE OR REPLACE FUNCTION SCHEMA_NAME.gw_trg_topocontrol_node() RETURNS trigger AS
$BODY$


DECLARE 
numNodes numeric;
psector_vdefault_var integer;
replace_node_aux boolean;
node_id_var varchar;
node_rec record;
v_querytext text;
arcrec Record; 
nodeRecord1 Record; 
nodeRecord2 Record; 
z1 double precision;
z2 double precision;
xvar double precision;
yvar double precision;
pol_id_var varchar;
v_arc record;
v_arcrecord "SCHEMA_NAME".v_edit_arc;
v_arcrecordtb "SCHEMA_NAME".arc;
v_plan_statetype_ficticius int2;
v_node_proximity_control boolean;
v_node_proximity double precision;
v_dsbl_error boolean;
v_psector_id integer;
v_tempvalue text;
v_mantable text;
v_epatable text;
v_manquerytext1 text;
v_manquerytext2 text;
v_epaquerytext1 text;
v_epaquerytext2 text;
v_schemaname text;
v_connec_id varchar;
v_linkrec record;
v_message text;
v_nodetype text;
v_staticpress double precision;
v_elevation double precision;
v_depth double precision;
v_elev  double precision;
v_trace_featuregeom boolean;

rec_addfields record;
v_sql text;
v_query_string_update text;
v_arc_childtable_name text;
v_arc_type text;
v_node_replace_code boolean;

BEGIN

    EXECUTE 'SET search_path TO '||quote_literal(TG_TABLE_SCHEMA)||', public';
    v_schemaname = 'SCHEMA_NAME';

	-- Get parameters
	SELECT ((value::json)->>'activated') INTO v_node_proximity_control FROM config_param_system WHERE parameter='edit_node_proximity';
	SELECT ((value::json)->>'value') INTO v_node_proximity FROM config_param_system WHERE parameter='edit_node_proximity';
	SELECT value::boolean INTO v_dsbl_error FROM config_param_system WHERE parameter='edit_topocontrol_disable_error' ;
	SELECT value INTO v_psector_id FROM config_param_user WHERE cur_user=current_user AND parameter = 'plan_psector_vdefault';
    SELECT value::boolean INTO v_node_replace_code FROM config_param_system WHERE parameter='plan_node_replace_code';

	--Check if user has migration mode enabled
	IF (SELECT value::boolean FROM config_param_user WHERE parameter='edit_disable_topocontrol' AND cur_user=current_user) IS TRUE THEN
		v_node_proximity_control = FALSE;
		v_dsbl_error = TRUE;
	END IF;

	-- For state=0
	IF NEW.state=0 THEN
		RAISE WARNING 'Topology is not enabled with state=0. The feature will be inserted but disconected of the network!';
		RETURN NEW;

	-- For state=1,2
	ELSE 
    	
		IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE ' THEN

			-- Checking conflict state=1 nodes (exiting vs new one)
			IF (NEW.state=1) AND (v_node_proximity_control IS TRUE) THEN

				-- check existing state=1 nodes
				SELECT * INTO node_rec FROM node WHERE ST_DWithin(NEW.the_geom, node.the_geom, v_node_proximity) AND node.node_id != NEW.node_id AND node.state=1;
				IF node_rec.node_id IS NOT NULL THEN
			
					IF v_dsbl_error IS NOT TRUE THEN
						EXECUTE 'SELECT gw_fct_getmessage($${"client":{"device":4, "infoType":1, "lang":"ES"},"feature":{},
						"data":{"message":"1097", "function":"1136","debug_msg":"'||NEW.node_id||'"}}$$);';
					ELSE

						SELECT concat('ERROR-',id,':',error_message,'.',hint_message) INTO v_message FROM sys_message WHERE id = 1097;
						INSERT INTO audit_log_data (fid, feature_id, log_message) VALUES (106, NEW.node_id, v_message);
					END IF;
				END IF;		

			-- Checking conflict state=2 nodes (exitings on same alternative vs new one)
			ELSIF (NEW.state=2) AND (v_node_proximity_control IS TRUE) THEN

				-- check existing state=2 nodes on same alternative
				SELECT * INTO node_rec FROM node JOIN plan_psector_x_node USING (node_id) WHERE ST_DWithin(NEW.the_geom, node.the_geom, v_node_proximity) 
				AND node.node_id != NEW.node_id AND node.state=2 AND psector_id=v_psector_id;
				
				IF node_rec.node_id IS NOT NULL THEN
			
					IF v_dsbl_error IS NOT TRUE THEN
						EXECUTE 'SELECT gw_fct_getmessage($${"client":{"device":4, "infoType":1, "lang":"ES"},"feature":{},
						"data":{"message":"1096", "function":"1136","debug_msg":"'||NEW.node_id||'"}}$$);';
					ELSE
						SELECT concat('ERROR-',id,':',error_message,'.',hint_message) INTO v_message FROM sys_message WHERE id = 1097;
						INSERT INTO audit_log_data (fid, feature_id, log_message) VALUES (106, NEW.node_id, v_message);
					END IF;
				END IF;		
			END IF;
					
			-- check for existing node (1)
			SELECT * INTO node_rec FROM node WHERE ST_DWithin(NEW.the_geom, node.the_geom, v_node_proximity) AND node.node_id != NEW.node_id AND node.state=1;

			IF (NEW.state=2 AND node_rec.node_id IS NOT NULL) THEN

				-- inserting on plan_psector_x_node the existing node as state=0
				INSERT INTO plan_psector_x_node (psector_id, node_id, state) VALUES (v_psector_id, node_rec.node_id, 0) ON CONFLICT (psector_id, node_id) DO NOTHING;

				-- looking for all the arcs (1 and 2) using existing node
				FOR v_arc IN (SELECT arc_id, node_1 as node_id FROM v_edit_arc WHERE node_1=node_rec.node_id AND state >0 
				UNION SELECT arc_id, node_2 FROM v_edit_arc WHERE node_2=node_rec.node_id AND state >0)		
				LOOP

					-- if exists some arc planified on same alternative attached to that existing node
					IF v_arc.arc_id IN (SELECT arc_id FROM plan_psector_x_arc JOIN arc USING (arc_id) WHERE psector_id=v_psector_id AND arc.state=2) THEN 
						
						-- reconnect the planified arc to the new planified node in spite of connected to the node state=1
						IF (SELECT node_1 FROM arc WHERE arc_id=v_arc.arc_id)=v_arc.node_id THEN
							UPDATE arc SET node_1=NEW.node_id WHERE arc_id=v_arc.arc_id AND node_1=node_rec.node_id;							
						ELSE
							UPDATE arc SET node_2=NEW.node_id WHERE arc_id=v_arc.arc_id AND node_2=node_rec.node_id;
						END IF;		
					ELSE
						-- getting values to create new 'ficticius' arc
						SELECT * INTO v_arcrecordtb FROM arc WHERE arc_id = v_arc.arc_id::text;
										
						-- refactoring values fo new one
						v_arcrecordtb.arc_id:= (SELECT nextval('urn_id_seq'));
						IF v_node_replace_code is false then
							v_arcrecordtb.code = v_arcrecordtb.arc_id;
						END IF;
						v_arcrecordtb.state=2;
						v_arcrecordtb.state_type := (SELECT (value::json->>'plan_statetype_ficticius')::smallint FROM config_param_system WHERE parameter='plan_statetype_vdefault');

						-- Get arctype
                        v_sql := 'SELECT arctype_id FROM cat_arc WHERE id = '''||v_arcrecordtb.arccat_id||''';';
                        EXECUTE v_sql
                        INTO v_arc_type;

						-- set temporary values for config variables in order to enable the insert of arc in spite of due a 'bug' of postgres it seems that does not recognize the new node inserted
						UPDATE config_param_user SET value=TRUE WHERE parameter = 'edit_disable_statetopocontrol' AND cur_user=current_user;				

						-- Insert new records into arc table
						INSERT INTO arc SELECT v_arcrecordtb.*;

						-- update real values of node_1 and node_2
						IF (SELECT node_1 FROM arc WHERE arc_id=v_arc.arc_id)=node_rec.node_id THEN
							v_arcrecordtb.node_1 = NEW.node_id;
						ELSE
							v_arcrecordtb.node_2 = NEW.node_id;
						END IF;
						
						UPDATE arc SET node_1=v_arcrecordtb.node_1, node_2=v_arcrecordtb.node_2 WHERE arc_id = v_arcrecordtb.arc_id;

						-- restore temporary values for edit_disable_statetopocontrol variable
						UPDATE config_param_user SET value=FALSE WHERE parameter = 'edit_disable_statetopocontrol' AND cur_user=current_user;

						-- getting table child information (man_table)
						v_mantable = (SELECT man_table FROM cat_feature_arc c JOIN sys_feature_cat s ON c.type = s.id JOIN v_edit_arc ON c.id=arc_type WHERE arc_id=v_arc.arc_id);
						v_epatable = (SELECT epa_table FROM cat_feature_arc c JOIN sys_feature_epa_type s ON epa_default = s.id JOIN v_edit_arc ON c.id=arc_type WHERE arc_id=v_arc.arc_id);
						
						-- building querytext for man_table
						v_querytext:= (SELECT replace (replace (array_agg(column_name::text)::text,'{',','),'}','') 
						FROM information_schema.columns WHERE table_name=v_mantable AND table_schema=v_schemaname AND column_name !='arc_id');
						IF  v_querytext IS NULL THEN 
							v_querytext='';
						END IF;
						v_manquerytext1 =  'INSERT INTO '||v_mantable||' SELECT ';
						v_manquerytext2 =  v_querytext||' FROM '||v_mantable||' WHERE arc_id= '||v_arc.arc_id||'::text';

						-- building querytext for epa_table
						v_querytext:= (SELECT replace (replace (array_agg(column_name::text)::text,'{',','),'}','') 
						FROM information_schema.columns WHERE table_name=v_epatable AND table_schema=v_schemaname AND column_name !='arc_id');
						IF  v_querytext IS NULL THEN 
							v_querytext='';
						END IF;
						v_epaquerytext1 =  'INSERT INTO '||v_epatable||' (arc_id' ||v_querytext||') SELECT ';
						v_epaquerytext2 =  v_querytext||' FROM '||v_epatable||' WHERE arc_id= '||v_arc.arc_id||'::text';
						
						-- insert new records into man_table
						EXECUTE v_manquerytext1||v_arcrecordtb.arc_id::text||v_manquerytext2;
				
						-- insert new records into epa_table
						EXECUTE v_epaquerytext1||v_arcrecordtb.arc_id::text||v_epaquerytext2;						
		
						--Copy addfields from old arc to new arcs
						v_arc_childtable_name := 'man_arc_' || lower(v_arc_type);
						IF (SELECT EXISTS ( SELECT 1 FROM information_schema.tables WHERE table_schema = v_schemaname AND table_name = v_arc_childtable_name)) IS TRUE THEN
							EXECUTE 'INSERT INTO '||v_arc_childtable_name||' (arc_id) VALUES ('''||v_arcrecordtb.arc_id||''');';

							v_sql := 'SELECT column_name FROM information_schema.columns 
									  WHERE table_schema = ''SCHEMA_NAME'' 
									  AND table_name = '''||v_arc_childtable_name||''' 
									  AND column_name !=''id'' AND column_name != ''arc_id'' ;';

							FOR rec_addfields IN EXECUTE v_sql
							LOOP
								v_query_string_update = 'UPDATE '||v_arc_childtable_name||' SET '||rec_addfields.column_name|| ' = '
														'( SELECT '||rec_addfields.column_name||' FROM '||v_arc_childtable_name||' WHERE arc_id = '||quote_literal(v_arc.arc_id)||' ) '
														'WHERE '||v_arc_childtable_name||'.arc_id = '||quote_literal(v_arcrecordtb.arc_id)||';';

								IF v_query_string_update IS NOT NULL THEN
									EXECUTE v_query_string_update;
								END IF;

							END LOOP;
						END IF;
																			
						-- Update doability for the new arc (false)
						UPDATE plan_psector_x_arc SET doable=FALSE, addparam='{"nodeReplace":"generated"}' 
						WHERE arc_id=v_arcrecordtb.arc_id AND psector_id=v_psector_id;

						-- insert old arc on the alternative
						UPDATE config_param_user SET value='false' WHERE parameter='edit_plan_order_control' AND cur_user=current_user;
					
						INSERT INTO plan_psector_x_arc (psector_id, arc_id, state, doable,addparam)
						VALUES (v_psector_id, v_arc.arc_id, 0, FALSE, '{"nodeReplace":"deprecated"}') ON CONFLICT (psector_id, arc_id) DO NOTHING;
					
						UPDATE config_param_user SET value='true' WHERE parameter='edit_plan_order_control' AND cur_user=current_user;

						-- update parent on node is not enabled
						
						-- manage connec linked feature
						FOR v_connec_id IN 
						SELECT connec_id FROM connec WHERE arc_id=v_arc.arc_id AND connec.state = 1
						LOOP
							INSERT INTO plan_psector_x_connec (connec_id, arc_id, psector_id, state, doable)
							SELECT connec_id, v_arcrecordtb.arc_id, v_psector_id, 1, false
							FROM link l JOIN connec c ON connec_id = l.feature_id WHERE l.feature_type  ='CONNEC' AND connec_id = v_connec_id
                            ON CONFLICT (connec_id, psector_id, state) DO NOTHING;
						
							INSERT INTO plan_psector_x_connec (connec_id, arc_id, psector_id, state, doable, link_id)
							SELECT connec_id, v_arc.arc_id, v_psector_id, 0, false, l.link_id
							FROM link l JOIN connec c ON connec_id = l.feature_id WHERE l.feature_type  ='CONNEC' AND connec_id = v_connec_id AND l.state=1
							ON CONFLICT (connec_id, psector_id, state) DO NOTHING;
						END LOOP;
					
						-- connecs without link but with arc_id
						FOR v_connec_id IN 
						SELECT connec_id FROM connec WHERE arc_id=v_arc.arc_id AND state = 1 AND connec_id 
						NOT IN (SELECT DISTINCT feature_id FROM link WHERE exit_id=v_arc.arc_id)
						LOOP
							INSERT INTO plan_psector_x_connec (connec_id, arc_id, psector_id, state, doable)
							SELECT connec_id, v_arcrecordtb.arc_id, v_psector_id, 1, false
							FROM connec WHERE connec_id = v_connec_id
                            ON CONFLICT (connec_id, psector_id, state) DO NOTHING;
						
							UPDATE plan_psector_x_connec SET link_id= NULL WHERE connec_id=v_connec_id;
							DELETE FROM link WHERE feature_id=v_connec_id;
						END LOOP;
						
					END IF;
				END LOOP;			
			END IF;	
					
		ELSIF TG_OP ='UPDATE' THEN
							
			-- Updating expl / dma
			IF (NEW.the_geom IS DISTINCT FROM OLD.the_geom)THEN   
				NEW.expl_id:= (SELECT expl_id FROM exploitation WHERE active IS TRUE AND ST_DWithin(NEW.the_geom, exploitation.the_geom,0.001) AND active IS TRUE  LIMIT 1);          
				NEW.sector_id:= (SELECT sector_id FROM sector WHERE ST_DWithin(NEW.the_geom, sector.the_geom,0.001) AND active IS TRUE  LIMIT 1);          
				NEW.dma_id := (SELECT dma_id FROM dma WHERE ST_DWithin(NEW.the_geom, dma.the_geom,0.001) AND active IS TRUE  LIMIT 1);   
			END IF;
				
			-- Updating polygon geometry in case of exists it
			pol_id_var:= (SELECT pol_id FROM polygon WHERE feature_id=OLD.node_id);
			v_trace_featuregeom:= (SELECT trace_featuregeom FROM polygon WHERE feature_id=OLD.node_id);
			IF (pol_id_var IS NOT NULL) AND (v_trace_featuregeom IS TRUE) THEN   
				xvar= (st_x(NEW.the_geom)-st_x(OLD.the_geom));
				yvar= (st_y(NEW.the_geom)-st_y(OLD.the_geom));		
				UPDATE polygon SET the_geom=ST_translate(the_geom, xvar, yvar) WHERE pol_id=pol_id_var;
			END IF; 

			IF (SELECT value::boolean FROM config_param_user WHERE cur_user=current_user AND parameter = 'edit_node2arc_update_disable') IS NOT TRUE THEN
				-- values of node
				v_nodetype = (SELECT nodetype_id FROM cat_node WHERE NEW.nodecat_id = id);
				v_staticpress = coalesce(NEW.staticpressure,0);
				v_elevation = NEW.elevation;
				v_depth = coalesce(NEW.depth,0);
										
				-- Select arcs with start-end on the updated node
				v_querytext := 'SELECT * FROM arc WHERE arc.node_1 = ' || quote_literal(NEW.node_id) || ' OR arc.node_2 = ' || quote_literal(NEW.node_id); 
				FOR arcrec IN EXECUTE v_querytext
				LOOP
					-- Initial and final node of the arc
					SELECT * INTO nodeRecord1 FROM v_node WHERE v_node.node_id = arcrec.node_1;
					SELECT * INTO nodeRecord2 FROM v_node WHERE v_node.node_id = arcrec.node_2;

					-- Control de lineas de longitud 0
					IF (nodeRecord1.node_id IS NOT NULL) AND (nodeRecord2.node_id IS NOT NULL) THEN

						-- Update arc node coordinates, node_id and direction
						IF (nodeRecord1.node_id = NEW.node_id) THEN

							-- update arc
							IF v_elevation IS NOT NULL THEN
								EXECUTE 'UPDATE arc SET
									elevation1 = '|| v_elevation ||',
									depth1 = '|| v_depth||',
									staticpress1 = '|| v_staticpress ||' 
									WHERE arc_id = ' || quote_literal(arcrec."arc_id");
							END IF;
							
							EXECUTE 'UPDATE arc SET	nodetype_1 = '|| quote_literal(v_nodetype) ||', 
							the_geom = ST_SetPoint($1, 0, $2) WHERE arc_id = ' || quote_literal(arcrec."arc_id") 
							USING arcrec.the_geom, NEW.the_geom; 

						ELSIF (nodeRecord2.node_id = NEW.node_id) THEN

							-- update arc
							IF v_elevation IS NOT NULL THEN
								EXECUTE 'UPDATE arc SET
									elevation2 = '|| v_elevation ||',
									depth2 = '|| v_depth||',
									staticpress2 = '|| v_staticpress ||' 
									WHERE arc_id = ' || quote_literal(arcrec."arc_id");
							END IF;					
						
							EXECUTE 'UPDATE arc SET nodetype_2 = '|| quote_literal(v_nodetype) ||',
							the_geom = ST_SetPoint($1, ST_NumPoints($1) - 1, $2) WHERE arc_id = ' || quote_literal(arcrec."arc_id") 
							USING arcrec.the_geom, NEW.the_geom; 
						END IF;
					END IF;
				
				--update links
				v_querytext:= 'SELECT * FROM link WHERE link.exit_id= ' || quote_literal(NEW.node_id) || ' AND exit_type=''NODE''';

				FOR v_linkrec IN EXECUTE v_querytext
				LOOP
					-- Coordinates
					EXECUTE 'UPDATE link SET the_geom = ST_SetPoint($1, ST_NumPoints($1) - 1, $2) WHERE link_id = ' || quote_literal(v_linkrec."link_id")
					USING v_linkrec.the_geom, NEW.the_geom;
				END LOOP;
				END LOOP; 
			END IF;
		END IF;
				
	END IF;
	
RETURN NEW;
    
END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

