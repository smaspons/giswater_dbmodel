/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;

--7/3/23
INSERT INTO config_param_system ("parameter", value, descript, "label", dv_querytext, dv_filterbyfield, isenabled, layoutorder, project_type, dv_isparent, isautoupdate, "datatype", widgettype, ismandatory, iseditable, dv_orderby_id, dv_isnullvalue, stylesheet, widgetcontrols, placeholder, standardvalue, layoutname) VALUES('edit_mapzones_set_lastupdate', 'false', 'If true, value of lastupdate is updated on node, arc, connec features and set to the date of executing the algorithm.', 'Set lastupdate on mapzone process', NULL, NULL, false, NULL, 'ws', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--14/3/23
update config_form_fields set hidden=true where columnname in ('geom3', 'geom4') and formname like '%orifice%';