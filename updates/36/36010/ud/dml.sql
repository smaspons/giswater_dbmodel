/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;


-- 2024/3/23
update config_form_fields set dv_isnullvalue = true  
where columnname in ('arccat_id','curve_id','expl_id','flap','form_type','gate','lidco_id','matcat_id','ori_type','outfall_type','pattern_id','poll_id','rgage_type' ,'timser_id', 'weir_type')
and formname like '%dscenario%';

update config_form_fields set widgetcontrols = (replace(widgetcontrols::text, '"nullValue":false','"nullValue":true'))::json 
where columnname in ('arccat_id','curve_id','expl_id','flap','form_type','gate','lidco_id','matcat_id','ori_type','outfall_type','pattern_id','poll_id','rgage_type' ,'timser_id', 'weir_type') 
and formname like '%dscenario%';

update sys_param_user SET dv_isnullvalue = true where id = 'inp_options_setallraingages';
	
-- 09/04/2024
UPDATE config_toolbox SET inputparams='[
{"widgetname":"copyFrom", "label":"Copy from:", "widgettype":"combo", "datatype":"text", "dvQueryText":"SELECT hydrology_id as id, name as idval FROM cat_hydrology WHERE active IS TRUE", "layoutname":"grl_option_parameters","layoutorder":1, "selectedId":"$userDscenario"},
{"widgetname":"name", "label":"Name: (*)","widgettype":"linetext","datatype":"text", "isMandatory":true, "tooltip":"Name for hydrology scenario (mandatory)", "placeholder":"", "layoutname":"grl_option_parameters","layoutorder":2, "value":""},
{"widgetname":"infiltration", "label":"Infiltration:","widgettype":"combo","datatype":"text", "isMandatory":true, "tooltip":"Infiltration", "dvQueryText":"SELECT id, idval FROM inp_typevalue WHERE typevalue =''inp_value_options_in''", "layoutname":"grl_option_parameters","layoutorder":3, "value":""},
{"widgetname":"text", "label":"Text:","widgettype":"linetext","datatype":"text", "isMandatory":false, "tooltip":"Text of hydrology scenario", "placeholder":"", "layoutname":"grl_option_parameters","layoutorder":4, "value":""},
{"widgetname":"expl", "label":"Exploitation:","widgettype":"combo","datatype":"text", "isMandatory":true, "tooltip":"hydrology scenario type", "dvQueryText":"SELECT expl_id AS id, name as idval FROM v_edit_exploitation", "layoutname":"grl_option_parameters","layoutorder":5, "value":""},
{"widgetname":"active", "label":"Active:", "widgettype":"check", "datatype":"boolean", "tooltip":"If true, active" , "layoutname":"grl_option_parameters","layoutorder":6, "value":"true"}
]'::json WHERE id=3294;
