/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;

--2022/09/29
INSERT INTO config_param_system(parameter, value, descript, label,  isenabled, layoutorder, project_type, datatype, widgettype, layoutname)
VALUES ('utils_graphanalytics_status','{"DRAINZONE":true}', 'Dynamic mapzones', 'Dynamic mapzones', TRUE, 12, 'utils', 
'json', 'text', 'lyt_admin_om') ON CONFLICT (parameter) DO NOTHING;


INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, 
datatype, widgettype, label, ismandatory, isparent, iseditable, isautoupdate,  widgetcontrols,  hidden)
SELECT distinct on (formname) formname, 'form_feature', 'data', 'drainzone_id', 'lyt_data_1', max(layoutorder)+1,
'integer', 'text', 'drainzone_id', false, false, false, false, '{"setMultiline":false}', false
FROM ud_sample35.config_form_fields 
WHERE (formname ilike 've_%' or formname in('v_edit_node', 'v_edit_arc', 'v_edit_connec', 'v_edit_gully')) and formname !='ve_config_sysfields' 
group by formname;

INSERT INTO sys_function(id, function_name, project_type, function_type, input_params, return_type, descript, sys_role, sample_query, source)
VALUES (2710, 'gw_fct_graphanalytics_mapzones', 'utils', 'function', 'json', 'json', 'Function to analyze graph of network. Multiple analysis is avaliable. Dynamic analisys to sectorize network using the flow traceability function. 
Before work with this funcion it is mandatory to configurate field graph_delimiter on node_type and field graphconfig on [dma, sector, cat_presszone and dqa] tables',
'role_om',null,'core')  ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_function(id, function_name, project_type, function_type, input_params, return_type, descript, sys_role, sample_query, source)
VALUES (2768, 'gw_fct_graphanalytics_mapzones_advanced', 'utils', 'function', 'json', 'json', 'Function to analyze network as a graph. Multiple analysis is avaliable (SECTOR, DQA, PRESSZONE & DMA). Before start you need to configurate:
- Field graph_delimiter on [cat_feature_node] table. 
- Field graphconfig on [dma, sector, cat_presszone and dqa] tables.
- Enable status for variable utils_graphanalytics_status on [config_param_system] table.
Stop your mouse over labels for more information about input parameters.
This function could be automatic triggered by valve status (open or closed) by configuring utils_graphanalytics_automatic_trigger variable on [config_param_system] table.',
'role_master',null,'core')  ON CONFLICT (id) DO NOTHING;

INSERT INTO config_toolbox(id, alias, functionparams, inputparams, observ, active)
VALUES (2768, 'Mapzones analysis', '{"featureType":[]}', '[
{"widgetname":"graphClass", "label":"Graph class:", "widgettype":"combo","datatype":"text","tooltip": "Graphanalytics method used", "layoutname":"grl_option_parameters","layoutorder":1,"comboIds":["DRAINZONE"],
"comboNames":["Drainage area (DRAINZONE)"], "selectedId":""}, 
{"widgetname":"exploitation", "label":"Exploitation:","widgettype":"combo","datatype":"text","tooltip": "Choose exploitation to work with", "layoutname":"grl_option_parameters","layoutorder":2, 
"dvQueryText":"select expl_id as id, name as idval from exploitation where active is not false order by name", "selectedId":"$userExploitation"},
{"widgetname":"floodOnlyMapzone", "label":"Flood only one mapzone: (*)","widgettype":"linetext","datatype":"text", "isMandatory":false, "tooltip":"Flood only identified mapzones. The purpose of this is update only network elements affected by this flooding keeping rest of network as is. Recommended to gain performance when mapzones ecosystem is under work", "placeholder":"1001", "layoutname":"grl_option_parameters","layoutorder":3, "value":""},
{"widgetname":"floodFromNode", "label":"Flood from node: (*)","widgettype":"linetext","datatype":"text", "isMandatory":false, "tooltip":"Optative parameter to constraint algorithm to work only flooding from any node on network, used to define only the related mapzone", "placeholder":"1015", "layoutname":"grl_option_parameters","layoutorder":4, "value":""},
{"widgetname":"forceOpen", "label":"Force open nodes: (*)","widgettype":"linetext","datatype":"text", "isMandatory":false, "tooltip":"Optative node id(s) to temporary open closed node(s) in order to force algorithm to continue there", "placeholder":"1015,2231,3123", "layoutname":"grl_option_parameters","layoutorder":5, "value":""},
{"widgetname":"forceClosed", "label":"Force closed nodes: (*)","widgettype":"text","datatype":"text", "isMandatory":false, "tooltip":"Optative node id(s) to temporary close open node(s) to force algorithm to stop there","placeholder":"1015,2231,3123", "layoutname":"grl_option_parameters","layoutorder":6,"value":""},
{"widgetname":"usePlanPsector", "label":"Use selected psectors:", "widgettype":"check","datatype":"boolean","tooltip":"If true, use selected psectors. If false ignore selected psectors and only works with on-service network" , "layoutname":"grl_option_parameters","layoutorder":7,"value":""},
{"widgetname":"commitChanges", "label":"Commit changes:", "widgettype":"check","datatype":"boolean","tooltip":"If true, changes will be applied to DB. If false, algorithm results will be saved in anl tables" , "layoutname":"grl_option_parameters","layoutorder":8,"value":""},
{"widgetname":"valueForDisconnected", "label":"Value for disconn. and conflict: (*)","widgettype":"linetext","datatype":"text", "isMandatory":false, "tooltip":"Value to use for disconnected features. Usefull for work in progress with dynamic mpzonesnode" , "placeholder":"", "layoutname":"grl_option_parameters","layoutorder":9, "value":""},
{"widgetname":"updateMapZone", "label":"Mapzone constructor method:","widgettype":"combo","datatype":"integer","layoutname":"grl_option_parameters","layoutorder":10,
"comboIds":[0,1,2,3,4], "comboNames":["NONE", "CONCAVE POLYGON", "PIPE BUFFER", "PLOT & PIPE BUFFER", "LINK & PIPE BUFFER"], "selectedId":""}, 
{"widgetname":"geomParamUpdate", "label":"Pipe buffer","widgettype":"text","datatype":"float","tooltip":"Buffer from arcs to create mapzone geometry using [PIPE BUFFER] options. Normal values maybe between 3-20 mts.", "layoutname":"grl_option_parameters","layoutorder":11, "isMandatory":false, "placeholder":"5-30", "value":""}
]',NULL, TRUE) ON CONFLICT (id) DO NOTHING;