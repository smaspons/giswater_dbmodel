/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;

--2021/11/30
ALTER TABLE inp_typevalue DISABLE TRIGGER gw_trg_typevalue_config_fk;
UPDATE inp_typevalue SET typevalue = '_inp_value_demandtype' WHERE typevalue = 'inp_value_demandtype' and id = '3';
UPDATE inp_typevalue SET typevalue = '_inp_value_patternmethod' WHERE typevalue = 'inp_value_patternmethod' and id = '24';
ALTER TABLE inp_typevalue ENABLE TRIGGER gw_trg_typevalue_config_fk;