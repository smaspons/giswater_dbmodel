/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;

--2021/10/30
ALTER TABLE cat_arc ALTER COLUMN shape SET DEFAULT 'CIRCULAR';

ALTER TABLE inp_tags DROP CONSTRAINT inp_tags_pkey;
ALTER TABLE inp_tags RENAME COLUMN object TO feature_type;
ALTER TABLE inp_tags RENAME COLUMN node_id TO feature_id;
ALTER TABLE inp_tags DROP COLUMN id;
ALTER TABLE inp_tags ADD CONSTRAINT inp_tags_pkey PRIMARY KEY(feature_type, feature_id);

INSERT INTO sys_fprocess(fid, fprocess_name, project_type, parameters, source) 
VALUES (414, 'Cat connec rows without dint','ws', null, null) ON CONFLICT (fid) DO NOTHING;

--2021/11/03
update sys_param_user set layoutname='lyt_edit', layoutorder=1 where id='edit_elementcat_vdefault';
