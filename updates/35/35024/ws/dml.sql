/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;

--2022/04/06
INSERT INTO config_form_fields(formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, 
placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, 
dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden)
SELECT 'v_edit_inp_dscenario_rules', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, 
placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, 
dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden
FROM config_form_fields WHERE formname='v_edit_inp_rules';

INSERT INTO config_form_fields(formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, 
placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, 
dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden)
SELECT 'v_edit_inp_dscenario_rules', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, 
placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, 
dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden
FROM config_form_fields WHERE columnname='dscenario_id' AND formname='v_edit_inp_dscenario_junction';

INSERT INTO sys_table(id, descript, sys_role,  context, orderby, alias, source)
VALUES ('inp_dscenario_rules', '"Table to manage scenario for rules"', 'role_epa', null,null,NULL, 'core');

INSERT INTO sys_table(id, descript, sys_role,  context, orderby, alias, source)
VALUES ('v_edit_inp_dscenario_rules', '"Editable view to manage scenario for rules"', 'role_epa',  '{"level_1":"EPA","level_2":"DSCENARIO"}',16, 'Rules Dscenario', 
'core');

INSERT INTO inp_typevalue (typevalue, id, idval)
VALUES ('inp_value_demandtype',3,'HYDRANT');

INSERT INTO sys_table(id, descript, sys_role,  context, orderby, alias, source)
VALUES ('crm_zone', 'Table with polygonal geometry to relate connecs to a map zone about crm', 'role_basic', null,null,NULL, 'core');

--2022/04/17
DELETE FROM sys_table WHERE id = 'rtc_scada_node';
DELETE FROM sys_table WHERE id = 'rtc_scada_x_sector';
DELETE FROM sys_table WHERE id = 'rtc_scada_x_dma';

INSERT INTO sys_table (id, descript, sys_role, criticity, source)
VALUES ('om_waterbalance_dma_graf', 'Table to manage graf for dma', 'role_basic', 0, 'core') 
ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_table (id, descript, sys_role, criticity, source)
VALUES ('ext_rtc_scada', 'Table to manage scada assets', 'role_basic', 0, 'core') 
ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_table (id, descript, sys_role, criticity, source)
VALUES ('ext_rtc_scada_x_data', 'Table to manage scada values (aggregated by period', 'role_basic', 0, 'core') 
ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_table (id, descript, sys_role, criticity, source)
VALUES ('om_waterbalance', 'Table to manage water balance values according IWA standards by period and DMA', 'role_om', 0, 'core') 
ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_table (id, descript, sys_role, criticity, source)
VALUES ('v_om_waterbalance', 'View to show water balance values according IWA standards by period and DMA', 'role_om', 0, 'core') 
ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_table (id, descript, sys_role, criticity, source)
VALUES ('v_om_waterbalance_loss', 'View to show water losses values according IWA standards by period and DMA', 'role_om', 0, 'core') 
ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_table (id, descript, sys_role, criticity, source)
VALUES ('v_om_waterbalance_nrw', 'View to show non-revenue water values according IWA standards by period and DMA', 'role_om', 0, 'core') 
ON CONFLICT (id) DO NOTHING;

UPDATE config_report SET id = 102 WHERE alias  = 'Water consumption by period and dma';

DELETE FROM config_report WHERE id = 100;
INSERT INTO config_report(id, alias, query_text, vdefault, filterparam, sys_role)
VALUES (100, 'Pipe length by Exploitation and Catalog', 
'SELECT name as "Exploitation", arccat_id as "Arc Catalog", sum(gis_length) as "Length" FROM v_edit_arc JOIN exploitation USING (expl_id) GROUP BY arccat_id, name',
'{"orderBy":"1", "orderType": "DESC"}',
'[{"columnname":"Exploitation", "label":"Exploitation:", "widgettype":"combo","datatype":"text","layoutorder":1,
"dvquerytext":"Select name as id, name as idval FROM exploitation WHERE expl_id > 0 ORDER BY name","isNullValue":"true"},
{"columnname":"Arc Catalog", "label":"Arc catalog:", "widgettype":"combo","datatype":"text","layoutorder":2,
"dvquerytext":"Select id as id, id as idval FROM cat_arc WHERE id IS NOT NULL ORDER BY id","isNullValue":"true"}]',
'role_basic');

