/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;

UPDATE config_toolbox SET inputparams='[
  {
    "widgetname": "netscenario",
    "label": "Source netscenario:",
    "widgettype": "combo",
    "datatype": "text",
    "tooltip": "Select mapzone dscenario from where data will be copied to demand dscenario",
    "layoutname": "grl_option_parameters",
    "layoutorder": 1,
    "dvQueryText": "select netscenario_id as id, name as idval from plan_netscenario where netscenario_type =''DMA'' order by name",
    "isNullValue": "true",
    "selectedId": ""
  },
  {
    "widgetname": "dscenario_demand",
    "label": "Target dscenario demand:",
    "widgettype": "combo",
    "datatype": "text",
    "tooltip": "Select demand dscenario where data will be inserted",
    "layoutname": "grl_option_parameters",
    "layoutorder": 3,
    "dvQueryText": "select dscenario_id as id, name as idval from cat_dscenario where dscenario_type =''DEMAND'' order by name",
    "isNullValue": "true",
    "selectedId": ""
  }
]'::json WHERE alias='Set pattern values on demand dscenario' AND id=3258;

-- 2024/3/23
update config_form_fields set dv_isnullvalue = true  
where columnname in ('status','source_type','source_pattern_id','pattern_id','curve_id','mixing_model','energy_pattern_id','effic_curve_id','pump_type','valv_type') 
and formname like '%dscenario%';

update config_form_fields set widgetcontrols = (replace(widgetcontrols::text, '"nullValue":false','"nullValue":true'))::json 
where columnname in ('status','source_type','source_pattern_id','pattern_id','curve_id','mixing_model','energy_pattern_id','effic_curve_id','pump_type','valv_type', 'expl_id') 
and formname like '%dscenario%';

UPDATE sys_param_user SET vdefault = replace(vdefault, '"removeDemandOnDryNodes":false', '"delDryNetwork":false, "removeDemandOnDryNodes":true') 
WHERE id = 'inp_options_debug';

UPDATE config_toolbox SET inputparams =
'[{"widgetname":"exploitation", "label":"Exploitation id:","widgettype":"text","datatype":"json","layoutname":"grl_option_parameters","layoutorder":1, "placeholder":"1,2", "value":""}, 
{"widgetname":"usePsectors", "label":"Use masterplan psectors:","widgettype":"check","datatype":"boolean","layoutname":"grl_option_parameters","layoutorder":6, "value":""}, 
{"widgetname":"commitChanges", "label":"Commit changes:","widgettype":"check","datatype":"boolean","layoutname":"grl_option_parameters","layoutorder":7, "value":""}, 
{"widgetname":"updateMapZone", "label":"Update mapzone geometry method:","widgettype":"combo","datatype":"integer","layoutname":"grl_option_parameters","layoutorder":8,"comboIds":[0,1,2,3], "comboNames":["NONE", "CONCAVE POLYGON", "PIPE BUFFER", "PLOT & PIPE BUFFER"], "selectedId":""}, 
{"widgetname":"geomParamUpdate", "label":"Geometry parameter:","widgettype":"text","datatype":"float","layoutname":"grl_option_parameters","layoutorder":10, "isMandatory":false, "placeholder":"5-30", "value":""},
{"widgetname":"ignoreBrokenValves", "label":"Ignore Broken Valves (only when open):","widgettype":"check","datatype":"boolean","layoutname":"grl_option_parameters","layoutorder":11, "isMandatory":false, "placeholder":"", "value":""}
]'
WHERE id = 2706;


drop table if exists ext_node;
delete from sys_table where id = 'ext_node';

drop table if exists  ext_arc;
delete from sys_table where id = 'ext_arc';

DROP TABLE if exists inp_value_yesnofull;
DELETE FROM sys_table where id = 'inp_value_yesnofull';