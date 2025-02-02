/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;


--2022/01/05
--reactions
INSERT INTO sys_param_user(id, formname, descript, sys_role, 
idval, label, dv_querytext, dv_parent_id, isenabled, layoutorder, project_type, isparent, 
dv_querytext_filterc, feature_field_id, feature_dv_parent_value, isautoupdate, datatype, 
widgettype, ismandatory, widgetcontrols, vdefault, layoutname, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, placeholder, source)
VALUES ('inp_reactions_bulk_order', 'epaoptions', 'Power to which concentration is raised when computing a bulk flow reaction rate','role_epa',
'ORDER BULK', 'Bulk Reaction Order', null, null, true, 1, 'ws',FALSE,
FALSE,FALSE,FALSE,FALSE,'integer',
'linetext', TRUE, NULL, NULL, 'lyt_reactions_1', TRUE, NULL,TRUE, NULL, NULL, 'core') ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_param_user(id, formname, descript, sys_role, 
idval, label, dv_querytext, dv_parent_id, isenabled, layoutorder, project_type, isparent, 
dv_querytext_filterc, feature_field_id, feature_dv_parent_value, isautoupdate, datatype, 
widgettype, ismandatory, widgetcontrols, vdefault, layoutname, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, placeholder, source)
VALUES ('inp_reactions_wall_order', 'epaoptions', 'Power to which concentration is raised when computing a bulk flow reaction rate','role_epa',
'ORDER WALL', 'Wall Reaction Order', null, null, true, 2, 'ws',FALSE,
FALSE,FALSE,FALSE,FALSE,'integer',
'linetext', TRUE, NULL, NULL, 'lyt_reactions_1', TRUE, NULL,TRUE, NULL, NULL, 'core') ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_param_user(id, formname, descript, sys_role, 
idval, label, dv_querytext, dv_parent_id, isenabled, layoutorder, project_type, isparent, 
dv_querytext_filterc, feature_field_id, feature_dv_parent_value, isautoupdate, datatype, 
widgettype, ismandatory, widgetcontrols, vdefault, layoutname, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, placeholder, source)
VALUES ('inp_reactions_global_bulk', 'epaoptions', 'Default bulk reaction rate coefficient (Kb) assigned to all pipes.','role_epa',
'GLOBAL BULK', 'Global Bulk Coefficient', null, null, true, 3, 'ws',FALSE,
FALSE,FALSE,FALSE,FALSE,'double',
'linetext', TRUE, NULL, NULL, 'lyt_reactions_1', TRUE, NULL,TRUE, NULL, NULL, 'core') ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_param_user(id, formname, descript, sys_role, 
idval, label, dv_querytext, dv_parent_id, isenabled, layoutorder, project_type, isparent, 
dv_querytext_filterc, feature_field_id, feature_dv_parent_value, isautoupdate, datatype, 
widgettype, ismandatory, widgetcontrols, vdefault, layoutname, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, placeholder, source)
VALUES ('inp_reactions_global_wall', 'epaoptions', 'Wall reaction rate coefficient (Kw) assigned to all pipes.','role_epa',
'GLOBAL WALL', 'Global Wall Coefficient', null, null, true, 1, 'ws',FALSE,
FALSE,FALSE,FALSE,FALSE,'double',
'linetext', TRUE, NULL, NULL, 'lyt_reactions_2', TRUE, NULL,TRUE, NULL, NULL, 'core') ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_param_user(id, formname, descript, sys_role, 
idval, label, dv_querytext, dv_parent_id, isenabled, layoutorder, project_type, isparent, 
dv_querytext_filterc, feature_field_id, feature_dv_parent_value, isautoupdate, datatype, 
widgettype, ismandatory, widgetcontrols, vdefault, layoutname, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, placeholder, source)
VALUES ('inp_reactions_limit_concentration', 'epaoptions', 'Maximum concentration that a substance can grow to or minimum value it can decay to.','role_epa',
'LIMITING POTENTIAL', 'Limiting Concentration', null, null, true, 2, 'ws',FALSE,
FALSE,FALSE,FALSE,FALSE,'double',
'linetext', TRUE, NULL, NULL, 'lyt_reactions_2', TRUE, NULL,TRUE, NULL, NULL, 'core') ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_param_user(id, formname, descript, sys_role, 
idval, label, dv_querytext, dv_parent_id, isenabled, layoutorder, project_type, isparent, 
dv_querytext_filterc, feature_field_id, feature_dv_parent_value, isautoupdate, datatype, 
widgettype, ismandatory, widgetcontrols, vdefault, layoutname, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, placeholder, source)
VALUES ('inp_reactions_wall_coeff_correlation', 'epaoptions', 'Factor correlating wall reaction coefficient to pipe roughness.','role_epa',
'ROUGHNESS CORRELATION', 'Wall Coefficient Correlation', null, null, true, 3, 'ws',FALSE,
FALSE,FALSE,FALSE,FALSE,'double',
'linetext', TRUE, NULL, NULL, 'lyt_reactions_2', TRUE, NULL, TRUE, NULL, NULL, 'core') ON CONFLICT (id) DO NOTHING;

--energy

INSERT INTO sys_param_user(id, formname, descript, sys_role, 
idval, label, dv_querytext, dv_parent_id, isenabled, layoutorder, project_type, isparent, 
dv_querytext_filterc, feature_field_id, feature_dv_parent_value, isautoupdate, datatype, 
widgettype, ismandatory, widgetcontrols, vdefault, layoutname, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, placeholder, source)
VALUES ('inp_energy_pump_effic', 'epaoptions', 'Default pump efficiency','role_epa',
'GLOBAL EFFIC', 'Pump Efficiency', 'SELECT id, id AS idval FROM inp_curve WHERE id IS NOT NULL', null, true, 1, 'ws',FALSE,
FALSE,FALSE,FALSE,FALSE,'string',
'combo', TRUE, NULL, NULL, 'lyt_energy_1', TRUE, NULL, TRUE, NULL, NULL, 'core') ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_param_user(id, formname, descript, sys_role, 
idval, label, dv_querytext, dv_parent_id, isenabled, layoutorder, project_type, isparent, 
dv_querytext_filterc, feature_field_id, feature_dv_parent_value, isautoupdate, datatype, 
widgettype, ismandatory, widgetcontrols, vdefault, layoutname, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, placeholder, source)
VALUES ('inp_energy_price', 'epaoptions', 'Price of energy per kilowatt-hour','role_epa',
'GLOBAL PRICE', 'Energy Price per Kwh', null, null, true, 2, 'ws',FALSE,
FALSE,FALSE,FALSE,FALSE,'text',
'linetext', TRUE, NULL, NULL, 'lyt_energy_1', TRUE, NULL, TRUE, NULL, NULL, 'core') ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_param_user(id, formname, descript, sys_role, 
idval, label, dv_querytext, dv_parent_id, isenabled, layoutorder, project_type, isparent, 
dv_querytext_filterc, feature_field_id, feature_dv_parent_value, isautoupdate, datatype, 
widgettype, ismandatory, widgetcontrols, vdefault, layoutname, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, placeholder, source)
VALUES ('inp_energy_price_pattern', 'epaoptions', 'ID label of a time pattern used to represent variations in energy price with time.','role_epa',
'GLOBAL PATTERN', 'Price Pattern', 'SELECT pattern_id AS id, pattern_id AS idval FROM inp_pattern WHERE pattern_id IS NOT NULL', null, true, 1, 'ws',FALSE,
FALSE,FALSE,FALSE,FALSE,'string',
'combo', TRUE, NULL, NULL, 'lyt_energy_2', TRUE, NULL, TRUE, NULL, NULL, 'core') ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_param_user(id, formname, descript, sys_role, 
idval, label, dv_querytext, dv_parent_id, isenabled, layoutorder, project_type, isparent, 
dv_querytext_filterc, feature_field_id, feature_dv_parent_value, isautoupdate, datatype, 
widgettype, ismandatory, widgetcontrols, vdefault, layoutname, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, placeholder, source)
VALUES ('inp_energy_demand_charge', 'epaoptions', 'Additional energy charge per maximum kilowatt usage.','role_epa',
'DEMAND CHARGE', 'Demand Charge', null, null, true, 2, 'ws',FALSE,
FALSE,FALSE,FALSE,FALSE,'text',
'linetext', TRUE, NULL, NULL, 'lyt_energy_2', TRUE, NULL, TRUE, NULL, NULL, 'core') ON CONFLICT (id) DO NOTHING;

--junction
UPDATE config_form_fields SET columnname = 'emitter_coeff', label ='emitter_coeff' WHERE columnname='coef' and formname = 'inp_emitter';
UPDATE config_form_fields SET columnname = 'init_quality', label= 'init_quality' WHERE columnname='initqual' and formname = 'inp_quality';
UPDATE config_form_fields SET columnname = 'source_type', label = 'source_type' WHERE columnname='sourc_type' and formname = 'inp_source';
UPDATE config_form_fields SET columnname = 'source_quality',label = 'source_quality' WHERE columnname='quality' and formname = 'inp_source';
UPDATE config_form_fields SET columnname = 'source_pattern_id' ,label = 'source_pattern_id' WHERE columnname='pattern_id' and formname = 'inp_source';

UPDATE config_form_fields SET formname = 'v_edit_inp_junction' 
WHERE formname IN ('inp_quality','inp_source','inp_emitter') AND columnname!='node_id';

DELETE FROM config_form_fields WHERE formname in ('inp_quality', 'inp_source','inp_emitter');

-- junction
INSERT INTO config_form_fields 
SELECT 'v_edit_inp_dscenario_junction', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_junction' AND columnname in ('node_id','demand','pattern_id','demand_type', 'emitter_coeff',
'init_quality', 'source_type', 'source_quality', 'source_pattern_id') ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

-- connec
INSERT INTO config_form_fields 
SELECT 'v_edit_inp_dscenario_connec', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_junction' AND columnname in ('connec_id','demand','pattern_id','demand_type', 'emitter_coeff',
'init_quality', 'source_type', 'source_quality', 'source_pattern_id') ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_connec', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_junction' AND columnname in ('connec_id','demand','pattern_id','demand_type', 'emitter_coeff',
'init_quality', 'source_type', 'source_quality', 'source_pattern_id') ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;


--reservoir
INSERT INTO config_form_fields 
SELECT 'v_edit_inp_reservoir', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_junction' AND 
columnname in ('init_quality', 'source_type', 'source_quality', 'source_pattern_id') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_dscenario_reservoir', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_reservoir' 
AND columnname in ('init_quality', 'source_type', 'source_quality', 'source_pattern_id')
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

--valve
INSERT INTO config_form_fields 
SELECT 'v_edit_inp_valve', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_reservoir' AND columnname in ('init_quality') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_dscenario_valve', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_valve' AND columnname in ('init_quality')
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

--virtualvalve

INSERT INTO config_form_fields 
SELECT 'inp_virtualvalve', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_junction' AND columnname in ('init_quality') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'inp_dscenario_virtualvalve', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='inp_virtualvalve' AND columnname in ('init_quality')
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

--pump

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_pump', formtype, tabname, 'effic_curve_id', layoutname, layoutorder, datatype, widgettype, 'effic_curve_id', tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
'{"setMultiline": false, "valueRelation":{"nullValue":true, "layer": "v_edit_inp_curve", "activated": true, "keyColumn": "id", "valueColumn": "id", "filterExpression": null}}',
 widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_pump' AND 
columnname in ('curve_id') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;


INSERT INTO config_form_fields 
SELECT 'v_edit_inp_pump_additional', formtype, tabname, 'effic_curve_id', layoutname, layoutorder, datatype, widgettype, 'effic_curve_id', tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
'{"setMultiline": false, "valueRelation":{"nullValue":true, "layer": "v_edit_inp_curve", "activated": true, "keyColumn": "id", "valueColumn": "id", "filterExpression": null}}',
 widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_pump' AND 
