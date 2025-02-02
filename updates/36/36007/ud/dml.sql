/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;


-- 20/12/2023
DROP TRIGGER IF EXISTS gw_trg_typevalue_fk ON cat_arc_shape;
ALTER TABLE cat_arc_shape DROP CONSTRAINT cat_arc_shape_check;
INSERT INTO cat_arc_shape VALUES ('UNKNOWN','UNKNOWN') ON CONFLICT (id) DO NOTHING;
ALTER TABLE cat_arc_shape ADD CONSTRAINT cat_arc_shape_check CHECK (epa::text = ANY (ARRAY['VERT_ELLIPSE'::character varying::text, 'ARCH'::character varying::text, 'BASKETHANDLE'::character varying::text, 'CIRCULAR'::character varying::text, 'CUSTOM'::character varying::text, 'DUMMY'::character varying::text, 'EGG'::character varying::text, 'FILLED_CIRCULAR'::character varying::text, 'FORCE_MAIN'::character varying::text, 'HORIZ_ELLIPSE'::character varying::text, 'HORSESHOE'::character varying::text, 'IRREGULAR'::character varying::text, 'MODBASKETHANDLE'::character varying::text, 'PARABOLIC'::character varying::text, 'POWER'::character varying::text, 'RECT_CLOSED'::character varying::text, 'RECT_OPEN'::character varying::text, 'RECT_ROUND'::character varying::text, 'RECT_TRIANGULAR'::character varying::text, 'SEMICIRCULAR'::character varying::text, 'SEMIELLIPTICAL'::character varying::text, 'TRAPEZOIDAL'::character varying::text, 'TRIANGULAR'::character varying::text, 'VIRTUAL'::character varying::text, 'UNKNOWN'::character varying::text]));

UPDATE cat_arc SET shape = 'UNKNOWN' WHERE shape is null;
ALTER TABLE cat_arc ALTER COLUMN shape SET NOT NULL;

INSERT INTO inp_typevalue VALUES ('inp_options_networkmode_', '3', '1D/2D SWMM-IBER WET');

UPDATE config_toolbox set inputparams = (replace(inputparams::text, '"$userExploitation"', '""'))::json where id = 2768;

-- 15/01/2024
update config_form_fields set tabname = 'tab_epa' where formname like 've_epa%' and tabname = 'tab_none';
update config_form_fields set dv_isnullvalue = true where tabname = 'tab_epa' and formname = 've_epa_orifice' and columnname in ('ori_type', 'shape', 'flap');
update config_form_fields set dv_isnullvalue = true where tabname = 'tab_epa' and formname = 've_epa_weir' and columnname in ('weir_type', 'flap');
update config_form_fields set dv_isnullvalue = true where tabname = 'tab_epa' and formname = 've_epa_pump' and columnname in ('curve_id', 'status');
update config_form_fields set dv_isnullvalue = true where tabname = 'tab_epa' and formname = 've_epa_outlet' and columnname in ('outlet_type', 'curve_id', 'flap');


INSERT INTO sys_function (id, function_name, project_type, function_type, input_params, return_type, descript, sys_role, sample_query, "source") 
VALUES(3298, 'gw_fct_import_inp_dwf', 'ud', 'function', 'json', 'json', 'Function to import DWF values. ', 'role_epa', NULL, 'core')
ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_fprocess (fid, fprocess_name, project_type, parameters, "source", isaudit, fprocess_type, addparam) 
VALUES(527, 'Import dwf values', 'ud', NULL, 'core' , NULL, 'Function process', NULL)
ON CONFLICT (fid) DO NOTHING;

INSERT INTO config_csv (fid, alias, descript, functionname, active, orderby, addparam) 
VALUES(527, 'Import DWF', 'Function to import DWF values. The CSV file must contain the following columns in the exact same order:   dwfscenario_id, node_id, value, pat1, pat2, pat3, pat4', 'gw_fct_import_inp_dwf', true, 21, NULL)
ON CONFLICT (fid) DO NOTHING;

INSERT INTO config_param_system SELECT 'utils_graphanalytics_style', style::text, 'There are 3 "mode" to symbolize mapzones when the project is loaded or mapzones are recalculated: 
- Disabled: do nothing with the style
- Random: use "column" data to categorize and set random colors to every mapzone
- Stylesheet: use "column" data to categorize and set the configured color to every mapzone from mapzone table stylesheet column',
'Mapzones style config:', NULL, NULL, true, 13, 'utils', null, null, 'json', 'linetext', true, true, null, null, null, null, null, null, 'lyt_admin_om'
FROM config_function WHERE id=2928;

