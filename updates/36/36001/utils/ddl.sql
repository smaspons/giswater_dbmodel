/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;

SELECT gw_fct_admin_manage_fields($${"data":{"action":"ADD","table":"anl_arc", "column":"sector_id", "dataType":"integer", "isUtils":"False"}}$$);
SELECT gw_fct_admin_manage_fields($${"data":{"action":"ADD","table":"anl_node", "column":"sector_id", "dataType":"integer", "isUtils":"False"}}$$);

SELECT gw_fct_admin_manage_fields($${"data":{"action":"ADD","table":"config_form_list", "column":"addparam", "dataType":"json", "isUtils":"False"}}$$);
SELECT gw_fct_admin_manage_fields($${"data":{"action":"ADD","table":"config_form_tableview", "column":"addparam", "dataType":"json", "isUtils":"False"}}$$);
SELECT gw_fct_admin_manage_fields($${"data":{"action":"RENAME","table":"config_form_tableview", "column":"tablename", "newName":"objectname"}}$$);

-- 15/03/2023
SELECT gw_fct_admin_manage_fields($${"data":{"action":"ADD","table":"config_report", "column":"device", "dataType":"int[]", "isUtils":"False"}}$$);
SELECT gw_fct_admin_manage_fields($${"data":{"action":"ADD","table":"config_toolbox", "column":"device", "dataType":"int[]", "isUtils":"False"}}$$);

SELECT gw_fct_admin_manage_fields($${"data":{"action":"ADD","table":"link", "column":"epa_type", "dataType":"character varying(16)", "isUtils":"False"}}$$);
SELECT gw_fct_admin_manage_fields($${"data":{"action":"ADD","table":"link", "column":"is_operative", "dataType":"boolean", "isUtils":"False"}}$$);