columnname in ('curve_id') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_dscenario_pump_additional', formtype, tabname, 'effic_curve_id', layoutname, layoutorder, datatype, widgettype, 'effic_curve_id', tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
'{"setMultiline": false, "valueRelation":{"nullValue":true, "layer": "v_edit_inp_curve", "activated": true, "keyColumn": "id", "valueColumn": "id", "filterExpression": null}}',
widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_pump' AND 
columnname in ('curve_id') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_dscenario_pump', formtype, tabname, 'effic_curve_id', layoutname, layoutorder, datatype, widgettype, 'effic_curve_id', tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
'{"setMultiline": false, "valueRelation":{"nullValue":true, "layer": "v_edit_inp_curve", "activated": true, "keyColumn": "id", "valueColumn": "id", "filterExpression": null}}',
widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_pump' AND 
columnname in ('curve_id') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;


INSERT INTO config_form_fields 
SELECT 'v_edit_inp_pump', formtype, tabname, 'energy_pattern_id', layoutname, layoutorder, datatype, widgettype, 'energy_pattern_id', tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_junction' AND 
columnname in ('pattern_id') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_dscenario_pump', formtype, tabname, 'energy_pattern_id', layoutname, layoutorder, datatype, widgettype, 'energy_pattern_id', tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_junction' AND 
columnname in ('pattern_id') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_pump_additional', formtype, tabname, 'energy_pattern_id', layoutname, layoutorder, datatype, widgettype, 'energy_pattern_id', tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_junction' AND 
columnname in ('pattern_id') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_dscenario_pump_additional', formtype, tabname, 'energy_pattern_id', layoutname, layoutorder, datatype, widgettype, 'energy_pattern_id', tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_junction' AND 
columnname in ('pattern_id') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

UPDATE config_form_fields set dv_isnullvalue=TRUE WHERE columnname='source_pattern_id' or columnname='source_type';

UPDATE config_form_fields set widgetcontrols='{"setMultiline": false, "valueRelation":{"nullValue":true, "layer": "v_edit_inp_pattern", "activated": true, "keyColumn": "pattern_id", "valueColumn": "pattern_id", "filterExpression": null}}' 
WHERE columnname='source_pattern_id';

UPDATE config_form_fields set widgetcontrols='{"setMultiline": false, "valueRelation":{"nullValue":true, "layer": "v_edit_inp_pattern", "activated": true, "keyColumn": "pattern_id", "valueColumn": "pattern_id", "filterExpression": null}}' 
WHERE columnname='pattern_id';

UPDATE config_form_fields set columnname='pattern_id' 
WHERE columnname='pattern' AND (formname ilike '%inp_pump%' or formname ilike '%inp_dscenario_pump%');


--FK
DELETE FROM sys_foreignkey WHERE typevalue_name = 'inp_typevalue_source' AND target_table='inp_source';
DELETE FROM sys_foreignkey WHERE typevalue_name = 'inp_value_mixing' AND target_table='inp_mixing';

INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_typevalue_source', 'inp_junction', 'source_type', true);
INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_typevalue_source', 'inp_dscenario_junction', 'source_type', true);
INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_typevalue_source', 'inp_tank', 'source_type', true);
INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_typevalue_source', 'inp_dscenario_tank', 'source_type', true);
INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_typevalue_source', 'inp_reservoir', 'source_type', true);
INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_typevalue_source', 'inp_dscenario_reservoir', 'source_type', true);
INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_typevalue_source', 'inp_inlet', 'source_type', true);
INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_typevalue_source', 'inp_dscenario_inlet', 'source_type', true);

INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_value_mixing', 'inp_tank', 'mixing_model', true);
INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_value_mixing', 'inp_dscenario_tank', 'mixing_model', true);
INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_value_mixing', 'inp_inlet', 'mixing_model', true);
INSERT INTO sys_foreignkey(typevalue_table, typevalue_name, target_table, target_field,  active) 
VALUES ('inp_typevalue', 'inp_value_mixing', 'inp_dscenario_inlet', 'mixing_model', true);



-- JUNCTION
INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
    VALUES ('tbl_inp_junction', 'SELECT dscenario_id, demand, pattern_id, emitter_coeff, init_quality, source_type, source_quality, source_pattern_id FROM v_edit_inp_dscenario_junction WHERE node_id IS NOT NULL', 4, 'tab', 'list'); 

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'demand', 'lyt_epa_data_1', 1, 'string', 'text', 'Demand:', 'Demand', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'pattern_id', 'lyt_epa_data_1', 2, 'string', 'text', 'Pattern id:', 'Pattern id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'emitter_coeff', 'lyt_epa_data_1', 3, 'string', 'text', 'Emitter coefficient:', 'Emitter coefficient', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'initial_quality', 'lyt_epa_data_1', 4, 'string', 'text', 'Initial quality:', 'Initial quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'source_type', 'lyt_epa_data_1', 5, 'string', 'text', 'Source type:', 'Source type', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'source_quality', 'lyt_epa_data_1', 6, 'string', 'text', 'Source quality:', 'Source quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'source_pattern_id', 'lyt_epa_data_1', 7, 'string', 'text', 'Source pattern:', 'Source pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'demandmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max demand:', 'Max demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'demandmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min demand:', 'Min demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'headmax', 'lyt_epa_data_2', 5, 'string', 'text', 'Max head:', 'Max head', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'headmin', 'lyt_epa_data_2', 6, 'string', 'text', 'Min head:', 'Min head', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'pressmax', 'lyt_epa_data_2', 8, 'string', 'text', 'Max pressure:', 'Max pressure', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'pressmin', 'lyt_epa_data_2', 9, 'string', 'text', 'Min pressure:', 'Min pressure', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'qualmax', 'lyt_epa_data_2', 11, 'string', 'text', 'Max quality:', 'Max quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'qualmin', 'lyt_epa_data_2', 12, 'string', 'text', 'Min quality:', 'Min quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);


INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_junction', 'form_feature', 'epa', 'tbl_inp_junction', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_junction');


-- PUMP
INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
    VALUES ('tbl_inp_pump', 'SELECT dscenario_id, power, curve_id, speed, pattern_id, status, effic_curve_id, energy_price, energy_pattern_id FROM v_edit_inp_dscenario_pump WHERE node_id IS NOT NULL', 4, 'tab', 'list');

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'power', 'lyt_epa_data_1', 1, 'string', 'text', 'Power:', 'Power', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'curve_id', 'lyt_epa_data_1', 2, 'string', 'text', 'Curve id:', 'Curve id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'speed', 'lyt_epa_data_1', 3, 'string', 'text', 'Speed:', 'Speed', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'pattern_id', 'lyt_epa_data_1', 4, 'string', 'text', 'Pattern:', 'Pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'status', 'lyt_epa_data_1', 5, 'string', 'text', 'Status:', 'Status', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'to_arc', 'lyt_epa_data_1', 6, 'string', 'text', 'To arc:', 'To arc', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'energyvalue', 'lyt_epa_data_1', 7, 'string', 'text', 'Energy value:', 'Energy value', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'pump_type', 'lyt_epa_data_1', 8, 'string', 'combo', 'Pump type:', 'Pump type', false, false, true, false, 'SELECT id, idval FROM inp_typevalue WHERE typevalue = ''inp_typevalue_pumptype''','{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'energy_price', 'lyt_epa_data_1', 9, 'string', 'text', 'Energy price:', 'Energy price', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'price_pattern', 'lyt_epa_data_1', 10, 'string', 'text', 'Price pattern:', 'Price pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'flowmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max flow:', 'Max Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'flowmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min flow:', 'Min Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'velmax', 'lyt_epa_data_2', 4, 'string', 'text', 'Max velocity:', 'Max velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'velmin', 'lyt_epa_data_2', 5, 'string', 'text', 'Min velocity:', 'Min velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'headloss_max', 'lyt_epa_data_2', 6, 'string', 'text', 'Max headloss:', 'Max headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'headloss_min', 'lyt_epa_data_2', 7, 'string', 'text', 'Min headloss:', 'Min headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'quality', 'lyt_epa_data_2', 8, 'string', 'text', 'Quality:', 'Quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'usage_fact', 'lyt_epa_data_2', 9, 'string', 'text', 'Usage factor:', 'Usage factor', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'avg_effic', 'lyt_epa_data_2', 10, 'string', 'text', 'Average efficiency:', 'Average efficiency', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'kwhr_mgal', 'lyt_epa_data_2', 11, 'string', 'text', 'KWh mgal:', 'KWh mgal', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'avg_kw', 'lyt_epa_data_2', 12, 'string', 'text', 'Average KW:', 'Average KW', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'peak_kw', 'lyt_epa_data_2', 13, 'string', 'text', 'Peak KW:', 'Peak KW', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'cost_day', 'lyt_epa_data_2', 14, 'string', 'text', 'Cost day:', 'Cost day', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_pump', 'form_feature', 'epa', 'tbl_inp_pump', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_pump');


-- PIPE
INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
    VALUES ('tbl_inp_pipe', 'SELECT dscenario_id, minorloss, status, roughness, dint, bulk_coeff, wall_coeff FROM v_edit_inp_dscenario_pipe WHERE arc_id IS NOT NULL', 4, 'tab', 'list'); 

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'minorloss', 'lyt_epa_data_1', 1, 'string', 'text', 'Minorloss:', 'Minorloss', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'status', 'lyt_epa_data_1', 2, 'string', 'text', 'Status:', 'Status', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'custom_roughness', 'lyt_epa_data_1', 3, 'string', 'text', 'Custom roughness:', 'Custom roughness', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'custom_dint', 'lyt_epa_data_1', 4, 'string', 'text', 'Custom dint:', 'Custom dint', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'reactionparam', 'lyt_epa_data_1', 5, 'string', 'text', 'Reaction parameter:', 'Reaction parameter', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'reactionvalue', 'lyt_epa_data_1', 6, 'string', 'text', 'Reaction value:', 'Reaction value', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'buk_coeff', 'lyt_epa_data_1', 7, 'string', 'text', 'Buk coefficient:', 'Buk coefficient', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'wall_coeff', 'lyt_epa_data_1', 8, 'string', 'text', 'Wall coefficient:', 'Wall coefficient', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'flowmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max flow:', 'Max Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'flowmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min flow:', 'Min Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'velmax', 'lyt_epa_data_2', 5, 'string', 'text', 'Max velocity:', 'Max velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'velmin', 'lyt_epa_data_2', 6, 'string', 'text', 'Min velocity:', 'Min velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'headloss_max', 'lyt_epa_data_2', 8, 'string', 'text', 'Max headloss:', 'Max headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'headloss_min', 'lyt_epa_data_2', 9, 'string', 'text', 'Min headloss:', 'Min headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'setting_max', 'lyt_epa_data_2', 12, 'string', 'text', 'Max setting:', 'Max setting', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'setting_min', 'lyt_epa_data_2', 13, 'string', 'text', 'Min setting:', 'Min setting', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'reaction_max', 'lyt_epa_data_2', 14, 'string', 'text', 'Max reaction:', 'Max reaction', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'reaction_min', 'lyt_epa_data_2', 15, 'string', 'text', 'Min reaction:', 'Min reaction', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'ffactor_max', 'lyt_epa_data_2', 16, 'string', 'text', 'Max Ffactor:', 'Max Ffactor', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'ffactor_min', 'lyt_epa_data_2', 17, 'string', 'text', 'Min Ffactor:', 'Min Ffactor', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_pipe', 'form_feature', 'epa', 'tbl_inp_pipe', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_pipe');


