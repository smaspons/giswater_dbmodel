/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;


-- 9/2/2024;
ALTER TABLE inp_typevalue DISABLE TRIGGER gw_trg_typevalue_config_fk;
UPDATE inp_typevalue SET typevalue = '_inp_options_networkmode' WHERE typevalue = 'inp_options_networkmode' and id = '1';
UPDATE inp_typevalue SET idval = 'BASIC NETWORK' WHERE typevalue = 'inp_options_networkmode' and id = '2';
UPDATE inp_typevalue SET idval = 'NETWORK & CONNECS' WHERE typevalue = 'inp_options_networkmode' and id = '4';
ALTER TABLE inp_typevalue ENABLE TRIGGER gw_trg_typevalue_config_fk;

-- 24/2/2024;
DELETE FROM config_form_fields WHERE formname = 've_epa_virtualpump' and columnname = 'price_pattern';

-- 26/02/2024
UPDATE config_form_fields
	SET widgetcontrols='{"saveValue": false, "tableUpsert": "v_edit_inp_dscenario_virtualpump"}'::json, linkedobject='tbl_inp_dscenario_virtualpump', columnname='tbl_inp_virtualpump'
	WHERE formname='ve_epa_virtualpump' AND columnname='tbl_inp_pump';

-- 28/02/2024

DELETE FROM config_form_fields
	WHERE formname='inp_dscenario_connec' AND formtype='form_feature' AND columnname='pjoint_type' AND tabname='tab_none';
DELETE FROM config_form_fields
	WHERE formname='inp_dscenario_connec' AND formtype='form_feature' AND columnname='pjoint_id' AND tabname='tab_none';

UPDATE sys_table
	SET addparam='{"pkey": "dscenario_id, feature_id"}'::json
	WHERE id='inp_dscenario_demand';

UPDATE sys_table 
	SET criticity=NULL, context=NULL, orderby=NULL, alias=NULL 
	WHERE id='v_om_mincut';
UPDATE sys_table 
	SET criticity=2, context='{"level_1":"OM","level_2":"MINCUT"}', orderby=1, alias='Mincut init point', addparam='{"geom": "anl_the_geom"}'::json 
	WHERE id='v_om_mincut_initpoint';
-- Set style for v_om_mincut_initpoint
UPDATE sys_style SET idval = 'v_om_mincut_initpoint' WHERE idval = 'v_om_mincut';

UPDATE config_toolbox SET inputparams='[
{"widgetname":"exploitation", "label":"Exploitation id''s:","widgettype":"text","datatype":"json","layoutname":"grl_option_parameters","layoutorder":1, "placeholder":"1,2", "value":""}, 
{"widgetname":"usePsectors", "label":"Use masterplan psectors:","widgettype":"check","datatype":"boolean","layoutname":"grl_option_parameters","layoutorder":6, "value":"FALSE"}, 
{"widgetname":"updateFeature", "label":"Update feature attributes:","widgettype":"check","datatype":"boolean","layoutname":"grl_option_parameters","layoutorder":7, "value":"FALSE"}, 
{"widgetname":"updateMapZone", "label":"Update mapzone geometry method:","widgettype":"combo","datatype":"integer","layoutname":"grl_option_parameters","layoutorder":8,"comboIds":[0,1,2,3], "comboNames":["NONE", "CONCAVE POLYGON", "PIPE BUFFER", "PLOT & PIPE BUFFER"], "selectedId":"2"}, 
{"widgetname":"geomParamUpdate", "label":"Update parameter:","widgettype":"text","datatype":"float","layoutname":"grl_option_parameters","layoutorder":10, "isMandatory":false, "placeholder":"5-30", "value":""},
{"widgetname":"ignoreBrokenValves", "label":"Ignore Broken and Open Valves:","widgettype":"check","datatype":"boolean","layoutname":"grl_option_parameters","layoutorder":11, "isMandatory":false, "placeholder":"", "value":""}
]'::json WHERE id=2706;

--Set style for netscenario layers