DELETE FROM config_report WHERE id = 101;
INSERT INTO config_report(id, alias, query_text, vdefault, filterparam, sys_role)
VALUES (101, 'Connecs by Exploitation', 
'SELECT name as "Exploitation", connec_id, code, customer_code FROM v_edit_connec JOIN exploitation USING (expl_id) ',
'{"orderBy":"1", "orderType": "DESC"}',
'[{"columnname":"Exploitation", "label":"Exploitation:", "widgettype":"combo","datatype":"text","layoutorder":1,
"dvquerytext":"Select name as id, name as idval FROM exploitation WHERE expl_id IS NOT NULL ORDER BY name","isNullValue":"true"}]',
'role_basic');

DELETE FROM config_report WHERE id = 102;
INSERT INTO config_report(id, alias, query_text, vdefault, filterparam, sys_role)
VALUES (102, 'Input Water by Exploitation, Dma & period', 
'SELECT exploitation as "Exploitation", period "Period", dma as "Dma", total as "Input Water" FROM v_om_waterbalance',
'{"orderBy":"1", "orderType": "DESC"}',
'[{"columnname":"Exploitation", "label":"Exploitation:", "widgettype":"combo","datatype":"text","layoutorder":1,
"dvquerytext":"Select name as id, name as idval FROM exploitation WHERE expl_id > 0 ORDER BY name","isNullValue":"true"},
{"columnname":"Dma", "label":"Dma:", "widgettype":"combo","datatype":"text","layoutorder":3,
"dvquerytext":"Select name as id, name as idval FROM dma WHERE dma_id != -1 and dma_id!=0 ORDER BY name","isNullValue":"true"},
{"columnname":"Period", "label":"Period:", "widgettype":"combo","datatype":"text","layoutorder":2,
"dvquerytext":"Select code as id, code as idval FROM ext_cat_period WHERE id IS NOT NULL ORDER BY code","isNullValue":"true"}
]',
'role_om');


DELETE FROM config_report WHERE id = 103;
INSERT INTO config_report(id, alias, query_text, vdefault, filterparam, sys_role)
VALUES (103, 'NRW by Exploitation, Dma & Period', 
'SELECT exploitation as "Exploitation", dma as "Dma", period as "Period", rw as "Revenue Water", nrw as "NRW", eff as "Efficiency" FROM v_om_waterbalance_nrw',
'{"orderBy":"1", "orderType": "DESC"}',
'[{"columnname":"Exploitation", "label":"Exploitation:", "widgettype":"combo","datatype":"text","layoutorder":1,
"dvquerytext":"Select name as id, name as idval FROM exploitation WHERE expl_id > 0 ORDER BY name","isNullValue":"true"},
{"columnname":"Dma", "label":"Dma:", "widgettype":"combo","datatype":"text","layoutorder":2,
"dvquerytext":"Select name as id, name as idval FROM dma WHERE dma_id != -1 and dma_id!=0 ORDER BY name","isNullValue":"true"},
{"columnname":"Period", "label":"Period:", "widgettype":"combo","datatype":"text","layoutorder":1,
"dvquerytext":"Select code as id, code as idval FROM ext_cat_period WHERE id IS NOT NULL ORDER BY code","isNullValue":"true"}]',
'role_om');


DELETE FROM config_report WHERE id = 104;
INSERT INTO config_report(id, alias, query_text, vdefault, filterparam, sys_role)
VALUES (104, 'Losses by Exploitation, Dma and Period', 
'SELECT exploitation as "Exploitation", dma as "Dma", period as "Period", auth as "Auth. Consumption", loss as "Water Losses", eff as "Efficiency" FROM v_om_waterbalance_loss',
'{"orderBy":"1", "orderType": "DESC"}',
'[{"columnname":"Exploitation", "label":"Exploitation:", "widgettype":"combo","datatype":"text","layoutorder":1,
"dvquerytext":"Select name as id, name as idval FROM exploitation WHERE expl_id > 0 ORDER by name","isNullValue":"true"},
{"columnname":"Dma", "label":"Dma:", "widgettype":"combo","datatype":"text","layoutorder":2,
"dvquerytext":"Select name as id, name as idval FROM dma WHERE dma_id != -1 and dma_id!=0 ORDER BY name","isNullValue":"true"},
{"columnname":"Period", "label":"Period:", "widgettype":"combo","datatype":"text","layoutorder":1,
"dvquerytext":"Select code as id, code as idval FROM ext_cat_period WHERE id IS NOT NULL ORDER BY code","isNullValue":"true"}]',
'role_om');