-- SHORTPIPE
INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
    VALUES ('tbl_inp_shortpipe', 'SELECT dscenario_id, minorloss, status, bulk_coeff, wall_coeff FROM v_edit_inp_dscenario_shortpipe WHERE node_id IS NOT NULL', 4, 'tab', 'list');

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'nodarc_id', 'lyt_epa_data_1', 1, 'string', 'text', 'Nodarc id:', 'Nodarc id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'minorloss', 'lyt_epa_data_1', 2, 'string', 'text', 'Minorloss:', 'Minorloss', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'to_arc', 'lyt_epa_data_1', 3, 'string', 'text', 'To arc:', 'To arc', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'status', 'lyt_epa_data_1', 4, 'string', 'text', 'Status:', 'Status', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'buk_coeff', 'lyt_epa_data_1', 5, 'string', 'text', 'Buk coefficient:', 'Buk coefficient', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'wall_coeff', 'lyt_epa_data_1', 6, 'string', 'text', 'Wall coefficient:', 'Wall coefficient', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'flowmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max flow:', 'Max Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'flowmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min flow:', 'Min Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'velmax', 'lyt_epa_data_2', 5, 'string', 'text', 'Max velocity:', 'Max velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'velmin', 'lyt_epa_data_2', 6, 'string', 'text', 'Min velocity:', 'Min velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'headloss_max', 'lyt_epa_data_2', 8, 'string', 'text', 'Max headloss:', 'Max headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'headloss_min', 'lyt_epa_data_2', 9, 'string', 'text', 'Min uheadloss:', 'Max uheadloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'setting_max', 'lyt_epa_data_2', 12, 'string', 'text', 'Max setting:', 'Max setting', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'setting_min', 'lyt_epa_data_2', 13, 'string', 'text', 'Min setting:', 'Min setting', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'reaction_max', 'lyt_epa_data_2', 14, 'string', 'text', 'Max reaction:', 'Max reaction', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'reaction_min', 'lyt_epa_data_2', 15, 'string', 'text', 'Min reaction:', 'Min reaction', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'ffactor_max', 'lyt_epa_data_2', 16, 'string', 'text', 'Max Ffactor:', 'Max Ffactor', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'ffactor_min', 'lyt_epa_data_2', 17, 'string', 'text', 'Min Ffactor:', 'Min Ffactor', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_shortpipe', 'form_feature', 'epa', 'tbl_inp_shortpipe', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_shortpipe');


-- TANK
INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
    VALUES ('tbl_inp_tank', 'SELECT dscenario_id, initlevel, minlevel, maxlevel, diameter, minvol, curve_id, mixing_model, mixing_fraction, reaction_coeff, init_quality, source_type, source_quality, source_pattern_id FROM v_edit_inp_dscenario_tank WHERE node_id IS NOT NULL', 4, 'tab', 'list');

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'initlevel', 'lyt_epa_data_1', 1, 'string', 'text', 'Init level:', 'Initial level', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'minlevel', 'lyt_epa_data_1', 2, 'string', 'text', 'Min level:', 'Minimum level', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'maxlevel', 'lyt_epa_data_1', 3, 'string', 'text', 'Max level:', 'Maximum level', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'diameter', 'lyt_epa_data_1', 4, 'string', 'text', 'Diameter:', 'Diameter', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'minvol', 'lyt_epa_data_1', 5, 'string', 'text', 'Min volume:', 'Minimum volume', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'curve_id', 'lyt_epa_data_1', 6, 'string', 'text', 'Curve id:', 'Curve id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'overflow', 'lyt_epa_data_1', 7, 'string', 'text', 'Overflow:', 'Overflow', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'mixing_model', 'lyt_epa_data_1', 8, 'string', 'text', 'Mixing model:', 'Mixing model', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'mixing_fraction', 'lyt_epa_data_1', 9, 'string', 'text', 'Mixing fraction:', 'Mixing fraction', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'init_quality', 'lyt_epa_data_1', 10, 'string', 'text', 'Initial quality:', 'Initial quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'source_type', 'lyt_epa_data_1', 11, 'string', 'text', 'Source type:', 'Source type', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'source_quality', 'lyt_epa_data_1', 12, 'string', 'text', 'Source quality:', 'Source quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'source_pattern_id', 'lyt_epa_data_1', 13, 'string', 'text', 'Source pattern:', 'Source pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'demandmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max demand:', 'Max demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'demandmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min demand:', 'Min demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'headmax', 'lyt_epa_data_2', 5, 'string', 'text', 'Max head:', 'Max head', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'headmin', 'lyt_epa_data_2', 6, 'string', 'text', 'Min head:', 'Min head', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'headavg', 'lyt_epa_data_2', 7, 'string', 'text', 'Avg head:', 'Avg demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'pressmax', 'lyt_epa_data_2', 8, 'string', 'text', 'Max pressure:', 'Max pressure', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'pressmin', 'lyt_epa_data_2', 9, 'string', 'text', 'Min pressure:', 'Min pressure', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'qualmax', 'lyt_epa_data_2', 11, 'string', 'text', 'Max quality:', 'Max quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'qualmin', 'lyt_epa_data_2', 12, 'string', 'text', 'Min quality:', 'Min quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_tank', 'form_feature', 'epa', 'tbl_inp_tank', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_tank');


-- RESERVOIR
INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
    VALUES ('tbl_inp_reservoir', 'SELECT dscenario_id, pattern_id, head, init_quality, source_type, source_quality, source_pattern_id FROM v_edit_inp_dscenario_reservoir WHERE node_id IS NOT NULL', 4, 'tab', 'list');

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'pattern_id', 'lyt_epa_data_1', 1, 'string', 'text', 'Pattern:', 'Pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'head', 'lyt_epa_data_1', 2, 'string', 'text', 'Head:', 'Head', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'init_quality', 'lyt_epa_data_1', 3, 'string', 'text', 'Initial quality:', 'Initial quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'source_type', 'lyt_epa_data_1', 4, 'string', 'text', 'Source type:', 'Source type', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'source_quality', 'lyt_epa_data_1', 5, 'string', 'text', 'Source quality:', 'Source quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'source_pattern_id', 'lyt_epa_data_1', 6, 'string', 'text', 'Source pattern:', 'Source pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'demandmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max demand:', 'Max demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'demandmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min demand:', 'Min demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'headmax', 'lyt_epa_data_2', 5, 'string', 'text', 'Max head:', 'Max head', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'headmin', 'lyt_epa_data_2', 6, 'string', 'text', 'Min head:', 'Min head', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'pressmax', 'lyt_epa_data_2', 8, 'string', 'text', 'Max pressure:', 'Max pressure', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'pressmin', 'lyt_epa_data_2', 9, 'string', 'text', 'Min pressure:', 'Min pressure', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'qualmax', 'lyt_epa_data_2', 11, 'string', 'text', 'Max quality:', 'Max quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'qualmin', 'lyt_epa_data_2', 12, 'string', 'text', 'Min quality:', 'Min quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_reservoir', 'form_feature', 'epa', 'tbl_inp_reservoir', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_reservoir');


-- VALVE
INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
    VALUES ('tbl_inp_valve', 'SELECT dscenario_id, nodarc_id, valv_type, pressure, flow, coef_loss, curve_id, minorloss, status, add_settings, init_quality FROM v_edit_inp_dscenario_valve WHERE node_id IS NOT NULL', 4, 'tab', 'list');

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'nodarc_id', 'lyt_epa_data_1', 1, 'string', 'text', 'Nodarc id:', 'Nodarc id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'valv_type', 'lyt_epa_data_1', 2, 'string', 'text', 'Valve type:', 'Valve type', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'pressure', 'lyt_epa_data_1', 3, 'string', 'text', 'Pressure:', 'Pressure', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'custom_dint', 'lyt_epa_data_1', 4, 'string', 'text', 'Custom dint:', 'Custom dint', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'flow', 'lyt_epa_data_1', 5, 'string', 'text', 'Flow:', 'Flow', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'coef_loss', 'lyt_epa_data_1', 6, 'string', 'text', 'Coefficient loss:', 'Coefficient loss', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'curve_id', 'lyt_epa_data_1', 7, 'string', 'text', 'Curve id:', 'Curve id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'minorloss', 'lyt_epa_data_1', 8, 'string', 'text', 'Minorloss:', 'Minorloss', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'status', 'lyt_epa_data_1', 9, 'string', 'text', 'Status:', 'Status', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'to_arc', 'lyt_epa_data_1', 10, 'string', 'text', 'To arc:', 'To arc', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'add_settings', 'lyt_epa_data_1', 11, 'string', 'text', 'Add settings:', 'Add settings', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'init_quality', 'lyt_epa_data_1', 12, 'string', 'text', 'Initial quality:', 'Initial quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'flowmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max flow:', 'Max Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'flowmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min flow:', 'Min Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'velmax', 'lyt_epa_data_2', 5, 'string', 'text', 'Max velocity:', 'Max velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'velmin', 'lyt_epa_data_2', 6, 'string', 'text', 'Min velocity:', 'Min velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'headloss_max', 'lyt_epa_data_2', 8, 'string', 'text', 'Max headloss:', 'Max headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'headloss_min', 'lyt_epa_data_2', 9, 'string', 'text', 'Min headloss:', 'Min headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'uheadloss_max', 'lyt_epa_data_2', 10, 'string', 'text', 'Max uheadloss:', 'Max uheadloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'uheadloss_min', 'lyt_epa_data_2', 11, 'string', 'text', 'Min uheadloss:', 'Min uheadloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'setting_max', 'lyt_epa_data_2', 12, 'string', 'text', 'Max setting:', 'Max setting', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'setting_min', 'lyt_epa_data_2', 13, 'string', 'text', 'Min setting:', 'Min setting', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'reaction_max', 'lyt_epa_data_2', 14, 'string', 'text', 'Max reaction:', 'Max reaction', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'reaction_min', 'lyt_epa_data_2', 15, 'string', 'text', 'Min reaction:', 'Min reaction', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'ffactor_max', 'lyt_epa_data_2', 16, 'string', 'text', 'Max Ffactor:', 'Max Ffactor', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'ffactor_min', 'lyt_epa_data_2', 17, 'string', 'text', 'Min Ffactor:', 'Min Ffactor', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_valve', 'form_feature', 'epa', 'tbl_inp_valve', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_valve');


-- VIRTUALVALVE
INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
    VALUES ('tbl_inp_virtualvalve', 'SELECT dscenario_id, valv_type, pressure, diameter, flow, coef_loss, curve_id, minorloss, status, init_quality FROM v_edit_inp_dscenario_virtualvalve WHERE arc_id IS NOT NULL', 4, 'tab', 'list');

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'nodarc_id', 'lyt_epa_data_1', 1, 'string', 'text', 'Nodarc id:', 'Nodarc id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'valv_type', 'lyt_epa_data_1', 2, 'string', 'text', 'Valve type:', 'Valve type', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'pressure', 'lyt_epa_data_1', 3, 'string', 'text', 'Pressure:', 'Pressure', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'diameter', 'lyt_epa_data_1', 4, 'string', 'text', 'Diameter:', 'Diameter', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'flow', 'lyt_epa_data_1', 5, 'string', 'text', 'Flow:', 'Flow', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'coef_loss', 'lyt_epa_data_1', 6, 'string', 'text', 'Coefficient loss:', 'Coefficient loss', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'curve_id', 'lyt_epa_data_1', 7, 'string', 'text', 'Curve id:', 'Curve id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'minorloss', 'lyt_epa_data_1', 8, 'string', 'text', 'Minorloss:', 'Minorloss', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'status', 'lyt_epa_data_1', 9, 'string', 'text', 'Status:', 'Status', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'to_arc', 'lyt_epa_data_1', 10, 'string', 'text', 'To arc:', 'To arc', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'init_quality', 'lyt_epa_data_1', 11, 'string', 'text', 'Initial quality:', 'Initial quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);


INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'flowmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max flow:', 'Max Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'flowmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min flow:', 'Min Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'velmax', 'lyt_epa_data_2', 5, 'string', 'text', 'Max velocity:', 'Max velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'velmin', 'lyt_epa_data_2', 6, 'string', 'text', 'Min velocity:', 'Min velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'headloss_max', 'lyt_epa_data_2', 8, 'string', 'text', 'Max headloss:', 'Max headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'headloss_min', 'lyt_epa_data_2', 9, 'string', 'text', 'Min headloss:', 'Max headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'uheadloss_max', 'lyt_epa_data_2', 10, 'string', 'text', 'Max uheadloss:', 'Max headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'uheadloss_min', 'lyt_epa_data_2', 11, 'string', 'text', 'Min uheadloss:', 'Min uheadloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'setting_max', 'lyt_epa_data_2', 12, 'string', 'text', 'Max setting:', 'Max setting', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'setting_min', 'lyt_epa_data_2', 13, 'string', 'text', 'Min setting:', 'Min setting', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'reaction_max', 'lyt_epa_data_2', 14, 'string', 'text', 'Max reaction:', 'Max reaction', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'reaction_min', 'lyt_epa_data_2', 15, 'string', 'text', 'Min reaction:', 'Min reaction', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'ffactor_max', 'lyt_epa_data_2', 16, 'string', 'text', 'Max Ffactor:', 'Max Ffactor', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'ffactor_min', 'lyt_epa_data_2', 17, 'string', 'text', 'Min Ffactor:', 'Min Ffactor', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_virtualvalve', 'form_feature', 'epa', 'tbl_inp_virtualvalve', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_virtualvalve');


-- INLET
INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
    VALUES ('tbl_inp_inlet', 'SELECT dscenario_id, initlevel, minlevel, maxlevel, diameter, minvol, curve_id, overflow, head, pattern_id, mixing_model, mixing_fraction, reaction_coeff, init_quality, source_type, source_quality, source_pattern_id FROM v_edit_inp_dscenario_inlet WHERE node_id IS NOT NULL', 4, 'tab', 'list');

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'initlevel', 'lyt_epa_data_1', 1, 'string', 'text', 'Init level:', 'Initial level', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'minlevel', 'lyt_epa_data_1', 2, 'string', 'text', 'Min level:', 'Minimum level', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'maxlevel', 'lyt_epa_data_1', 3, 'string', 'text', 'Max level:', 'Maximum level', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'diameter', 'lyt_epa_data_1', 4, 'string', 'text', 'Diameter:', 'Diameter', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'minvol', 'lyt_epa_data_1', 5, 'string', 'text', 'Min volume:', 'Minimum volume', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'curve_id', 'lyt_epa_data_1', 6, 'string', 'text', 'Curve id:', 'Curve id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'pattern_id', 'lyt_epa_data_1', 7, 'string', 'text', 'Pattern id:', 'Pattern id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'overflow', 'lyt_epa_data_1', 8, 'string', 'text', 'Overflow:', 'Overflow', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'head', 'lyt_epa_data_1', 9, 'string', 'text', 'Head:', 'Head', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'mixing_model', 'lyt_epa_data_1', 10, 'string', 'text', 'Mixing model:', 'Mixing model', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'mixing_fraction', 'lyt_epa_data_1', 11, 'string', 'text', 'Mixing fraction:', 'Mixing fraction', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'reaction_coeff', 'lyt_epa_data_1', 12, 'string', 'text', 'Reaction coefficient:', 'Reaction coefficient', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'init_quality', 'lyt_epa_data_1', 13, 'string', 'text', 'Initial quality:', 'Initial quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'source_type', 'lyt_epa_data_1', 14, 'string', 'text', 'Source type:', 'Source type', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'source_quality', 'lyt_epa_data_1', 15, 'string', 'text', 'Source quality:', 'Source quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'source_pattern_id', 'lyt_epa_data_1', 16, 'string', 'text', 'Source pattern:', 'Source pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'demandmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max demand:', 'Max demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'demandmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min demand:', 'Min demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'headmax', 'lyt_epa_data_2', 5, 'string', 'text', 'Max head:', 'Max head', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'headmin', 'lyt_epa_data_2', 6, 'string', 'text', 'Min head:', 'Min head', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'pressmax', 'lyt_epa_data_2', 8, 'string', 'text', 'Max pressure:', 'Max pressure', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'pressmin', 'lyt_epa_data_2', 9, 'string', 'text', 'Min pressure:', 'Min pressure', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'qualmax', 'lyt_epa_data_2', 11, 'string', 'text', 'Max quality:', 'Max quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'qualmin', 'lyt_epa_data_2', 12, 'string', 'text', 'Min quality:', 'Min quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_inlet', 'form_feature', 'epa', 'tbl_inp_tank', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_inlet');

-- CONNEC
INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
    VALUES ('tbl_inp_connec', 'SELECT dscenario_id, pjoint_type, pjoint_id, demand, pattern_id, peak_factor, status, minorloss, custom_roughness, custom_length, custom_dint FROM v_edit_inp_dscenario_connec WHERE connec_id IS NOT NULL', 4, 'tab', 'list'); 

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'demand', 'lyt_epa_data_1', 1, 'string', 'text', 'Demand:', 'Demand', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'pattern_id', 'lyt_epa_data_1', 2, 'string', 'text', 'Pattern id:', 'Pattern id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'peak_factor', 'lyt_epa_data_1', 3, 'string', 'text', 'Peak factor:', 'Peak factor', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'custom_roughness', 'lyt_epa_data_1', 4, 'string', 'text', 'Custom roughness:', 'Custom roughness', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'custom_length', 'lyt_epa_data_1', 5, 'string', 'text', 'Custom length:', 'Custom length', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'custom_dint', 'lyt_epa_data_1', 6, 'string', 'text', 'Custom dint:', 'Custom dint', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'status', 'lyt_epa_data_1', 7, 'string', 'text', 'Status:', 'Status', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'minorloss', 'lyt_epa_data_1', 8, 'string', 'text', 'Minor loss:', 'Minor loss', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'emitter_coeff', 'lyt_epa_data_1', 9, 'string', 'text', 'Emitter coefficient:', 'Emitter coefficient', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'initial_quality', 'lyt_epa_data_1', 10, 'string', 'text', 'Initial quality:', 'Initial quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'source_type', 'lyt_epa_data_1', 11, 'string', 'text', 'Source type:', 'Source type', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'source_quality', 'lyt_epa_data_1', 12, 'string', 'text', 'Source quality:', 'Source quality', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'source_pattern_id', 'lyt_epa_data_1', 13, 'string', 'text', 'Source pattern:', 'Source pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);


INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'demandmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max demand:', 'Max demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'demandmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min demand:', 'Min demand', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'headmax', 'lyt_epa_data_2', 5, 'string', 'text', 'Max head:', 'Max head', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'headmin', 'lyt_epa_data_2', 6, 'string', 'text', 'Min head:', 'Min head', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'pressmax', 'lyt_epa_data_2', 8, 'string', 'text', 'Max pressure:', 'Max pressure', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'pressmin', 'lyt_epa_data_2', 9, 'string', 'text', 'Min pressure:', 'Min pressure', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'qualmax', 'lyt_epa_data_2', 11, 'string', 'text', 'Max quality:', 'Max quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'qualmin', 'lyt_epa_data_2', 12, 'string', 'text', 'Min quality:', 'Min quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_connec', 'form_feature', 'epa', 'tbl_inp_connec', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_connec');


--tank
INSERT INTO config_form_fields 
SELECT 'v_edit_inp_tank', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='ve_epa_tank' AND 
columnname in ('init_quality', 'source_type', 'source_quality', 'source_pattern_id', 'mixing_model','mixing_fraction', 'reaction_coeff') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_dscenario_tank', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='ve_epa_tank' 
AND columnname in ('init_quality', 'source_type', 'source_quality', 'source_pattern_id', 'mixing_model','mixing_fraction', 'reaction_coeff')
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

--inlet
INSERT INTO config_form_fields 
SELECT 'v_edit_inp_dscenario_inlet', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_tank' 
AND columnname in ('init_quality', 'source_type', 'source_quality', 'source_pattern_id', 'mixing_model','mixing_fraction','reaction_coeff')
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields 
SELECT 'v_edit_inp_inlet', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, 
widgetcontrols, widgetfunction, linkedobject, hidden 
FROM config_form_fields WHERE formname ='v_edit_inp_tank' 
AND columnname in ('init_quality', 'source_type', 'source_quality', 'source_pattern_id', 'mixing_model','mixing_fraction', 'reaction_coeff')
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;


UPDATE config_param_system SET value = gw_fct_json_object_set_key(value::json, 'node'::text, 'SELECT node_id AS node_id, code AS code FROM v_edit_node'::text) WHERE parameter = 'om_profile_guitartext';

INSERT INTO sys_function
(id, function_name, project_type, function_type, input_params, return_type, descript, sys_role, sample_query, "source")
VALUES(3208, 'gw_fct_getmincut_manager', 'ws', 'function', 'json', 'json', 'Get mincut manager values', 'role_om', NULL, 'core') ON CONFLICT (id) DO NOTHING;

-- Mincut manager form
INSERT INTO config_typevalue
(typevalue, id, idval, camelstyle, addparam)
VALUES('formtype_typevalue', 'form_mincut', 'form_mincut', 'formMincut', NULL);

INSERT INTO config_typevalue
(typevalue, id, idval, camelstyle, addparam)
VALUES('layout_name_typevalue', 'lyt_mincut_mng_1', 'lyt_mincut_mng_1', 'layoutMincutManager1', '{"createAddfield":"TRUE"}'::json);
INSERT INTO config_typevalue
(typevalue, id, idval, camelstyle, addparam)
VALUES('layout_name_typevalue', 'lyt_mincut_mng_2', 'lyt_mincut_mng_2', 'layoutMincutManager2', '{"createAddfield":"TRUE"}'::json);
INSERT INTO config_typevalue
(typevalue, id, idval, camelstyle, addparam)
VALUES('layout_name_typevalue', 'lyt_mincut_mng_3', 'lyt_mincut_mng_3', 'layoutMincutManager3', '{"createAddfield":"TRUE"}'::json);

INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'cancel', 'lyt_mincut_mng_3', 2, NULL, 'button', NULL, 'Close', NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, '{"saveValue":false, "text":"Close"}'::json, '{"functionName": "close_mincut_manager", "module":"mincut_tools", "parameters":{}}'::json, NULL, false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'cancel_mincut', 'lyt_mincut_mng_1', 12, NULL, 'button', NULL, 'Cancel mincut', NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, '{"saveValue":false,"text":"Cancel mincut"}'::json, '{"functionName": "cancel_mincut", "module":"mincut_tools", "parameters":{}}'::json, 'tbl_mincut_manager', false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'delete', 'lyt_mincut_mng_1', 13, NULL, 'button', NULL, 'Delete', NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, '{"saveValue":false,"text":"Delete"}'::json, '{"functionName": "delete_mincut", "module":"mincut_tools", "parameters":{}}'::json, 'tbl_mincut_manager', false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'hspacer_lyt_bot_3', 'lyt_mincut_mng_3', 1, NULL, 'hspacer', NULL, NULL, NULL, false, false, true, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'hspacer_lyt_top_2', 'lyt_mincut_mng_1', 9, NULL, 'hspacer', NULL, NULL, NULL, false, false, true, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'mincut_id', 'lyt_mincut_mng_1', 1, 'string', 'typeahead', 'Filter by: id OR work_order', NULL, NULL, false, false, true, false, true, 'SELECT id::varchar as id, id::varchar as idval FROM v_ui_mincut ', NULL, NULL, NULL, NULL, NULL, '{"saveValue": false, "filterSign":"ILIKE", "labelPosition":"top"}'::json, '{"functionName": "filter_table_mincut", "parameters":{"columnfind":"id, work_order"}}'::json, 'tbl_mincut_manager', false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'mincut_type', 'lyt_mincut_mng_1', 4, 'string', 'combo', 'Type:', NULL, NULL, false, false, true, false, true, 'SELECT id, descript as idval FROM om_mincut_cat_type WHERE id is not null ', true, true, NULL, NULL, NULL, '{"labelPosition": "top", "columnId": 0}'::json, '{"functionName": "filter_table_mincut", "parameters":{}}'::json, 'tbl_mincut_manager', false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'next_days', 'lyt_mincut_mng_1', 10, 'boolean', 'check', 'Next days', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, '{"labelPosition": "top","saveValue":false}'::json, '{"functionName": "check_filter_days","module":"mincut_tools", "parameters":{}}'::json, NULL, false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'selector_mincut', 'lyt_mincut_mng_1', 2, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"191", "size":"24x24"}'::json, '{"saveValue":false}'::json, '{"functionName": "mincut_selector", "module":"mincut_tools", "parameters":{}}'::json, 'tbl_mincut_manager', false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'date_from', 'lyt_mincut_mng_1', 5, 'date', 'datetime', 'From:', NULL, NULL, false, false, true, false, true, NULL, NULL, NULL, NULL, NULL, NULL, '{"labelPosition": "top", "filterSign":">=", "isEnabled":false}'::json, '{"functionName": "filter_table_mincut", "parameters":{}}'::json, 'tbl_mincut_manager', false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'date_to', 'lyt_mincut_mng_1', 6, 'date', 'datetime', 'To:', NULL, NULL, false, false, true, false, true, NULL, NULL, NULL, NULL, NULL, NULL, '{"labelPosition": "top", "filterSign":"<=", "isEnabled":false}'::json, '{"functionName": "filter_table_mincut", "parameters":{}}'::json, 'tbl_mincut_manager', false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'spm_next_days', 'lyt_mincut_mng_1', 11, 'integer', 'spinbox', 'spmdays', NULL, NULL, false, false, true, false, true, NULL, NULL, NULL, NULL, NULL, NULL, '{"setMultiline":false, "labelPosition":"top", "maxMinValues": {"min":-9999,"max":9999}, "filterSign":"BETWEEN", "filterType": "timestamp", "isEnabled":false}'::json, '{"functionName": "filter_table_mincut", "parameters":{}}'::json, 'tbl_mincut_manager', false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'streetaxis', 'lyt_mincut_mng_1', 8, 'string', 'typeahead', 'Streetaxis:', NULL, NULL, false, false, true, false, true, 'SELECT streetaxis as id, streetaxis as idval FROM v_ui_mincut where id is not null ', NULL, NULL, NULL, NULL, NULL, '{"saveValue": false, "filterSign":"=", "labelPosition":"top"}'::json, '{"functionName": "filter_table_mincut", "parameters":{"columnfind":"streetaxis"}}'::json, 'tbl_mincut_manager', false, NULL);
INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'tbl_mincut_edit', 'lyt_mincut_mng_2', 1, NULL, 'tablewidget', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, '{"saveValue": false}'::json, '{"functionName": "open_mincut", "module":"mincut_tools", "parameters":{}}'::json, 'tbl_mincut_manager', false, 1);

INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'exploitation', 'lyt_mincut_mng_1', 7, 'string', 'combo', 'Exploitation:', NULL, NULL, false, false, true, false, true, 'SELECT expl_id as id, name as idval FROM exploitation WHERE expl_id > 0 ', false, true, NULL, NULL, NULL, '{"labelPosition": "top", "columnId": 0,  "getIndex": false}'::json, '{"functionName": "filter_table_mincut", "parameters":{}}'::json, 'tbl_mincut_manager', false, NULL);


INSERT INTO config_form_fields
(formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
VALUES('mincut_manager', 'form_mincut', 'main', 'state', 'lyt_mincut_mng_1', 3, 'string', 'combo', 'State:', NULL, NULL, false, false, true, false, true, 'SELECT id, idval FROM om_typevalue WHERE typevalue = ''mincut_state'' ', true, true, NULL, NULL, NULL, '{"labelPosition": "top", "columnId": 1, "getIndex": false}'::json, '[{"functionName": "filter_table_mincut", "parameters": {}, "isFilter": true}, {"functionName": "combo_tweaks", "module":"mincut_tools", "parameters": {}, "isFilter": false}]'::json, 'tbl_mincut_manager', false, NULL); 



UPDATE config_form_tableview
SET objectname = 'tbl_mincut_manager'
WHERE objectname = 'v_ui_mincut';

UPDATE config_form_tableview
SET location_type='om toolbar', project_type='ws', columnindex=14, visible=true, width=NULL, alias=NULL, "style"=NULL, addparam='{
      "accessorKey": "anl_tstamp",
 
      "filterVariant": "datetime",
      "filterFn": "greaterThanOrEqualTo",
      "sortingFn": "datetime",
      "enableSorting": true,
      "enableColumnOrdering": true,
      "enableColumnFilter": true,
      "enableClickToCopy": false
    }'::json
WHERE objectname='tbl_mincut_manager' AND columnname='anl_tstamp';
UPDATE config_form_tableview
SET location_type='om toolbar', project_type='ws', columnindex=1, visible=true, width=NULL, alias=NULL, "style"=NULL, addparam='{
      "accessorKey": "name",
      "header": "NAME",
      "enableSorting": true,
      "enableColumnOrdering": true,
      "enableColumnFilter": true,
      "enableClickToCopy": false,
      "size":50
    }'::json
WHERE objectname='tbl_mincut_manager' AND columnname='name';
UPDATE config_form_tableview
SET location_type='om toolbar', project_type='ws', columnindex=0, visible=true, width=NULL, alias=NULL, "style"=NULL, addparam='{
      "accessorKey": "id",
      "header": "Id",
      "filterVariant": "text",
      "enableSorting": true,
      "enableColumnOrdering": true,
      "enableColumnFilter": true,
      "enableClickToCopy": false
    }'::json
WHERE objectname='tbl_mincut_manager' AND columnname='id';


INSERT INTO config_form_list
(listname, query_text, device, listtype, listclass, vdefault, addparam)
VALUES('tbl_mincut_manager', 'SELECT id, name, work_order, state, class, mincut_type, received_date, exploitation, municipality, postcode, streetaxis, postnumber, anl_cause, anl_tstamp, anl_user, anl_descript, anl_feature_id, anl_feature_type, forecast_start, forecast_end, assigned_to, exec_start, exec_end, exec_user, exec_descript, exec_from_plot, exec_depth, exec_appropiate, chlorine, turbidity, notified FROM v_ui_mincut WHERE id IS NOT NULL ', 5, 'tab', 'list', NULL, '{
    "enableGlobalFilter": false,
    "enableStickyHeader": true,
    "positionToolbarAlertBanner": "bottom",
    "enableGrouping": false,
    "enablePinning": true,
    "enableColumnOrdering": true,
    "enableColumnFilterModes": true,
    "enableFullScreenToggle": false,
    "enablePagination": true,
    "enableExporting": true,
    "muiTablePaginationProps": {
      "rowsPerPageOptions": [5, 10, 15, 20, 50, 100],
      "showFirstButton": true,
      "showLastButton": true
    },
    "enableRowSelection": true,
    "multipleRowSelection": true,
    "initialState": {
      "showColumnFilters": false,
      "pagination": {
        "pageSize": 10,
        "pageIndex": 0
      },
      "density": "compact",
      "columnFilters": [
      	{
          "id": "anl_tstamp",
          "value": "",
          "range": {
          	"value": -24,
          	"timePeriod": "day"
         	}
         }
      ],
      "sorting": [
        {
          "id": "id",
          "desc": true
        }
      ]
    },
    "modifyTopToolBar": true,
    "renderTopToolbarCustomActions": [
    	{
    	  "widgetfunction": {
    	  	"functionName": "selector",
    	  	"params": {}
    	  },
    	  "color": "success",
    	  "text": "Open Selector",
    	  "disableOnSelect": false,
    	  "getAllRows": true
    	},
		{
    	  "widgetfunction": {
    	  	"functionName": "open",
    	  	"params": {}
    	  },
    	  "color": "success",
    	  "text": "Open",
    	  "disableOnSelect": true,
    	  "moreThanOneDisable": true
    	},
    	{
    	  "widgetfunction": {
    	  	"functionName": "cancel",
    	  	"params": {}
    	  },
    	  "color": "info",
    	  "text": "Cancel",
    	  "disableOnSelect": true
    	},
    	{
    	  "widgetfunction": {
    	  	"functionName": "delete",
    	  	"params": {}
    	  },
    	  "color": "error",
    	  "text": "Delete",
    	  "disableOnSelect": true
    	}
    ],
    "enableRowActions": false,
    "renderRowActionMenuItems": [
      {
        "widgetfunction": {
    	  	"functionName": "open",
    	  	"params": {}
    	  },
        "icon": "OpenInBrowser",
        "text": "Open"
      },
      {
        "widgetfunction": {
    	  	"functionName": "cancel",
    	  	"params": {}
    	  },
        "icon": "Cancel",
        "text": "Cancel"
      },
      {
        "widgetfunction": {
    	  	"functionName": "delete",
    	  	"params": {}
    	  },
        "icon": "Delete",
        "text": "Delete"
      }
    ]
  }'::json);

UPDATE link l SET epa_type = c.epa_type, is_operative = v.is_operative 
FROM connec c
JOIN value_state_type v ON v.id = c.state_type WHERE l.feature_id = c.connec_id;

-- Mincut form
INSERT INTO config_typevalue (typevalue, id, idval, camelstyle, addparam) 
    VALUES('layout_name_typevalue', 'lyt_plan_1', 'lyt_plan_1', 'lytPlan1', NULL);
INSERT INTO config_typevalue (typevalue, id, idval, camelstyle, addparam) 
    VALUES('layout_name_typevalue', 'lyt_plan_details', 'lyt_plan_details', 'lytPlanDetails', NULL);
INSERT INTO config_typevalue (typevalue, id, idval, camelstyle, addparam) 
    VALUES('layout_name_typevalue', 'lyt_plan_fdates', 'lyt_plan_fdates', 'lytPlanFdates', NULL);
INSERT INTO config_typevalue (typevalue, id, idval, camelstyle, addparam) 
    VALUES('layout_name_typevalue', 'lyt_exec_1', 'lyt_exec_1', 'lytExec1', NULL);
INSERT INTO config_typevalue (typevalue, id, idval, camelstyle, addparam) 
    VALUES('layout_name_typevalue', 'lyt_log_1', 'lyt_log_1', 'lytLog1', NULL);
INSERT INTO config_typevalue (typevalue, id, idval, camelstyle, addparam) 
    VALUES('layout_name_typevalue', 'lyt_toolbar', 'lyt_toolbar', 'layoutToolbar', '{"createAddfield":"TRUE"}'::json);
INSERT INTO config_typevalue (typevalue, id, idval, camelstyle, addparam) 
    VALUES('layout_name_typevalue', 'lyt_hydro_1', 'lyt_hydro_1', 'lytHydro1', NULL);


INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'chk_use_planified', 'lyt_plan_1', 0, 'boolean', 'check', 'Usar red planificada:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 0);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'forecast_start', 'lyt_plan_fdates', 0, 'datetime', 'datetime', 'Desde:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 0);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'forecast_end', 'lyt_plan_fdates', 1, 'datetime', 'datetime', 'Hasta:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 1);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'mincut_state', 'lyt_top_1', 1, 'string', 'text', 'Estado:', NULL, NULL, true, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 1);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'mincut_type', 'lyt_plan_details', 0, 'string', 'combo', 'Tipo:', NULL, NULL, false, false, true, false, false, 'SELECT id, descript AS idval FROM om_mincut_cat_type', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 0);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'anl_cause', 'lyt_plan_details', 1, 'string', 'combo', 'Causa:', NULL, NULL, false, false, true, false, false, 'SELECT id, idval FROM om_typevalue WHERE typevalue = ''mincut_cause''', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 1);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'received_date', 'lyt_plan_details', 2, 'datetime', 'datetime', 'Fecha de recibo:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 2);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'anl_descript', 'lyt_plan_details', 3, 'string', 'textarea', 'Descripción:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 3);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'work_order', 'lyt_top_1', 2, 'string', 'text', 'Orden de trabajo:', NULL, NULL, true, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 2);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'btn_end', 'lyt_exec_1', 8, NULL, 'button', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, '{"text":"Fin"}'::json, '{
  "functionName": "real_end",
  "params": {}
}'::json, NULL, false, 8);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'btn_start', 'lyt_exec_1', 0, NULL, 'button', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, '{"text":"Inicio"}'::json, '{
  "functionName": "real_start",
  "params": {}
}'::json, NULL, false, 0);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'assigned_to', 'lyt_plan_fdates', 2, 'string', 'combo', 'Asignado a:', NULL, NULL, false, false, true, false, false, 'SELECT id, name AS idval FROM cat_users WHERE active is not False', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 2);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'exec_start', 'lyt_exec_1', 1, 'date', 'datetime', 'Fecha inicial:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 1);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'exec_descript', 'lyt_exec_1', 2, 'string', 'textarea', 'Descripción:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 2);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'exec_user', 'lyt_exec_1', 3, 'string', 'text', 'Usuario ejecutivo:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 3);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'exec_from_plot', 'lyt_exec_1', 4, 'double', 'text', 'Distancia fachada:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 4);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'exec_depth', 'lyt_exec_1', 5, 'double', 'text', 'Profundidad:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 5);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'exec_appropiate', 'lyt_exec_1', 6, 'boolean', 'check', 'Apropiado:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 6);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'exec_end', 'lyt_exec_1', 7, 'datetime', 'datetime', 'Fecha final:', NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 7);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'txt_infolog', 'lyt_log_1', 0, 'string', 'textarea', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 0);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'btn_cancel', 'lyt_bot_1', 1, NULL, 'button', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, '{"text":"Cancelar"}'::json, '{
  "functionName": "cancel",
  "params": {}
}'::json, NULL, false, 1);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'id', 'lyt_top_1', 0, 'integer', 'text', 'Id:', NULL, NULL, true, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 0);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'tbl_hydro', 'lyt_hydro_1', 0, NULL, 'tableview', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'v_om_mincut_hydrometer', false, 0);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'btn_valve_status', 'lyt_toolbar', 2, NULL, 'button', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, '{
  "icon": "124",
  "size": "24x24"
}'::json, '{
  "icon": "change-valve-status"
}'::json, '{
  "functionName": "change_valve_status",
  "params": {}
}'::json, NULL, false, 2);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'btn_refresh_mincut', 'lyt_toolbar', 3, NULL, 'button', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, '{
  "icon": "125",
  "size": "24x24"
}'::json, '{
  "icon": "refresh"
}'::json, '{
  "functionName": "refresh_mincut",
  "params": {}
}'::json, NULL, false, 3);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'btn_accept', 'lyt_bot_1', 0, NULL, 'button', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, '{"text":"Aceptar"}'::json, '{
  "functionName": "accept",
  "params": {}
}'::json, NULL, false, 0);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'btn_custom_mincut', 'lyt_toolbar', 1, NULL, 'button', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, '{
  "icon": "123",
  "size": "24x24"
}'::json, '{
  "icon": "custom-mincut"
}'::json, '{
  "functionName": "custom_mincut",
  "params": {}
}'::json, NULL, false, 1);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'btn_mincut', 'lyt_toolbar', 0, NULL, 'button', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, '{
  "icon": "126",
  "size": "24x24"
}'::json, '{
  "icon": "mincut"
}'::json, '{
  "functionName": "auto_mincut", 
  "params": {}
}'::json, NULL, false, 0);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
    VALUES('mincut', 'form_mincut', 'mincut', 'hspacer_lyt_toolbar', 'lyt_toolbar', 4, NULL, 'hspacer', NULL, NULL, NULL, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 4);

UPDATE sys_function set descript = 'Function to create dscenarios from CRM. 
This function store values on CONNEC features. 
When the network geometry generator works with [NODE] demands are moved 50% to node_1 and node_2.'
WHERE id =3110;

INSERT INTO sys_function( id, function_name, project_type, function_type, input_params, return_type, descript, sys_role, sample_query, source)
 VALUES (3236, 'gw_fct_mincut_show_current', 'ws', 'function', 'json', 'json', 
'Visualize mincuts that are being currently executed in the field.', 'role_om', NULL, 'core')
ON CONFLICT (id) DO NOTHING;

INSERT INTO config_toolbox (id, alias, functionparams, inputparams, observ, active, device) 
VALUES(3236, 'Show current mincuts', '{"featureType":[]}'::json, 
'[{"widgetname":"explId", "label":"Exploitation:","widgettype":"combo","datatype":"text","tooltip": "Exploitation", "layoutname":"grl_option_parameters","layoutorder":2, 
"dvQueryText":"select expl_id as id, name as idval from exploitation where active is not false order by name", "selectedId":"$userExploitation"}]'::json, NULL, true,
'{4,5}'  );

INSERT INTO config_function(id, function_name, style, layermanager, actions)
VALUES (3236, 'gw_fct_mincut_show_current', '{"style":{"point":{"style":"categorized","field":"fid","width":2,"transparency":0.5},
"line":{"style":"categorized","field":"result_id","width":2,"transparency":0.5},
"polygon":{"style":"categorized","field":"fid","width":2,"transparency":0.5}}}', null, null);


INSERT INTO sys_fprocess
(fid, fprocess_name, project_type, parameters, "source", isaudit, fprocess_type, addparam)
VALUES(490, 'Show current mincuts', 'ws', NULL, 'core', true, 'Function process', NULL);


ALTER TABLE presszone ALTER COLUMN tstamp SET DEFAULT now();
ALTER TABLE presszone ALTER COLUMN insert_user SET DEFAULT current_user;

ALTER TABLE dqa ALTER COLUMN tstamp SET DEFAULT now();
ALTER TABLE dqa ALTER COLUMN insert_user SET DEFAULT current_user;

UPDATE config_form_fields set hidden = False  where formname = 'v_edit_inp_dscenario_demand' 
and columnname ='feature_id';

UPDATE config_form_list SET query_text = 
'SELECT  hydrometer_id, hydrometer_customer_code,catalog_id, madeby, class, cat_period_id, sum, custom_sum, value_type, value_status, value_state
FROM v_ui_hydroval_x_connec WHERE hydrometer_id IS NOT NULL '
WHERE listname = 'tbl_hydrometer_value';

-- search
INSERT INTO config_param_system ("parameter", value, descript, "label", dv_querytext, dv_filterbyfield, isenabled, layoutorder, project_type, dv_isparent, isautoupdate, "datatype", widgettype, ismandatory, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, widgetcontrols, placeholder, standardvalue, layoutname) 
    VALUES('basic_search_v2_tab_mincut', '{"sys_display_name": "concat(id, '' - '', street_name,'', '',  postnumber, '' - '', state_name)","sys_tablename": "vu_om_mincut","sys_filter": "state = 0 OR state = 1","sys_orderby": "id","sys_pk": "id","sys_fct": "gw_fct_getmincut"}', 'Search configuration parameteres', 'Mincut:', NULL, NULL, false, NULL, 'utils', NULL, NULL, 'string', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- 2023/05/03
UPDATE config_form_fields 
SET widgetfunction = NULL, widgetcontrols = gw_fct_json_object_set_key(widgetcontrols, 'setMultiline', false)
WHERE columnname = 'epa_type' and formname like '%connec%';

INSERT INTO config_form_tabs ( formname, tabname, label, tooltip, sys_role, tabfunction, tabactions, device, orderby)
SELECT child_layer,  tabname, label, tooltip, sys_role, tabfunction, tabactions, device, orderby
FROM config_form_tabs,cat_feature WHERE tabname in ('tab_hydrometer', 'tab_hydrometer_val') 
and system_id = 'NETWJOIN' ON CONFLICT (formname, tabname) DO NOTHING;


DELETE FROM config_toolbox where id IN (SELECT id FROM sys_function WHERE project_type  ='ud');


-- update sys_table registers according current relations
/*
SELECT * FROM information_schema.tables WHERE table_schema='SCHEMA_NAME' and table_name NOT IN (SELECT id FROM sys_table);
SELECT * FROM sys_table WHERE id NOT IN (SELECT table_name FROM information_schema.tables WHERE table_schema='SCHEMA_NAME');
*/

DELETE FROM sys_table where id not in (SELECT table_name FROM information_schema.tables WHERE table_schema='SCHEMA_NAME');

INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_junction', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;
INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_reservoir', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;
INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_tank', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;
INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_inlet', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;
INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_connec', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;
INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_pipe', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;
INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_pump', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;
INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_shortpipe', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;
INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_virtualvalve', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;
INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_valve', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;
INSERT INTO sys_table(id, descript, sys_role, source) VALUES ('ve_epa_pump_additional', 'Editable view for epa junction', 'role_epa', 'core') ON CONFLICT (id) DO NOTHING;

-- update sys_function registers according current relations
/*
SELECT routine_name FROM information_schema.routines WHERE routine_type='FUNCTION' AND specific_schema='SCHEMA_NAME' and routine_name not in (select function_name FROM sys_function);
select id, function_name FROM sys_function WHERE function_name NOT IN (SELECT routine_name FROM information_schema.routines WHERE routine_type='FUNCTION' AND specific_schema='SCHEMA_NAME');
*/
DELETE FROM config_toolbox WHERE id in (2202,2204,2206,2208,2210);

UPDATE sys_function SET project_type = 'utils' WHERE id in (3064, 3066, 2212);
DELETE FROM sys_function WHERE project_type ='ud';

DELETE FROM sys_function WHERE id IN(2400);

INSERT INTO sys_function (id, function_name, project_type, function_type) VALUES (3240, 'gw_fct_getvisit_manager', 'utils', 'function')ON CONFLICT (id) DO NOTHING;

INSERT INTO config_form_fields(formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, 
placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id,
dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject,  hidden, web_layoutorder)
select 'node',formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, 
placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id,
dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder 
from config_form_fields where tabname in ('hydro_val', 'hydrometer') and formname ='connec'
ON CONFLICT  (formname, formtype, columnname, tabname) DO NOTHING;


update config_toolbox
set inputparams='
[{"widgetname":"name", "label":"Scenario name:", "widgettype":"text","datatype":"text","layoutname":"grl_option_parameters","layoutorder":1,"value":""},
{"widgetname":"descript", "label":"Scenario descript:", "widgettype":"text","datatype":"text","layoutname":"grl_option_parameters","layoutorder":2,"value":""}, 
{"widgetname":"exploitation", "label":"Exploitation:", "widgettype":"combo","datatype":"text","layoutname":"grl_option_parameters","layoutorder":4, "dvQueryText":"SELECT expl_id as id, name as idval FROM v_edit_exploitation", "selectedId":""}, 
{"widgetname":"period", "label":"Source CRM period:", "widgettype":"combo","datatype":"text","layoutname":"grl_option_parameters","layoutorder":6, "dvQueryText":"SELECT id, code as idval FROM ext_cat_period", "selectedId":""},
{"widgetname":"pattern", "label":"Feature pattern:","widgettype":"combo","tooltip":"This value will be stored on pattern_id of inp_dscenario_demand table in order to be used on the inp file exportation ONLY with the pattern method FEATURE PATTERN.", "datatype":"text","layoutname":"grl_option_parameters","layoutorder":7,"comboIds":[1,2,3,4,5,6,7], "comboNames":["NONE", "SECTOR-DEFAULT", "DMA-DEFAULT", "DMA-PERIOD","HYDROMETER-PERIOD","HYDROMETER-CATEGORY", "FEATURE-PATTERN"], "selectedId":""}, 
{"widgetname":"demandUnits", "label":"Demand units:","tooltip": "Choose units to insert volume data on demand column. <br> This value need to be the same that flow units used on EPANET. On the other hand, it is assumed that volume from hydrometer data table is expresed on m3/period and column period_seconds is filled.", "widgettype":"combo","datatype":"text","layoutname":"grl_option_parameters","layoutorder":8 ,"comboIds":["LPS","LPM","MLD","CMH","CMD","CFS","GPM","MGD","AFD"], "comboNames":["LPS","LPM","MLD","CMH","CMD","CFS","GPM","MGD","AFD"], "selectedId":""}]'
WHERE id=3110;


INSERT INTO config_param_system (parameter, value, descript, "label", dv_querytext, dv_filterbyfield, isenabled, layoutorder, project_type, dv_isparent, isautoupdate, "datatype", widgettype, ismandatory, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, widgetcontrols, placeholder, standardvalue, layoutname) 
    VALUES('edit_arc_check_conflictmapzones', '{"activated":true}', 'parameter to be used to check conflict of mapzones on insert or update of arc', 
    NULL, NULL, NULL, false, NULL, 'ws', NULL, NULL, 'json', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO sys_message(id, error_message, hint_message, log_level, show_user, project_type, "source")
VALUES(3236, 'It''s not possible to upsert the arc because node_1 and node_2 belong to different mapzones.', 'check it before continue', 2, true, 'utils', 'core') ON CONFLICT DO NOTHING;


UPDATE config_form_list set query_text = replace(query_text, 'v_ui_hydroval_x_connec', 'v_ui_hydroval') where listname = 'tbl_hydrometer_value';


-- 2023/05/25
UPDATE config_form_fields
	SET dv_querytext_filterc=NULL
	WHERE formtype='form_feature' AND columnname='cat_period_id' AND tabname='tab_hydrometer_val';
UPDATE config_form_fields
	SET dv_querytext_filterc='WHERE feature_id '
	WHERE formtype='form_feature' AND columnname='hydrometer_customer_code' AND tabname='tab_hydrometer_val';

UPDATE config_form_fields
	SET widgetfunction='{"functionName": "filter_table", "parameters": {"field_id": "feature_id"}}'::json
	WHERE formtype='form_feature' AND columnname IN ('cat_period_id', 'hydrometer_customer_code') AND tabname='tab_hydrometer_val';
UPDATE config_form_fields
	SET widgetfunction='{"functionName": "filter_table", "parameters": {"columnfind": "hydrometer_customer_code", "field_id": "feature_id"}}'::json
	WHERE formtype='form_feature' AND columnname='hydrometer_id' AND tabname='tab_hydrometer';

INSERT INTO config_form_fields(formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, 
tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, 
dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols,
widgetfunction, linkedobject, hidden, web_layoutorder)
select 'node', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, 
dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder
from  config_form_fields where formname = 'connec' and tabname ilike '%hydro%' ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;


-- 28/05/2023
INSERT INTO inp_virtualpump 
SELECT arc_id, power, curve_id, speed, pattern_id, status, energyvalue, effic_curve_id, energy_price, energy_pattern_id 
FROM _inp_pump_importinp_ ;

INSERT INTO inp_virtualvalve SELECT * FROM _inp_valve_importinp_ ;

UPDATE sys_table SET id = 'inp_virtualpump' WHERE id = 'inp_pump_importinp';

INSERT INTO sys_table VALUES ('v_edit_inp_virtualpump', 'Shows editable information about virtualpumps', 'role_epa', null,'{"level_1":"EPA","level_2":"HYDRAULICS"}', 11, 
'Inp Virtualpump',null, null, null, 'core', null, null);

INSERT INTO sys_table VALUES ('ve_epa_virtualpump', 'Shows editable information about virtualpumps', 'role_epa', null, null,null, null,null, null, null, 'core', null, null);

INSERT INTO sys_table VALUES ('v_edit_inp_dscenario_virtualpump', 'Shows editable information about dscenario for virtualpumps', 'role_epa', null,'{"level_1":"EPA","level_2":"DSCENARIO"}', 9, 
'Virtualpump Dscenario',null, null, null, 'core', null, '{"pkey":"dscenario_id, arc_id"}');

DELETE FROM sys_feature_epa_type WHERE id IN ('PUMP-IMPORTINP','VALVE-IMPORTINP');

INSERT INTO sys_feature_epa_type VALUES ('VIRTUALPUMP', 'ARC', 'inp_virtualpump',null,TRUE);

ALTER TABLE arc DROP CONSTRAINT arc_epa_type_check;

ALTER TABLE arc ADD CONSTRAINT arc_epa_type_check CHECK (epa_type::text = ANY (ARRAY['PIPE'::text, 'UNDEFINED'::text, 'VIRTUALPUMP'::text, 'VIRTUALVALVE'::text]));

INSERT INTO config_form_list(listname, query_text, device, listtype, listclass)
VALUES ('tbl_inp_virtualpump', 'SELECT dscenario_id, power, curve_id, speed, pattern_id, status, effic_curve_id, energy_price, energy_pattern_id FROM v_edit_inp_dscenario_virtualpump WHERE arc_id IS NOT NULL',
4, 'tab', 'list');


INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'hspacer_lyt_epa', 'lyt_epa_1', 10, 'hspacer', false, false, true, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'power', 'lyt_epa_data_1', 1, 'string', 'text', 'Power:', 'Power', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'curve_id', 'lyt_epa_data_1', 2, 'string', 'text', 'Curve id:', 'Curve id', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'speed', 'lyt_epa_data_1', 3, 'string', 'text', 'Speed:', 'Speed', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'pattern_id', 'lyt_epa_data_1', 4, 'string', 'text', 'Pattern:', 'Pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'status', 'lyt_epa_data_1', 5, 'string', 'text', 'Status:', 'Status', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'energyvalue', 'lyt_epa_data_1', 8, 'string', 'text', 'Energy value:', 'Energy value', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'pump_type', 'lyt_epa_data_1', 9, 'string', 'combo', 'Pump type:', 'Pump type', false, false, true, false, 'SELECT id, idval FROM inp_typevalue WHERE typevalue = ''inp_typevalue_pumptype''','{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'effic_curve_id', 'lyt_epa_data_1', 10, 'string', 'text', 'Effic curve id:', 'effic_curve_id', false, false, true, false, 'SELECT id, id AS idval FROM inp_curve WHERE id IS NOT NULL','{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'energy_price', 'lyt_epa_data_1', 11, 'string', 'text', 'Energy price:', 'Energy price', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'price_pattern', 'lyt_epa_data_1', 12, 'string', 'text', 'Price pattern:', 'Price pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'energy_pattern_id', 'lyt_epa_data_1', 12, 'string', 'text', 'Energy pattern:', 'Energy pattern', false, false, true, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'result_id', 'lyt_epa_data_2', 1, 'string', 'text', 'Result id:', 'Result id', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'flowmax', 'lyt_epa_data_2', 2, 'string', 'text', 'Max flow:', 'Max Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'flowmin', 'lyt_epa_data_2', 3, 'string', 'text', 'Min flow:', 'Min Flow', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'velmax', 'lyt_epa_data_2', 4, 'string', 'text', 'Max velocity:', 'Max velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'velmin', 'lyt_epa_data_2', 5, 'string', 'text', 'Min velocity:', 'Min velocity', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'headloss_max', 'lyt_epa_data_2', 6, 'string', 'text', 'Max headloss:', 'Max headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'headloss_min', 'lyt_epa_data_2', 7, 'string', 'text', 'Min headloss:', 'Min headloss', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'quality', 'lyt_epa_data_2', 8, 'string', 'text', 'Quality:', 'Quality', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'usage_fact', 'lyt_epa_data_2', 9, 'string', 'text', 'Usage factor:', 'Usage factor', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'avg_effic', 'lyt_epa_data_2', 10, 'string', 'text', 'Average efficiency:', 'Average efficiency', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'kwhr_mgal', 'lyt_epa_data_2', 11, 'string', 'text', 'KWh mgal:', 'KWh mgal', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'avg_kw', 'lyt_epa_data_2', 12, 'string', 'text', 'Average KW:', 'Average KW', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'peak_kw', 'lyt_epa_data_2', 13, 'string', 'text', 'Peak KW:', 'Peak KW', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip,  ismandatory, isparent, iseditable, isautoupdate, dv_querytext, widgetcontrols, widgetfunction, isfilter)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'cost_day', 'lyt_epa_data_2', 14, 'string', 'text', 'Cost day:', 'Cost day', false, false, false, false, NULL,'{"filterSign":"ILIKE"}', NULL, false);

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, widgettype, ismandatory, isparent, iseditable, isautoupdate, widgetcontrols, widgetfunction, isfilter, linkedobject)
    VALUES ('ve_epa_virtualpump', 'form_feature', 'epa', 'tbl_inp_pump', 'lyt_epa_3', 1, 'tableview', false, false, false, false, '{"saveValue": false}', NULL, false, 'tbl_inp_pump');