INSERT INTO sys_style (id, idval, styletype, stylevalue, active) VALUES(171, 'v_edit_plan_netscenario_presszone', 'qml', '<!DOCTYPE qgis PUBLIC ''http://mrcc.com/qgis.dtd'' ''SYSTEM''>
<qgis version="3.28.5-Firenze" styleCategories="Symbology">
 <renderer-v2 type="singleSymbol" enableorderby="0" forceraster="0" symbollevels="0" referencescale="-1">
  <symbols>
   <symbol frame_rate="10" force_rhr="0" type="fill" clip_to_extent="1" is_animated="0" name="0" alpha="0.5">
    <data_defined_properties>
     <Option type="Map">
      <Option type="QString" value="" name="name"/>
      <Option name="properties"/>
      <Option type="QString" value="collection" name="type"/>
     </Option>
    </data_defined_properties>
    <layer enabled="1" class="SimpleFill" locked="0" pass="0">
     <Option type="Map">
      <Option type="QString" value="3x:0,0,0,0,0,0" name="border_width_map_unit_scale"/>
      <Option type="QString" value="188,104,236,255" name="color"/>
      <Option type="QString" value="bevel" name="joinstyle"/>
      <Option type="QString" value="0,0" name="offset"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
      <Option type="QString" value="MM" name="offset_unit"/>
      <Option type="QString" value="35,35,35,255" name="outline_color"/>
      <Option type="QString" value="solid" name="outline_style"/>
      <Option type="QString" value="0.26" name="outline_width"/>
      <Option type="QString" value="MM" name="outline_width_unit"/>
      <Option type="QString" value="solid" name="style"/>
     </Option>
     <data_defined_properties>
      <Option type="Map">
       <Option type="QString" value="" name="name"/>
       <Option name="properties"/>
       <Option type="QString" value="collection" name="type"/>
      </Option>
     </data_defined_properties>
    </layer>
   </symbol>
  </symbols>
  <rotation/>
  <sizescale/>
 </renderer-v2>
 <blendMode>0</blendMode>
 <featureBlendMode>0</featureBlendMode>
 <layerGeometryType>2</layerGeometryType>
</qgis>
', true);

INSERT INTO sys_style (id, idval, styletype, stylevalue, active) VALUES(172, 'v_edit_plan_netscenario_dma', 'qml', '<!DOCTYPE qgis PUBLIC ''http://mrcc.com/qgis.dtd'' ''SYSTEM''>
<qgis version="3.28.5-Firenze" styleCategories="Symbology">
 <renderer-v2 type="singleSymbol" enableorderby="0" forceraster="0" symbollevels="0" referencescale="-1">
  <symbols>
   <symbol frame_rate="10" force_rhr="0" type="fill" clip_to_extent="1" is_animated="0" name="0" alpha="0.5">
    <data_defined_properties>
     <Option type="Map">
      <Option type="QString" value="" name="name"/>
      <Option name="properties"/>
      <Option type="QString" value="collection" name="type"/>
     </Option>
    </data_defined_properties>
    <layer enabled="1" class="SimpleFill" locked="0" pass="0">
     <Option type="Map">
      <Option type="QString" value="3x:0,0,0,0,0,0" name="border_width_map_unit_scale"/>
      <Option type="QString" value="132,228,255,255" name="color"/>
      <Option type="QString" value="bevel" name="joinstyle"/>
      <Option type="QString" value="0,0" name="offset"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
      <Option type="QString" value="MM" name="offset_unit"/>
      <Option type="QString" value="35,35,35,255" name="outline_color"/>
      <Option type="QString" value="solid" name="outline_style"/>
      <Option type="QString" value="0.26" name="outline_width"/>
      <Option type="QString" value="MM" name="outline_width_unit"/>
      <Option type="QString" value="solid" name="style"/>
     </Option>
     <data_defined_properties>
      <Option type="Map">
       <Option type="QString" value="" name="name"/>
       <Option name="properties"/>
       <Option type="QString" value="collection" name="type"/>
      </Option>
     </data_defined_properties>
    </layer>
   </symbol>
  </symbols>
  <rotation/>
  <sizescale/>
 </renderer-v2>
 <blendMode>0</blendMode>
 <featureBlendMode>0</featureBlendMode>
 <layerGeometryType>2</layerGeometryType>
</qgis>
', true);

INSERT INTO sys_style (id, idval, styletype, stylevalue, active) VALUES(173, 'v_edit_plan_netscenario_valve', 'qml', '<!DOCTYPE qgis PUBLIC ''http://mrcc.com/qgis.dtd'' ''SYSTEM''>
<qgis version="3.28.5-Firenze" styleCategories="Symbology">
 <renderer-v2 type="singleSymbol" enableorderby="0" forceraster="0" symbollevels="0" referencescale="-1">
  <symbols>
   <symbol frame_rate="10" force_rhr="0" type="marker" clip_to_extent="1" is_animated="0" name="0" alpha="1">
    <data_defined_properties>
     <Option type="Map">
      <Option type="QString" value="" name="name"/>
      <Option name="properties"/>
      <Option type="QString" value="collection" name="type"/>
     </Option>
    </data_defined_properties>
    <layer enabled="1" class="SimpleMarker" locked="0" pass="0">
     <Option type="Map">
      <Option type="QString" value="0" name="angle"/>
      <Option type="QString" value="square" name="cap_style"/>
      <Option type="QString" value="31,83,180,255" name="color"/>
      <Option type="QString" value="1" name="horizontal_anchor_point"/>
      <Option type="QString" value="bevel" name="joinstyle"/>
      <Option type="QString" value="circle" name="name"/>
      <Option type="QString" value="0,0" name="offset"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
      <Option type="QString" value="MM" name="offset_unit"/>
      <Option type="QString" value="0,0,0,0" name="outline_color"/>
      <Option type="QString" value="solid" name="outline_style"/>
      <Option type="QString" value="0" name="outline_width"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
      <Option type="QString" value="MM" name="outline_width_unit"/>
      <Option type="QString" value="diameter" name="scale_method"/>
      <Option type="QString" value="4.2" name="size"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
      <Option type="QString" value="MM" name="size_unit"/>
      <Option type="QString" value="1" name="vertical_anchor_point"/>
     </Option>
     <data_defined_properties>
      <Option type="Map">
       <Option type="QString" value="" name="name"/>
       <Option type="Map" name="properties">
        <Option type="Map" name="angle">
         <Option type="bool" value="false" name="active"/>
         <Option type="QString" value="rotation" name="field"/>
         <Option type="int" value="2" name="type"/>
        </Option>
        <Option type="Map" name="size">
         <Option type="bool" value="true" name="active"/>
         <Option type="QString" value="var(''map_scale'')" name="expression"/>
         <Option type="Map" name="transformer">
          <Option type="Map" name="d">
           <Option type="double" value="0.52" name="exponent"/>
           <Option type="double" value="0.7" name="maxSize"/>
           <Option type="double" value="10000" name="maxValue"/>
           <Option type="double" value="5.5" name="minSize"/>
           <Option type="double" value="0" name="minValue"/>
           <Option type="double" value="0" name="nullSize"/>
           <Option type="int" value="3" name="scaleType"/>
          </Option>
          <Option type="int" value="1" name="t"/>
         </Option>
         <Option type="int" value="3" name="type"/>
        </Option>
       </Option>
       <Option type="QString" value="collection" name="type"/>
      </Option>
     </data_defined_properties>
    </layer>
    <layer enabled="1" class="FontMarker" locked="0" pass="0">
     <Option type="Map">
      <Option type="QString" value="0" name="angle"/>
      <Option type="QString" value="V" name="chr"/>
      <Option type="QString" value="255,255,255,255" name="color"/>
      <Option type="QString" value="Arial" name="font"/>
      <Option type="QString" value="" name="font_style"/>
      <Option type="QString" value="1" name="horizontal_anchor_point"/>
      <Option type="QString" value="bevel" name="joinstyle"/>
      <Option type="QString" value="0,0" name="offset"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
      <Option type="QString" value="MM" name="offset_unit"/>
      <Option type="QString" value="255,255,255,255" name="outline_color"/>
      <Option type="QString" value="0" name="outline_width"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
      <Option type="QString" value="MM" name="outline_width_unit"/>
      <Option type="QString" value="3.2" name="size"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
      <Option type="QString" value="MM" name="size_unit"/>
      <Option type="QString" value="1" name="vertical_anchor_point"/>
     </Option>
     <data_defined_properties>
      <Option type="Map">
       <Option type="QString" value="" name="name"/>
       <Option type="Map" name="properties">
        <Option type="Map" name="angle">
         <Option type="bool" value="false" name="active"/>
         <Option type="QString" value="rotation" name="field"/>
         <Option type="int" value="2" name="type"/>
        </Option>
        <Option type="Map" name="offset">
         <Option type="bool" value="true" name="active"/>
         <Option type="QString" value="''0''|| '','' || tostring(-0.047619*(coalesce(scale_exp(var(''map_scale''), 0, 10000, 5.5, 0.7, 0.52), 0)))" name="expression"/>
         <Option type="int" value="3" name="type"/>
        </Option>
        <Option type="Map" name="size">
         <Option type="bool" value="true" name="active"/>
         <Option type="QString" value="0.761905*(coalesce(scale_exp(var(''map_scale''), 0, 10000, 5.5, 0.7, 0.52), 0))" name="expression"/>
         <Option type="int" value="3" name="type"/>
        </Option>
       </Option>
       <Option type="QString" value="collection" name="type"/>
      </Option>
     </data_defined_properties>
    </layer>
   </symbol>
  </symbols>
  <rotation/>
  <sizescale/>
 </renderer-v2>
 <blendMode>0</blendMode>
 <featureBlendMode>0</featureBlendMode>
 <layerGeometryType>0</layerGeometryType>
</qgis>
', true);

INSERT INTO sys_style (id, idval, styletype, stylevalue, active) VALUES(174, 'v_plan_netscenario_connec', 'qml', '<!DOCTYPE qgis PUBLIC ''http://mrcc.com/qgis.dtd'' ''SYSTEM''>
<qgis version="3.28.5-Firenze" styleCategories="Symbology">
 <renderer-v2 type="singleSymbol" enableorderby="0" forceraster="0" symbollevels="0" referencescale="-1">
  <symbols>
   <symbol frame_rate="10" force_rhr="0" type="marker" clip_to_extent="1" is_animated="0" name="0" alpha="1">
    <data_defined_properties>
     <Option type="Map">
      <Option type="QString" value="" name="name"/>
      <Option name="properties"/>
      <Option type="QString" value="collection" name="type"/>
     </Option>
    </data_defined_properties>
    <layer enabled="1" class="SimpleMarker" locked="0" pass="0">
     <Option type="Map">
      <Option type="QString" value="0" name="angle"/>
      <Option type="QString" value="square" name="cap_style"/>
      <Option type="QString" value="201,246,158,255" name="color"/>
      <Option type="QString" value="1" name="horizontal_anchor_point"/>
      <Option type="QString" value="bevel" name="joinstyle"/>
      <Option type="QString" value="circle" name="name"/>
      <Option type="QString" value="0,0" name="offset"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
      <Option type="QString" value="MM" name="offset_unit"/>
      <Option type="QString" value="0,0,0,255" name="outline_color"/>
      <Option type="QString" value="solid" name="outline_style"/>
      <Option type="QString" value="0" name="outline_width"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
      <Option type="QString" value="MM" name="outline_width_unit"/>
      <Option type="QString" value="diameter" name="scale_method"/>
      <Option type="QString" value="1.6" name="size"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
      <Option type="QString" value="MM" name="size_unit"/>
      <Option type="QString" value="1" name="vertical_anchor_point"/>
     </Option>
     <data_defined_properties>
      <Option type="Map">
       <Option type="QString" value="" name="name"/>
       <Option type="Map" name="properties">
        <Option type="Map" name="size">
         <Option type="bool" value="true" name="active"/>
         <Option type="QString" value="var(''map_scale'')" name="expression"/>
         <Option type="Map" name="transformer">
          <Option type="Map" name="d">
           <Option type="double" value="0.57" name="exponent"/>
           <Option type="double" value="1" name="maxSize"/>
           <Option type="double" value="1500" name="maxValue"/>
           <Option type="double" value="3.5" name="minSize"/>
           <Option type="double" value="0" name="minValue"/>
           <Option type="double" value="0" name="nullSize"/>
           <Option type="int" value="2" name="scaleType"/>
          </Option>
          <Option type="int" value="1" name="t"/>
         </Option>
         <Option type="int" value="3" name="type"/>
        </Option>
       </Option>
       <Option type="QString" value="collection" name="type"/>
      </Option>
     </data_defined_properties>
    </layer>
   </symbol>
  </symbols>
  <rotation/>
  <sizescale/>
 </renderer-v2>
 <blendMode>0</blendMode>
 <featureBlendMode>0</featureBlendMode>
 <layerGeometryType>0</layerGeometryType>
</qgis>
', true);

INSERT INTO sys_style (id, idval, styletype, stylevalue, active) VALUES(175, 'v_plan_netscenario_node', 'qml', '<!DOCTYPE qgis PUBLIC ''http://mrcc.com/qgis.dtd'' ''SYSTEM''>
<qgis version="3.28.5-Firenze" styleCategories="Symbology">
 <renderer-v2 type="singleSymbol" enableorderby="0" forceraster="0" symbollevels="0" referencescale="-1">
  <symbols>
   <symbol frame_rate="10" force_rhr="0" type="marker" clip_to_extent="1" is_animated="0" name="0" alpha="1">
    <data_defined_properties>
     <Option type="Map">
      <Option type="QString" value="" name="name"/>
      <Option name="properties"/>
      <Option type="QString" value="collection" name="type"/>
     </Option>
    </data_defined_properties>
    <layer enabled="1" class="SimpleMarker" locked="0" pass="0">
     <Option type="Map">
      <Option type="QString" value="0" name="angle"/>
      <Option type="QString" value="square" name="cap_style"/>
      <Option type="QString" value="72,231,231,255" name="color"/>
      <Option type="QString" value="1" name="horizontal_anchor_point"/>
      <Option type="QString" value="bevel" name="joinstyle"/>
      <Option type="QString" value="circle" name="name"/>
      <Option type="QString" value="0,0" name="offset"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
      <Option type="QString" value="MM" name="offset_unit"/>
      <Option type="QString" value="35,35,35,255" name="outline_color"/>
      <Option type="QString" value="solid" name="outline_style"/>
      <Option type="QString" value="0" name="outline_width"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
      <Option type="QString" value="MM" name="outline_width_unit"/>
      <Option type="QString" value="diameter" name="scale_method"/>
      <Option type="QString" value="2" name="size"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
      <Option type="QString" value="MM" name="size_unit"/>
      <Option type="QString" value="1" name="vertical_anchor_point"/>
     </Option>
     <data_defined_properties>
      <Option type="Map">
       <Option type="QString" value="" name="name"/>
       <Option name="properties"/>
       <Option type="QString" value="collection" name="type"/>
      </Option>
     </data_defined_properties>
    </layer>
   </symbol>
  </symbols>
  <rotation/>
  <sizescale/>
 </renderer-v2>
 <blendMode>0</blendMode>
 <featureBlendMode>0</featureBlendMode>
 <layerGeometryType>0</layerGeometryType>
</qgis>
', true);

INSERT INTO sys_style (id, idval, styletype, stylevalue, active) VALUES(176, 'v_plan_netscenario_arc', 'qml', '<!DOCTYPE qgis PUBLIC ''http://mrcc.com/qgis.dtd'' ''SYSTEM''>
<qgis version="3.28.5-Firenze" styleCategories="Symbology">
 <renderer-v2 type="singleSymbol" enableorderby="0" forceraster="0" symbollevels="0" referencescale="-1">
  <symbols>
   <symbol frame_rate="10" force_rhr="0" type="line" clip_to_extent="1" is_animated="0" name="0" alpha="1">
    <data_defined_properties>
     <Option type="Map">
      <Option type="QString" value="" name="name"/>
      <Option name="properties"/>
      <Option type="QString" value="collection" name="type"/>
     </Option>
    </data_defined_properties>
    <layer enabled="1" class="SimpleLine" locked="0" pass="0">
     <Option type="Map">
      <Option type="QString" value="0" name="align_dash_pattern"/>
      <Option type="QString" value="square" name="capstyle"/>
      <Option type="QString" value="5;2" name="customdash"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="customdash_map_unit_scale"/>
      <Option type="QString" value="MM" name="customdash_unit"/>
      <Option type="QString" value="0" name="dash_pattern_offset"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="dash_pattern_offset_map_unit_scale"/>
      <Option type="QString" value="MM" name="dash_pattern_offset_unit"/>
      <Option type="QString" value="0" name="draw_inside_polygon"/>
      <Option type="QString" value="bevel" name="joinstyle"/>
      <Option type="QString" value="31,83,180,255" name="line_color"/>
      <Option type="QString" value="solid" name="line_style"/>
      <Option type="QString" value="0.5" name="line_width"/>
      <Option type="QString" value="MM" name="line_width_unit"/>
      <Option type="QString" value="0" name="offset"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
      <Option type="QString" value="MM" name="offset_unit"/>
      <Option type="QString" value="0" name="ring_filter"/>
      <Option type="QString" value="0" name="trim_distance_end"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="trim_distance_end_map_unit_scale"/>
      <Option type="QString" value="MM" name="trim_distance_end_unit"/>
      <Option type="QString" value="0" name="trim_distance_start"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="trim_distance_start_map_unit_scale"/>
      <Option type="QString" value="MM" name="trim_distance_start_unit"/>
      <Option type="QString" value="0" name="tweak_dash_pattern_on_corners"/>
      <Option type="QString" value="0" name="use_custom_dash"/>
      <Option type="QString" value="3x:0,0,0,0,0,0" name="width_map_unit_scale"/>
     </Option>
     <data_defined_properties>
      <Option type="Map">
       <Option type="QString" value="" name="name"/>
       <Option name="properties"/>
       <Option type="QString" value="collection" name="type"/>
      </Option>
     </data_defined_properties>
    </layer>
   </symbol>
  </symbols>
  <rotation/>
  <sizescale/>
 </renderer-v2>
 <blendMode>0</blendMode>
 <featureBlendMode>0</featureBlendMode>
 <layerGeometryType>1</layerGeometryType>
</qgis>
', true);

-- 29/02/24
INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
VALUES('ve_epa_pump', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_pump",
    "tablename": "v_edit_inp_dscenario_pump",
    "pkey": [
      "dscenario_id",
      "node_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_pump", "view": "v_edit_inp_dscenario_pump", "add_view": "v_edit_inp_dscenario_pump", "pk": ["dscenario_id", "node_id"]}
   ]
 , "add_dlg_title":"Pump" }
}'::json, 'tbl_inp_dscenario_pump', false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
VALUES('ve_epa_inlet', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_inlet",
    "tablename": "v_edit_inp_dscenario_inlet",
    "pkey": [
      "dscenario_id",
      "node_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_inlet", "view": "v_edit_inp_dscenario_inlet", "add_view": "v_edit_inp_dscenario_inlet", "pk": ["dscenario_id", "node_id"]}
   ], "add_dlg_title":"Inlet" 
  }
}'::json, 'tbl_inp_dscenario_inlet', false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
VALUES('ve_epa_connec', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_connec",
    "tablename": "v_edit_inp_dscenario_connec",
    "pkey": [
      "dscenario_id",
      "connec_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_connec", "view": "v_edit_inp_dscenario_connec", "add_view": "v_edit_inp_dscenario_connec", "pk": ["dscenario_id", "connec_id"]}
   ], "add_dlg_title":"Connec" 
  }
}'::json, 'tbl_inp_dscenario_connec', false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
VALUES('ve_epa_junction', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_junction",
    "tablename": "v_edit_inp_dscenario_junction",
    "pkey": [
      "dscenario_id",
      "node_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_junction", "view": "v_edit_inp_dscenario_junction", "add_view": "v_edit_inp_dscenario_junction", "pk": ["dscenario_id", "node_id"]}
   ]
 , "add_dlg_title":"Junction"  }
}'::json, 'tbl_inp_dscenario_junction', false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
VALUES('ve_epa_pipe', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_pipe",
    "tablename": "v_edit_inp_dscenario_pipe",
    "pkey": [
      "dscenario_id",
      "arc_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_pipe", "view": "v_edit_inp_dscenario_pipe", "add_view": "v_edit_inp_dscenario_pipe", "pk": ["dscenario_id", "arc_id"]}
   ], "add_dlg_title":"Pipe" 
  }
}'::json, 'tbl_inp_dscenario_pipe', false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
VALUES('ve_epa_reservoir', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_reservoir",
    "tablename": "v_edit_inp_dscenario_reservoir",
    "pkey": [
      "dscenario_id",
      "node_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_reservoir", "view": "v_edit_inp_dscenario_reservoir", "add_view": "v_edit_inp_dscenario_reservoir", "pk": ["dscenario_id", "node_id"]}
   ], "add_dlg_title":"Reservoir" 
  }
}'::json, 'tbl_inp_dscenario_reservoir', false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
VALUES('ve_epa_shortpipe', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_shortpipe",
    "tablename": "v_edit_inp_dscenario_shortpipe",
    "pkey": [
      "dscenario_id",
      "node_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_shortpipe", "view": "v_edit_inp_dscenario_shortpipe", "add_view": "v_edit_inp_dscenario_shortpipe", "pk": ["dscenario_id", "node_id"]}
   ]