UPDATE config_param_system SET value = '{"DRAINZONE":{"mode":"Disable", "column":"name"},"SECTOR":{"mode":"Disable", "column":"name"},"DMA":{"mode":"Disable", "column":"name"}}'
WHERE parameter='utils_graphanalytics_style';

DELETE FROM config_function WHERE id=2928;

UPDATE config_form_fields SET layoutname='lyt_data_1', tabname='tab_data' WHERE formname LIKE 've_gully%' AND columnname LIKE 'connec_y%' AND tabname='tab_none';

-- 22/01/2024
UPDATE config_form_fields SET widgetfunction='{"functionName": "open_selected_path", "parameters":{"targetwidget":"tab_hydrometer_tbl_hydrometer", "columnfind": "hydrometer_link"}}'::json WHERE columnname='btn_link' AND tabname='tab_hydrometer';

--25/01/24
UPDATE sys_table SET id='v_edit_inp_subc2outlet' where id='vi_subcatch2outlet'; 

INSERT INTO sys_function (id, function_name, project_type, function_type, input_params, return_type, descript, sys_role, sample_query, "source") 
VALUES(3300, 'gw_trg_edit_inp_subc2outlet', 'ud', 'trigger function', NULL, NULL, NULL, 'role_master', NULL, 'core')
ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_message (id, error_message, hint_message, log_level, show_user, project_type, "source") 
VALUES(3252, 'There is no subcatchment or outlet_id nearby', 'Place the line inside a subcatchment or use the snapping tool to set an outlet_id for the subcatchment.', 2, true, 'utils', 'core')
ON CONFLICT (id) DO NOTHING;

UPDATE sys_function SET descript ='Function to analyze graph of network. Dynamic analisys to sectorize network using the flow traceability function. 
Before working with this funcion, it is mandatory to configurate graphconfig on drainzone table'
WHERE function_name='gw_fct_graphanalytics_mapzones';

UPDATE sys_function SET descript='Function to analyze network as a graph. Analysis is only avaliable for DRAINZONE. Before starting, you need to configurate:
- Field graphconfig on drainzone table.
- Enable status for variable utils_graphanalytics_status on [config_param_system] table.
Stop your mouse over labels for more information about input parameters.'
WHERE function_name='gw_fct_graphanalytics_mapzones_advanced';

INSERT INTO sys_fprocess (fid, fprocess_name, project_type, parameters, "source", isaudit, fprocess_type, addparam)
VALUES(528, 'Check outlet_id existance in inp_subcatchment and inp_junction', 'ud', NULL, 'core', true, 'Check epa-data', NULL)
ON CONFLICT (fid) DO NOTHING;

INSERT INTO sys_fprocess (fid, fprocess_name, project_type, parameters, "source", isaudit, fprocess_type, addparam) 
VALUES(529, 'Check missing data in Inp Weir', 'ud', NULL, 'core', true, 'Check epa-data', NULL)
ON CONFLICT (fid) DO NOTHING;

INSERT INTO sys_fprocess (fid, fprocess_name, project_type, parameters, "source", isaudit, fprocess_type, addparam) 
VALUES(530, 'Check missing data in Inp Orifice', 'ud', NULL, 'core', true, 'Check epa-data', NULL)
ON CONFLICT (fid) DO NOTHING;


UPDATE config_toolbox SET inputparams =
'[
{"widgetname":"name", "label":"Name: (*)","widgettype":"linetext","datatype":"text", "isMandatory":true, "tooltip":"Name for hydrology scenario (mandatory)", "placeholder":"", "layoutname":"grl_option_parameters","layoutorder":1, "value":""},
{"widgetname":"infiltration", "label":"Infiltration:","widgettype":"combo","datatype":"text", "isMandatory":true, "tooltip":"Infiltration", "dvQueryText":"SELECT id, idval FROM inp_typevalue WHERE typevalue =''inp_value_options_in''", "layoutname":"grl_option_parameters","layoutorder":2, "value":""},
{"widgetname":"text", "label":"Text:","widgettype":"linetext","datatype":"text", "isMandatory":false, "tooltip":"Text of hydrology scenario", "placeholder":"", "layoutname":"grl_option_parameters","layoutorder":3, "value":""},
{"widgetname":"expl", "label":"Exploitation:","widgettype":"combo","datatype":"text", "isMandatory":true, "tooltip":"hydrology scenario type", "dvQueryText":"SELECT expl_id AS id, name as idval FROM v_edit_exploitation", "layoutname":"grl_option_parameters","layoutorder":4, "value":""},
{"widgetname":"active", "label":"Active:", "widgettype":"check", "datatype":"boolean", "tooltip":"If true, active" , "layoutname":"grl_option_parameters","layoutorder":5, "value":"true"}
]'
where id = 3290;