INSERT INTO config_form_fields(formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, 
widgetfunction, linkedobject, hidden, web_layoutorder)
SELECT 'v_edit_inp_dscenario_virtualpump', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, 
widgetfunction, linkedobject, hidden, web_layoutorder FROM config_form_fields 
WHERE formname = 'v_edit_inp_dscenario_pump'  ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;


UPDATE config_form_fields SET columnname ='arc_id', label ='arc_id', tooltip='arc_id'
WHERE formname='v_edit_inp_dscenario_virtualpump' AND columnname = 'node_id';

INSERT INTO config_form_fields(formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, 
widgetfunction, linkedobject, hidden, web_layoutorder)
SELECT 'v_edit_inp_dscenario_virtualpump', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, 
widgetfunction, linkedobject, hidden, web_layoutorder FROM config_form_fields 
where formname = 've_epa_virtualpump' and columnname in ('pump_type',  'energyvalue') ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields(formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, 
widgetfunction, linkedobject, hidden, web_layoutorder)
SELECT 'v_edit_inp_virtualpump', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, 
widgetfunction, linkedobject, hidden, web_layoutorder FROM config_form_fields 
where formname = 've_epa_virtualpump' and columnname in ('power', 'curve_id', 'speed', 'pattern_id', 'status', 'energyvalue', 'pump_type', 
'effic_curve_id', 'energy_price', 'energy_pattern_id') ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;


INSERT INTO config_form_fields(formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, 
widgetfunction, linkedobject, hidden, web_layoutorder)
SELECT 'v_edit_inp_virtualpump', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, 
widgetfunction, linkedobject, hidden, web_layoutorder FROM config_form_fields 
where formname = 'v_edit_inp_pipe' and columnname in ('arc_id', 'node_1', 'node_2', 'arccat_id', 'expl_id', 'sector_id','state', 'state_type', 'annotation') 
ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;

INSERT INTO config_form_fields(formname, formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, 
widgetfunction, linkedobject, hidden, web_layoutorder)
SELECT 'v_edit_inp_virtualpump', formtype, tabname, columnname, layoutname, layoutorder, datatype, widgettype, label, tooltip, placeholder, ismandatory, 
isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, 
widgetfunction, linkedobject, hidden, web_layoutorder FROM config_form_fields 
where formname = 'v_edit_inp_pipe' and columnname = 'dma_id' ON CONFLICT (formname, formtype, columnname, tabname) DO NOTHING;


-- harmonize tabs 24/05/2023
ALTER TABLE config_form_fields DISABLE TRIGGER gw_trg_config_control;

UPDATE config_form_fields set tabname = 'tab_data' where tabname = 'data';
UPDATE config_form_fields set tabname = 'tab_documents' where tabname = 'document';
UPDATE config_form_fields set tabname = 'tab_hydrometer' where tabname = 'hydrometer';
UPDATE config_form_fields set tabname = 'tab_elements' where tabname = 'element';
UPDATE config_form_fields set tabname = 'tab_mincut' where tabname = 'mincut';
UPDATE config_form_fields set tabname = 'tab_epa' where tabname = 'epa';
UPDATE config_form_fields set tabname = 'tab_hydrometer_val' where tabname = 'hydro_val';
UPDATE config_form_fields set tabname = 'tab_none' where tabname = 'main';
UPDATE config_form_fields set tabname = 'tab_visit' where tabname = 'visit';
UPDATE config_form_fields set tabname = 'tab_event' where tabname = 'event';
UPDATE config_form_fields set tabname = 'tab_relation' where tabname = 'relation';