, "add_dlg_title":"Shortpipe"   }
}'::json, 'tbl_inp_dscenario_shortpipe', false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder)
 VALUES('ve_epa_tank', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_tank",
    "tablename": "v_edit_inp_dscenario_tank",
    "pkey": [
      "dscenario_id",
      "node_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_tank", "view": "v_edit_inp_dscenario_tank", "add_view": "v_edit_inp_dscenario_tank", "pk": ["dscenario_id", "node_id"]}
   ], "add_dlg_title":"Tank" 
  }
}'::json, 'tbl_inp_dscenario_tank', false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
VALUES('ve_epa_valve', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_valve",
    "tablename": "v_edit_inp_dscenario_valve",
    "pkey": [
      "dscenario_id",
      "node_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_valve", "view": "v_edit_inp_dscenario_valve", "add_view": "v_edit_inp_dscenario_valve", "pk": ["dscenario_id", "node_id"]}
   ]
, "add_dlg_title":"Valve"   }
}'::json, 'tbl_inp_dscenario_valve', false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
VALUES('ve_epa_virtualpump', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_virtualpump",
    "tablename": "v_edit_inp_dscenario_virtualpump",
    "pkey": [
      "dscenario_id",
      "arc_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_virtualpump", "view": "v_edit_inp_dscenario_virtualpump", "add_view": "v_edit_inp_dscenario_virtualpump", "pk": ["dscenario_id", "arc_id"]}
   ]
