/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME ,public;

INSERT INTO config_typevalue(typevalue, id, idval, camelstyle, addparam)
VALUES ('tabname_typevalue', 'tab_exploitation_add', 'tab_exploitation_add', 'ExploitationAdd', null) ON CONFLICT (typevalue, id) DO NOTHING;