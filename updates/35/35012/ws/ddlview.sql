/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;

--2021/08/19
DROP VIEW IF EXISTS v_edit_inp_dscenario_pipe;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_pipe AS 
 SELECT
    d.dscenario_id,
    p.arc_id,
    minorloss,
    status,
    roughness,
    dint
   FROM selector_sector, selector_inp_dscenario, v_arc
     JOIN inp_dscenario_pipe p USING (arc_id)
	 JOIN cat_dscenario d USING (dscenario_id)
  WHERE v_arc.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text
  AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_dscenario_shortpipe;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_shortpipe AS 
 SELECT
    d.dscenario_id,
    p.node_id,
    minorloss,
    status
   FROM selector_sector, selector_inp_dscenario, v_node
     JOIN inp_dscenario_shortpipe p USING (node_id)
	 JOIN cat_dscenario d USING (dscenario_id)
  WHERE v_node.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text
  AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;



DROP VIEW IF EXISTS v_edit_inp_dscenario_pump;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_pump AS 
 SELECT
    d.dscenario_id,
    p.node_id,
    power,
    curve_id,
    speed,
    pattern,
    status
   FROM selector_sector, selector_inp_dscenario, v_node
     JOIN inp_dscenario_pump p USING (node_id)
	 JOIN cat_dscenario d USING (dscenario_id)
  WHERE v_node.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text
  AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;



DROP VIEW IF EXISTS v_edit_inp_dscenario_valve;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_valve AS 
 SELECT
    d.dscenario_id,
    p.node_id,
    valv_type,
    pressure,
    flow,
    coef_loss,
    curve_id,
    minorloss,
    status
   FROM selector_sector, selector_inp_dscenario, v_node
     JOIN inp_dscenario_valve p USING (node_id)
	 JOIN cat_dscenario d USING (dscenario_id)
  WHERE v_node.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text
  AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_dscenario_reservoir;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_reservoir AS 
 SELECT
    d.dscenario_id,
    p.node_id,
    pattern_id,
    head 
   FROM selector_sector, selector_inp_dscenario, v_node
     JOIN inp_dscenario_reservoir p USING (node_id)
	 JOIN cat_dscenario d USING (dscenario_id)
  WHERE v_node.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text
  AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_dscenario_tank;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_tank AS 
 SELECT
    d.dscenario_id,
    p.node_id,
    initlevel,
    minlevel,
    maxlevel,
    diameter,
    minvol,
    curve_id
   FROM selector_sector, selector_inp_dscenario, v_node
     JOIN inp_dscenario_tank p USING (node_id)
	 JOIN cat_dscenario d USING (dscenario_id)
  WHERE v_node.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text
  AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;


CREATE OR REPLACE VIEW ve_pol_pump AS 
SELECT man_pump.pol_id,
v_node.node_id,
polygon.the_geom
FROM v_node
JOIN man_pump ON man_pump.node_id::text = v_node.node_id::text
JOIN polygon ON polygon.pol_id::text = man_pump.pol_id::text;

CREATE OR REPLACE VIEW ve_pol_source AS 
SELECT man_source.pol_id,
v_node.node_id,
polygon.the_geom
FROM v_node
JOIN man_source ON man_source.node_id::text = v_node.node_id::text
JOIN polygon ON polygon.pol_id::text = man_source.pol_id::text;

CREATE OR REPLACE VIEW ve_pol_netwjoin AS 
SELECT man_netwjoin.pol_id,
v_node.node_id,
polygon.the_geom
FROM v_node
JOIN man_netwjoin ON man_netwjoin.node_id::text = v_node.node_id::text
JOIN polygon ON polygon.pol_id::text = man_netwjoin.pol_id::text;