, "add_dlg_title":"Virtualpump" 
  }
}'::json, 'tbl_inp_dscenario_virtualpump', false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO config_form_fields (formname, formtype, tabname, columnname, layoutname, layoutorder, "datatype", widgettype, "label", tooltip, placeholder, ismandatory, isparent, iseditable, isautoupdate, isfilter, dv_querytext, dv_orderby_id, dv_isnullvalue, dv_parent_id, dv_querytext_filterc, stylesheet, widgetcontrols, widgetfunction, linkedobject, hidden, web_layoutorder) 
VALUES('ve_epa_virtualvalve', 'form_feature', 'tab_epa', 'edit_dscenario', 'lyt_epa_dsc_1', 3, NULL, 'button', NULL, NULL, NULL, false, false, true, false, false, NULL, NULL, NULL, NULL, NULL, '{"icon":"101", "size":"20x20"}'::json, '{"saveValue": false}'::json, '{
  "functionName": "edit_dscenario",
  "module": "info",
  "parameters": {
    "targetwidget": "tab_epa_tbl_inp_virtualvalve",
    "tablename": "v_edit_inp_dscenario_virtualvalve",
    "pkey": [
      "dscenario_id",
      "arc_id"
    ],
    "tableviews": [
		{"tbl": "tab_epa_tbl_inp_virtualvalve", "view": "v_edit_inp_dscenario_virtualvalve", "add_view": "v_edit_inp_dscenario_virtualvalve", "pk": ["dscenario_id", "arc_id"]}
   ]
, "add_dlg_title":"Virtualvalve" 
  }
}'::json, 'tbl_inp_dscenario_virtualvalve', false, NULL) ON CONFLICT DO NOTHING;

UPDATE config_form_fields SET layoutorder = 4 WHERE columnname = 'hspacer_epa_1';

UPDATE config_form_fields SET hidden=false WHERE formname='inp_dscenario_demand' AND columnname='feature_id';
UPDATE config_form_fields SET layoutorder=3 WHERE columnname='id' AND formname IN ('inp_dscenario_controls', 'inp_dscenario_rules');

INSERT INTO sys_table VALUES('inp_virtualpump', 'Used to store virtual pump values', 'role_epa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'core', NULL, NULL) ON CONFLICT (id) DO NOTHING;

-- 07/03/2024

UPDATE config_function SET layermanager='{
  "visible": [
    "v_om_mincut_arc",
    "v_om_mincut_node",
    "v_om_mincut_connec",
    "v_om_mincut_initpoint"
  ]
}'::json, actions=NULL WHERE id=2244;

UPDATE config_function SET layermanager='{
  "visible": [
    "v_om_mincut_arc",
    "v_om_mincut_connec",
    "v_om_mincut_initpoint",
    "v_om_mincut_node"
  ],
  "zoom": {
    "layer": "v_om_mincut_arc",
    "margin": 20
  }
}'::json, actions=NULL WHERE id=2980;