DELETE FROM config_param_system where parameter  = 'utils_grafanalytics_vdefault';
INSERT INTO config_param_system VALUES('utils_grafanalytics_vdefault', '{"DMA":{"updateMapZone":2, "geomParamUpdate":30}, "SECTOR":{"updateMapZone":2, "geomParamUpdate":30}, 
"PRESSZONE":{"updateMapZone":2, "geomParamUpdate":30}, "MINSECTOR":{"updateMapZone":2, "geomParamUpdate":30}, "DQA":{"updateMapZone":2, "geomParamUpdate":30}}'::json, 
'Automatic values for geometry trigger mapzone algorithm');

INSERT INTO sys_fprocess(fid, fprocess_name, project_type, parameters, source, isaudit, fprocess_type)
VALUES (441, 'Water balance calculation','ws',null, 'core', false, 'Function process')
ON CONFLICT (fid) DO NOTHING;

INSERT INTO sys_function(id, function_name, project_type, function_type, input_params, return_type, descript, sys_role, sample_query, source)
VALUES (3142, 'gw_fct_waterbalance', 'ws', 'function', NULL, 'json', 'Function to calculate water balance according stardards of IWA.', 'role_master', NULL, 'core')
ON CONFLICT (id) DO NOTHING;

DELETE FROM config_toolbox WHERE id=3142;
INSERT INTO config_toolbox(id, alias, functionparams, inputparams, observ, active)
VALUES (3142, 'Water balance by Exploitation and Period', '{"featureType":[]}', '[
{"widgetname":"executeGrafDma", "label":"Execute Graf for DMA:", "widgettype":"check","datatype":"boolean","tooltip":"If true, grafaanalytics mapzones will be triggered for DMA and expl selected" , "layoutname":"grl_option_parameters","layoutorder":1,"value":""},
{"widgetname":"exploitation", "label":"Exploitation:","widgettype":"combo","datatype":"text", "isMandatory":true, "tooltip":"Dscenario type", "dvQueryText":"SELECT expl_id AS id, name as idval FROM v_edit_exploitation", "layoutname":"grl_option_parameters","layoutorder":2, "value":""},
{"widgetname":"period", "label":"Period:","widgettype":"combo","datatype":"text", "isMandatory":true, "tooltip":"Dscenario type", "dvQueryText":"SELECT id, code as idval FROM ext_cat_period ORDER BY code", "layoutname":"grl_option_parameters","layoutorder":3, "value":""}
]', NULL, true) 
ON CONFLICT (id) DO NOTHING;

UPDATE config_form_fields set widgetcontrols = 
'{"setMultiline": false, "valueRelation":{"nullValue":true, "layer": "v_edit_exploitation", "activated": true, "keyColumn": "expl_id", "valueColumn": "name", "filterExpression": null}}'
WHERE columnname = 'expl_id' and formname IN ('v_edit_inp_pattern', 'v_edit_inp_curve', 'v_edit_cat_dscenario');

INSERT INTO config_param_system(parameter, value, descript, label, isenabled, project_type)
VALUES ('edit_mapzones_set_lastupdate', FALSE, 'If true, value of lastupdate is updated on node, arc, connec features and set to the date of executing the algorithm.',
'Set lastupdate on mapzone process', FALSE, 'ws') ON CONFLICT (parameter) DO NOTHING;

INSERT INTO config_param_system (parameter, value, descript, isenabled, project_type) VALUES(
'epa_shortpipe_vdefault', '{"catfeatureId":["CHECK_VALVE"], "vdefault":{"minorloss":0.001, "status":"OPEN"}}', 
'Vdefault values for epa shortpipes. This parameter must be according the epa_default definition for all shortpipes', FALSE, 'ws');