ALTER TABLE config_form_fields ENABLE TRIGGER gw_trg_config_control;


UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=a.dv_isnullvalue,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_junction' AND a.columnname='pattern_id' AND c.columnname='pattern_id' AND (c.formname ILIKE 've_epa_%' OR c.formname ='v_edit_inp_virtualpump');

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=a.dv_isnullvalue,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_junction' AND a.columnname='source_type' AND c.columnname='source_type' AND c.formname ILIKE 've_epa_%';

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=true,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_pipe' AND a.columnname='status' AND c.columnname='status' AND c.formname ILIKE 've_epa_pipe';

UPDATE config_form_fields c SET widgettype='combo', dv_querytext='SELECT id, idval FROM inp_typevalue WHERE typevalue=''inp_value_reactions''' ,
dv_orderby_id=TRUE, dv_isnullvalue=true FROM config_form_fields a
WHERE  c.columnname='reactionparam' AND c.formname ILIKE 've_epa_%';

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=true,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_dscenario_junction' AND a.columnname='source_pattern_id' AND c.columnname='source_pattern_id' AND c.formname ILIKE 've_epa%';

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=true,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_dscenario_pump' AND a.columnname='curve_id' AND c.columnname='curve_id' AND (c.formname ILIKE 've_epa%' OR c.formname ilike '%virtualpump');

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=true,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_pump' AND a.columnname='energy_pattern_id' AND c.columnname='energy_pattern_id' AND (c.formname ILIKE 've_epa%' OR  c.formname ilike '%virtualpump');

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=true,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_pump' AND a.columnname='status' AND c.columnname='status' AND (c.formname ILIKE 've_epa_pump' OR  c.formname ilike '%virtualpump');

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=true,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_pump' AND a.columnname='pump_type' AND c.columnname='pump_type' AND c.formname ILIKE 've_epa_pump';

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=true,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_shortpipe' AND a.columnname='status' AND c.columnname='status' AND c.formname ILIKE 've_epa_shortpipe';

UPDATE config_form_fields c SET widgettype='combo', dv_querytext='SELECT id, idval FROM inp_typevalue WHERE typevalue=''inp_value_mixing''' ,
dv_orderby_id=TRUE, dv_isnullvalue=true FROM config_form_fields a
WHERE  c.columnname='mixing_model';

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=true,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_valve' AND a.columnname='status' AND c.columnname='status' AND 
(c.formname ILIKE 've_epa_valve' OR c.formname ILIKE 've_epa_virtualvalve');

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=true,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_valve' AND a.columnname='valv_type' AND c.columnname='valv_type' AND 
(c.formname ILIKE 've_epa_valve' OR c.formname ILIKE 've_epa_virtualvalve');

UPDATE config_form_fields c SET widgettype=a.widgettype, dv_querytext=a.dv_querytext, dv_orderby_id=a.dv_orderby_id, dv_isnullvalue=true,
widgetcontrols=a.widgetcontrols FROM config_form_fields a
WHERE a.formname='v_edit_inp_dscenario_pump' AND a.columnname='effic_curve_id' AND c.columnname='effic_curve_id' AND (c.formname ILIKE 've_epa%' OR c.formname ilike '%virtualpump');

--2023/05/30
UPDATE config_form_fields
	SET dv_querytext_filterc=NULL
	WHERE formtype='form_feature' AND columnname='cat_period_id';
UPDATE config_form_fields
	SET dv_querytext_filterc='WHERE feature_id '
	WHERE formtype='form_feature' AND columnname='hydrometer_customer_code';

UPDATE config_form_fields
	SET widgetfunction='{"functionName": "filter_table", "parameters": {"field_id": "feature_id"}}'::json
	WHERE formtype='form_feature' AND columnname IN ('cat_period_id', 'hydrometer_customer_code');
UPDATE config_form_fields
	SET widgetfunction='{"functionName": "filter_table", "parameters": {"columnfind": "hydrometer_customer_code", "field_id": "feature_id"}}'::json
	WHERE formtype='form_feature' AND columnname='hydrometer_id';
	

INSERT INTO sys_fprocess
(fid, fprocess_name, project_type, parameters, "source", isaudit, fprocess_type, addparam)
VALUES(488, 'Check connecs related to arcs with diameter bigger than defined value', 'ws', NULL, 'core', true, 'Check om-data', NULL);

--01/06/2023
-- code reservation for checkdemands algorithm (epatools plugin)
INSERT INTO sys_fprocess
(fid, fprocess_name, project_type, parameters, "source", isaudit, fprocess_type, addparam)
VALUES(491, 'Check demands export input file', 'ws', NULL, 'core', true, 'Function process', NULL);

INSERT INTO sys_fprocess
(fid, fprocess_name, project_type, parameters, "source", isaudit, fprocess_type, addparam)
VALUES(492, 'Check demands import results', 'ws', NULL, 'core', true, 'Function process', NULL);
	
INSERT INTO sys_fprocess
(fid, fprocess_name, project_type, parameters, "source", isaudit, fprocess_type, addparam)
VALUES(493, 'Check valve status export input file', 'ws', NULL, 'core', true, 'Function process', NULL);

INSERT INTO sys_fprocess
(fid, fprocess_name, project_type, parameters, "source", isaudit, fprocess_type, addparam)
VALUES(494, 'Check valve status demands import results', 'ws', NULL, 'core', true, 'Function process', NULL);

--2023/06/08
-- epa actions
INSERT INTO config_form_tabs (formname, tabname, "label", tooltip, sys_role, tabfunction, tabactions, orderby, device) 
VALUES('ve_epa_junction', 'tab_epa', 'EPA', NULL, 'role_basic', NULL, 
'[{"actionName":"actionEdit","actionTooltip":"Edit","disabled":false},
{"actionName":"actionZoom","actionTooltip":"Zoom In","disabled":false},
{"actionName":"actionCentered","actionTooltip":"Center","disabled":false},
{"actionName":"actionZoomOut","actionTooltip":"Zoom Out","disabled":false},
{"actionName":"actionCatalog","actionTooltip":"Change Catalog","disabled":false},
{"actionName":"actionWorkcat","actionTooltip":"Add Workcat","disabled":false},
{"actionName":"actionCopyPaste","actionTooltip":"Copy Paste","disabled":false},
{"actionName":"actionLink","actionTooltip":"Open Link","disabled":false},
{"actionName":"actionMapZone","actionTooltip":"Add Mapzone","disabled":false},
{"actionName":"actionSetToArc","actionTooltip":"Set to_arc","disabled":false},
{"actionName":"actionGetArcId","actionTooltip":"Set arc_id","disabled":false},
{"actionName":"actionDemand","actionTooltip":"Demands","disabled":false}]'::json, 2, '{4}');
INSERT INTO config_form_tabs (formname, tabname, "label", tooltip, sys_role, tabfunction, tabactions, orderby, device) 
VALUES('ve_epa_pump', 'tab_epa', 'EPA', NULL, 'role_basic', NULL, 
'[{"actionName":"actionEdit","actionTooltip":"Edit","disabled":false},
{"actionName":"actionZoom","actionTooltip":"Zoom In","disabled":false},
{"actionName":"actionCentered","actionTooltip":"Center","disabled":false},
{"actionName":"actionZoomOut","actionTooltip":"Zoom Out","disabled":false},
{"actionName":"actionCatalog","actionTooltip":"Change Catalog","disabled":false},
{"actionName":"actionWorkcat","actionTooltip":"Add Workcat","disabled":false},
{"actionName":"actionCopyPaste","actionTooltip":"Copy Paste","disabled":false},
{"actionName":"actionLink","actionTooltip":"Open Link","disabled":false},
{"actionName":"actionHelp","actionTooltip":"Help","disabled":true},
{"actionName":"actionMapZone","actionTooltip":"Add Mapzone","disabled":false},
{"actionName":"actionSetToArc","actionTooltip":"Set to_arc","disabled":false},
{"actionName":"actionGetParentId","actionTooltip":"Set parent_id","disabled":true},
{"actionName":"actionGetArcId","actionTooltip":"Set arc_id","disabled":false},
{"actionName":"actionRotation","actionTooltip":"Rotation","disabled":false},
{"actionName":"actionPump","actionTooltip":"Pump","disabled":false}]'::json, 2, '{4}');
INSERT INTO config_form_tabs (formname, tabname, "label", tooltip, sys_role, tabfunction, tabactions, orderby, device) 
VALUES('ve_epa_connec', 'tab_epa', 'EPA', NULL, 'role_basic', NULL, '[
{"actionName":"actionEdit","actionTooltip":"Edit","disabled":false},
{"actionName":"actionZoom","actionTooltip":"Zoom In","disabled":false},
{"actionName":"actionCentered","actionTooltip":"Center","disabled":false},
{"actionName":"actionZoomOut","actionTooltip":"Zoom Out","disabled":false},
{"actionName":"actionCatalog","actionTooltip":"Change Catalog","disabled":false},
{"actionName":"actionWorkcat","actionTooltip":"Add Workcat","disabled":false},
{"actionName":"actionCopyPaste","actionTooltip":"Copy Paste","disabled":false},
{"actionName":"actionLink","actionTooltip":"Open Link","disabled":false},
{"actionName":"actionMapZone","actionTooltip":"Add Mapzone","disabled":false},
{"actionName":"actionSetToArc","actionTooltip":"Set to_arc","disabled":false},
{"actionName":"actionGetArcId","actionTooltip":"Set arc_id","disabled":false},
{"actionName":"actionDemand","actionTooltip":"Demands","disabled":false}]'::json, 2, '{4}');


-- set layoutorder for dscenario widgets
UPDATE config_form_fields 
SET layoutorder = (SELECT attnum FROM pg_attribute WHERE attrelid = formname::regclass AND attname = columnname and attnum > 0 AND NOT attisdropped ORDER BY attnum LIMIT 1)
WHERE formname IN ('v_edit_inp_dscenario_demand', 'v_edit_inp_dscenario_pump_additional');
UPDATE config_form_fields 
SET iseditable = false
WHERE formname IN ('v_edit_inp_dscenario_demand', 'v_edit_inp_dscenario_pump_additional', 'v_edit_inp_pump_additional') AND columnname IN ('node_id', 'feature_id');
UPDATE config_form_fields 
SET hidden = true
WHERE formname = 'v_edit_inp_dscenario_pump_additional' AND columnname = 'overflow';

UPDATE config_form_fields 
SET layoutorder = (SELECT c.ordinal_position FROM information_schema.columns c WHERE c.table_schema = 'SCHEMA_NAME' AND c.table_name = 'v_edit_inp_pump_additional' AND c.column_name = columnname LIMIT 1)
WHERE formname = 'v_edit_inp_pump_additional';

-- insert dscenario demand & pump tables into config_form_tableview
INSERT INTO config_form_tableview (location_type, project_type, objectname, columnname, columnindex, visible, addparam)
SELECT 'epa form', 'ws', v.table_name, c.column_name, c.ordinal_position, true, NULL
FROM information_schema.tables v
JOIN information_schema.columns c ON v.table_schema = c.table_schema AND v.table_name = c.table_name
WHERE v.table_schema = 'SCHEMA_NAME'
  AND v.table_name IN ('inp_dscenario_demand', 'inp_dscenario_pump_additional', 'inp_pump_additional')
ORDER BY v.table_name, c.ordinal_position;

-- disable columns
UPDATE config_form_tableview SET addparam = '{"editable": false}' WHERE objectname = 'inp_dscenario_demand' AND columnname IN ('id', 'feature_id');
UPDATE config_form_tableview SET addparam = '{"editable": false}' WHERE objectname IN ('inp_dscenario_pump_additional', 'inp_pump_additional') AND columnname IN ('id', 'node_id');