UPDATE inp_typevalue SET idval = 'PDA' WHERE typevalue = 'inp_options_demand_model' and id = 'PDA';

UPDATE config_toolbox set functionparams = '[
{"widgetname":"grafClass", "label":"Graf class:", "widgettype":"combo","datatype":"text","tooltip": "Grafanalytics method used", "layoutname":"grl_option_parameters","layoutorder":1,"comboIds":["PRESSZONE","DQA","DMA","SECTOR"],
"comboNames":["Pressure Zonification (PRESSZONE)", "District Quality Areas (DQA) ", "District Metering Areas (DMA)", "Inlet Sectorization (SECTOR-HIGH / SECTOR-LOW)"], "selectedId":""}, 
{"widgetname":"exploitation", "label":"Exploitation:","widgettype":"combo","datatype":"text","tooltip": "Choose exploitation to work with", "layoutname":"grl_option_parameters","layoutorder":2, 
"dvQueryText":"select expl_id as id, name as idval from exploitation where active is not false order by name", "selectedId":"$userExploitation"},
{"widgetname":"floodOnlyMapzone", "label":"Flood only one mapzone: (*)","widgettype":"linetext","datatype":"text", "isMandatory":false, "tooltip":"Flood only identified mapzones. The purpose of this is update only network elements affected by this flooding keeping rest of network as is. Recommended to gain performance when mapzones ecosystem is under work", "placeholder":"1001", "layoutname":"grl_option_parameters","layoutorder":3, "value":""},
{"widgetname":"forceOpen", "label":"Force open nodes: (*)","widgettype":"linetext","datatype":"text", "isMandatory":false, "tooltip":"Optative node id(s) to temporary open closed node(s) in order to force algorithm to continue there", "placeholder":"1015,2231,3123", "layoutname":"grl_option_parameters","layoutorder":5, "value":""},
{"widgetname":"forceClosed", "label":"Force closed nodes: (*)","widgettype":"text","datatype":"text", "isMandatory":false, "tooltip":"Optative node id(s) to temporary close open node(s) to force algorithm to stop there","placeholder":"1015,2231,3123", "layoutname":"grl_option_parameters","layoutorder":6,"value":""},
{"widgetname":"usePlanPsector", "label":"Use selected psectors:", "widgettype":"check","datatype":"boolean","tooltip":"If true, use selected psectors. If false ignore selected psectors and only works with on-service network" , "layoutname":"grl_option_parameters","layoutorder":7,"value":""},
{"widgetname":"valueForDisconnected", "label":"Value for disconn. and conflict: (*)","widgettype":"linetext","datatype":"text", "isMandatory":false, "tooltip":"Value to use for disconnected features. Usefull for work in progress with dynamic mpzonesnode" , "placeholder":"", "layoutname":"grl_option_parameters","layoutorder":8, "value":""},
{"widgetname":"updateMapZone", "label":"Mapzone constructor method:","widgettype":"combo","datatype":"integer","layoutname":"grl_option_parameters","layoutorder":9,
"comboIds":[0,1,2,3,4], "comboNames":["NONE", "CONCAVE POLYGON", "PIPE BUFFER", "PLOT & PIPE BUFFER", "LINK & PIPE BUFFER"], "selectedId":""}, 
{"widgetname":"geomParamUpdate", "label":"Pipe buffer","widgettype":"text","datatype":"float","tooltip":"Buffer from arcs to create mapzone geometry using [PIPE BUFFER] options. Normal values maybe between 3-20 mts.", "layoutname":"grl_option_parameters","layoutorder":10, "isMandatory":false, "placeholder":"5-30", "value":""}
]' WHERE id=2768;

INSERT INTO sys_function(id, function_name, project_type, function_type, descript, sys_role,  source)
VALUES (3144, 'gw_trg_mincut', 'ws', 'trigger function', 'Trigger to fill mincut data', 'role_om','core')
ON CONFLICT (id) DO NOTHING;
