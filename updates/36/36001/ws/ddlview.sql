/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = SCHEMA_NAME, public, pg_catalog;


drop view if exists vi_reactions;
drop view if exists vi_curves;
drop view if exists vi_energy;
drop view if exists vi_emitters;
drop view if exists vi_quality;
drop view if exists vi_sources;
drop view if exists vi_mixing;
drop view if exists vi_pumps;

drop view if exists vi_reactions;
CREATE OR REPLACE VIEW vi_reactions AS 
SELECT 'BULK' as param,
inp_pipe.arc_id,
inp_pipe.bulk_coeff::text as coeff
FROM selector_inp_result, inp_pipe
LEFT JOIN rpt_inp_arc ON inp_pipe.arc_id::text = rpt_inp_arc.arc_id::text
WHERE bulk_coeff is not null AND rpt_inp_arc.result_id::text = selector_inp_result.result_id::text AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT 'WALL' as param,
inp_pipe.arc_id,
inp_pipe.wall_coeff::text as coeff
FROM selector_inp_result, inp_pipe
JOIN rpt_inp_arc ON inp_pipe.arc_id::text = rpt_inp_arc.arc_id::text
WHERE wall_coeff is not null AND rpt_inp_arc.result_id::text = selector_inp_result.result_id::text AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT idval as  param,
NULL AS arc_id,
value::character varying AS coeff
FROM config_param_user
JOIN sys_param_user ON id=parameter
WHERE (parameter='inp_reactions_bulk_order' OR parameter = 'inp_reactions_wall_order' OR parameter = 'inp_reactions_global_bulk' OR 
parameter = 'inp_reactions_global_wall' OR parameter = 'inp_reactions_limit_concentration' OR parameter ='inp_reactions_wall_coeff_correlation')
AND value IS NOT NULL AND  cur_user=current_user order by 1;


CREATE OR REPLACE VIEW vi_energy AS 
SELECT concat('PUMP ', rpt_inp_arc.arc_id) AS pump_id,
'EFFIC' as idval,
effic_curve_id AS energyvalue
FROM selector_inp_result, inp_pump
LEFT JOIN rpt_inp_arc ON concat(inp_pump.node_id, '_n2a') = rpt_inp_arc.arc_id::text
WHERE rpt_inp_arc.result_id::text = selector_inp_result.result_id::text AND selector_inp_result.cur_user = "current_user"()::text AND 
inp_pump.effic_curve_id IS NOT NULL
UNION
SELECT concat('PUMP ', rpt_inp_arc.arc_id) AS pump_id,
'PRICE' as idval,
energy_price::TEXT AS energyvalue
FROM selector_inp_result,  inp_pump
LEFT JOIN rpt_inp_arc ON concat(inp_pump.node_id, '_n2a') = rpt_inp_arc.arc_id::text
WHERE rpt_inp_arc.result_id::text = selector_inp_result.result_id::text AND selector_inp_result.cur_user = "current_user"()::text AND 
inp_pump.energy_price IS NOT NULL
UNION
SELECT concat('PUMP ', rpt_inp_arc.arc_id) AS pump_id,
'PATTERN' as idval,
energy_pattern_id AS energyvalue
FROM selector_inp_result,   inp_pump
LEFT JOIN rpt_inp_arc ON concat(inp_pump.node_id, '_n2a') = rpt_inp_arc.arc_id::text
WHERE rpt_inp_arc.result_id::text = selector_inp_result.result_id::text AND selector_inp_result.cur_user = "current_user"()::text AND 
inp_pump.energy_pattern_id IS NOT NULL
UNION
SELECT concat('PUMP ', rpt_inp_arc.arc_id) AS pump_id,
'EFFIC' as idval,
effic_curve_id AS energyvalue
FROM selector_inp_result, inp_pump_additional
LEFT JOIN rpt_inp_arc ON concat(inp_pump_additional.node_id, '_n2a') = rpt_inp_arc.arc_id::text
WHERE rpt_inp_arc.result_id::text = selector_inp_result.result_id::text AND selector_inp_result.cur_user = "current_user"()::text AND 
inp_pump_additional.effic_curve_id IS NOT NULL
UNION
SELECT concat('PUMP ', rpt_inp_arc.arc_id) AS pump_id,
'PRICE' as idval,
energy_price::TEXT AS energyvalue
FROM selector_inp_result,  inp_pump_additional
LEFT JOIN rpt_inp_arc ON concat(inp_pump_additional.node_id, '_n2a') = rpt_inp_arc.arc_id::text
WHERE rpt_inp_arc.result_id::text = selector_inp_result.result_id::text AND selector_inp_result.cur_user = "current_user"()::text AND 
inp_pump_additional.energy_price IS NOT NULL
UNION
SELECT concat('PUMP ', rpt_inp_arc.arc_id) AS pump_id,
'PATTERN' as idval,
energy_pattern_id AS energyvalue
FROM selector_inp_result,  inp_pump_additional
LEFT JOIN rpt_inp_arc ON concat(inp_pump_additional.node_id, '_n2a') = rpt_inp_arc.arc_id::text
WHERE rpt_inp_arc.result_id::text = selector_inp_result.result_id::text AND selector_inp_result.cur_user = "current_user"()::text AND 
inp_pump_additional.energy_pattern_id IS NOT NULL
UNION
SELECT idval AS pump_id,
value::text AS idval,
NULL::text AS energyvalue
FROM config_param_user
JOIN sys_param_user ON id=parameter
WHERE (parameter='inp_energy_price' OR parameter = 'inp_energy_pump_effic' OR parameter = 'inp_energy_price_pattern') AND value IS NOT NULL AND 
config_param_user.cur_user::name = current_user order by 1;
   
CREATE OR REPLACE VIEW vi_pumps AS 
SELECT temp_arc.arc_id,
temp_arc.node_1,
temp_arc.node_2,
    CASE
        WHEN (temp_arc.addparam::json ->> 'power'::text) <> ''::text THEN ('POWER'::text || ' '::text) || (temp_arc.addparam::json ->> 'power'::text)
        ELSE NULL::text
    END AS power,
    CASE
        WHEN (temp_arc.addparam::json ->> 'curve_id'::text) <> ''::text THEN ('HEAD'::text || ' '::text) || (temp_arc.addparam::json ->> 'curve_id'::text)
        ELSE NULL::text
    END AS head,
    CASE
        WHEN (temp_arc.addparam::json ->> 'speed'::text) <> ''::text THEN ('SPEED'::text || ' '::text) || (temp_arc.addparam::json ->> 'speed'::text)
        ELSE NULL::text
    END AS speed,
    CASE
        WHEN (temp_arc.addparam::json ->> 'pattern'::text) <> ''::text THEN ('PATTERN'::text || ' '::text) || (temp_arc.addparam::json ->> 'pattern'::text)
        ELSE NULL::text
    END AS pattern_id,
concat(';', temp_arc.sector_id, ' ', temp_arc.dma_id, ' ', temp_arc.presszone_id, ' ', temp_arc.dqa_id, ' ', temp_arc.minsector_id, ' ', temp_arc.arccat_id) AS other
FROM temp_arc
WHERE temp_arc.epa_type::text = 'PUMP'::text AND NOT (temp_arc.arc_id::text IN ( SELECT vi_valves.arc_id
FROM vi_valves))
ORDER BY temp_arc.arc_id;


CREATE OR REPLACE VIEW vi_curves AS 
SELECT
CASE WHEN a.x_value IS NULL THEN a.curve_type::character varying(16)
ELSE a.curve_id
END AS curve_id,
a.x_value::numeric(12,4) AS x_value,
a.y_value::numeric(12,4) AS y_value,
NULL::text AS other
FROM ( SELECT DISTINCT ON (inp_curve_value.curve_id) ( SELECT min(sub.id) AS min
    FROM SCHEMA_NAME.inp_curve_value sub
    WHERE sub.curve_id::text = inp_curve_value.curve_id::text) AS id,
    inp_curve_value.curve_id,
    concat(';', inp_curve.curve_type, ':', inp_curve.descript) AS curve_type,
    NULL::numeric AS x_value,
    NULL::numeric AS y_value
    FROM SCHEMA_NAME.inp_curve
    JOIN SCHEMA_NAME.inp_curve_value ON inp_curve_value.curve_id::text = inp_curve.id::text
    UNION
    SELECT inp_curve_value.id,
    inp_curve_value.curve_id,
    inp_curve.curve_type,
    inp_curve_value.x_value,
    inp_curve_value.y_value
    FROM SCHEMA_NAME.inp_curve_value
    JOIN SCHEMA_NAME.inp_curve ON inp_curve_value.curve_id::text = inp_curve.id::text
    ORDER BY 1, 4 DESC) a
WHERE (a.curve_id::text IN ( SELECT vi_tanks.curve_id
FROM SCHEMA_NAME.vi_tanks)) OR (concat('HEAD ', a.curve_id) IN ( SELECT vi_pumps.head
FROM SCHEMA_NAME.vi_pumps)) OR (a.curve_id::text IN ( SELECT vi_valves.setting
FROM SCHEMA_NAME.vi_valves)) OR (a.curve_id::text IN ( SELECT vi_energy.energyvalue
FROM SCHEMA_NAME.vi_energy
WHERE vi_energy.idval::text = 'EFFIC'::text)) OR ((( SELECT config_param_user.value
FROM SCHEMA_NAME.config_param_user
WHERE config_param_user.parameter::text = 'inp_options_buildup_mode'::text AND config_param_user.cur_user::name = "current_user"()))::integer) = 1;


CREATE OR REPLACE VIEW vi_emitters AS 
SELECT node_id,
emitter_coeff
FROM selector_inp_result, inp_junction
LEFT JOIN rpt_inp_node USING (node_id)
WHERE emitter_coeff IS NOT NULL AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
emitter_coeff
FROM selector_inp_result, inp_dscenario_junction
LEFT JOIN rpt_inp_node USING (node_id)
WHERE emitter_coeff IS NOT NULL AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text;


CREATE OR REPLACE VIEW vi_quality AS 
SELECT node_id,
init_quality
FROM selector_inp_result, inp_junction
LEFT JOIN rpt_inp_node USING (node_id)
WHERE init_quality IS NOT NULL AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
init_quality
FROM selector_inp_result, inp_dscenario_junction
LEFT JOIN rpt_inp_node USING (node_id)
WHERE init_quality IS NOT NULL AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
init_quality
FROM selector_inp_result, inp_inlet
LEFT JOIN rpt_inp_node USING (node_id)
WHERE inp_inlet.init_quality IS NOT NULL AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
init_quality
FROM selector_inp_result, inp_dscenario_inlet
LEFT JOIN rpt_inp_node USING (node_id)
WHERE inp_dscenario_inlet.init_quality IS NOT NULL AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
init_quality
FROM selector_inp_result, inp_tank
LEFT JOIN rpt_inp_node USING (node_id)
WHERE init_quality IS NOT NULL AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
init_quality
FROM selector_inp_result, inp_dscenario_tank
LEFT JOIN rpt_inp_node USING (node_id)
WHERE init_quality IS NOT NULL AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
init_quality
FROM selector_inp_result, inp_reservoir
LEFT JOIN rpt_inp_node USING (node_id)
WHERE init_quality IS NOT NULL AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
init_quality
FROM selector_inp_result, inp_dscenario_reservoir
LEFT JOIN rpt_inp_node USING (node_id)
WHERE init_quality IS NOT NULL AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT arc_id,
init_quality
FROM selector_inp_result, inp_virtualvalve
LEFT JOIN rpt_inp_arc USING (arc_id)
WHERE init_quality IS NOT NULL AND rpt_inp_arc.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT arc_id,
init_quality
FROM selector_inp_result, inp_dscenario_virtualvalve
LEFT JOIN rpt_inp_arc USING (arc_id)
WHERE init_quality IS NOT NULL AND rpt_inp_arc.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text;

CREATE OR REPLACE VIEW vi_sources AS 
SELECT node_id,
source_type,
source_quality,
source_pattern_id
FROM selector_inp_result, inp_junction
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (source_type IS NOT NULL OR source_quality IS NOT NULL OR source_pattern_id IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
source_type,
source_quality,
source_pattern_id
FROM selector_inp_result, inp_dscenario_junction
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (source_type IS NOT NULL OR source_quality IS NOT NULL OR source_pattern_id IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
source_type,
source_quality,
source_pattern_id
FROM selector_inp_result, inp_tank
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (source_type IS NOT NULL OR source_quality IS NOT NULL OR source_pattern_id IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
source_type,
source_quality,
source_pattern_id
FROM selector_inp_result, inp_dscenario_tank
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (source_type IS NOT NULL OR source_quality IS NOT NULL OR source_pattern_id IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
source_type,
source_quality,
source_pattern_id
FROM selector_inp_result, inp_reservoir
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (source_type IS NOT NULL OR source_quality IS NOT NULL OR source_pattern_id IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
source_type,
source_quality,
source_pattern_id
FROM selector_inp_result, inp_dscenario_reservoir
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (source_type IS NOT NULL OR source_quality IS NOT NULL OR source_pattern_id IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
source_type,
source_quality,
source_pattern_id
FROM selector_inp_result, inp_inlet
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (source_type IS NOT NULL OR source_quality IS NOT NULL OR source_pattern_id IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
source_type,
source_quality,
source_pattern_id
FROM selector_inp_result, inp_dscenario_inlet
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (source_type IS NOT NULL OR source_quality IS NOT NULL OR source_pattern_id IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text;



CREATE OR REPLACE VIEW vi_mixing AS 
SELECT node_id,
mixing_model,
mixing_fraction
FROM selector_inp_result, inp_tank
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (mixing_model IS NOT NULL OR mixing_fraction IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
mixing_model,
mixing_fraction
FROM selector_inp_result, inp_dscenario_tank
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (mixing_model IS NOT NULL OR mixing_fraction IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
mixing_model,
mixing_fraction
FROM selector_inp_result, inp_inlet
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (mixing_model IS NOT NULL OR mixing_fraction IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text
UNION
SELECT node_id,
mixing_model,
mixing_fraction
FROM selector_inp_result, inp_dscenario_inlet
LEFT JOIN rpt_inp_node USING (node_id)
WHERE (mixing_model IS NOT NULL OR mixing_fraction IS NOT NULL) 
AND rpt_inp_node.result_id::text = selector_inp_result.result_id::text 
AND selector_inp_result.cur_user = "current_user"()::text;

--2022/01/03
DROP VIEW IF EXISTS v_edit_inp_dscenario_junction;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_junction AS 
SELECT p.dscenario_id,
p.node_id,
--p.demand_type,
p.demand,
p.pattern_id,
emitter_coeff,
init_quality,
source_type,
source_quality,
source_pattern_id,
n.the_geom
FROM selector_sector,selector_inp_dscenario, v_node n
JOIN inp_dscenario_junction p USING (node_id)
JOIN cat_dscenario d USING (dscenario_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text 
AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;

DROP VIEW IF EXISTS v_edit_inp_junction;
CREATE OR REPLACE VIEW v_edit_inp_junction AS 
 SELECT n.node_id,
n.elevation,
n.depth,
n.nodecat_id,
n.sector_id,
-- macrosector
n.dma_id,
n.state,
n.state_type,
n.annotation,
demand,
pattern_id,
peak_factor,
emitter_coeff,
init_quality,
source_type,
source_quality,
source_pattern_id,
n.the_geom
FROM selector_sector, v_edit_node n
JOIN inp_junction USING (node_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_dscenario_pump;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_pump AS 
SELECT d.dscenario_id,
p.node_id,
p.power,
p.curve_id,
p.speed,
p.pattern_id,
p.status,
effic_curve_id,
energy_price,
energy_pattern_id,
n.the_geom
FROM selector_sector,
selector_inp_dscenario,v_node n
JOIN inp_dscenario_pump p USING (node_id)
JOIN cat_dscenario d USING (dscenario_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;



DROP VIEW IF EXISTS v_edit_inp_pump_additional;
CREATE OR REPLACE VIEW v_edit_inp_pump_additional AS 
SELECT n.node_id,
n.elevation,
n.depth,
n.nodecat_id,
n.sector_id,
n.state,
n.state_type,
n.annotation,
n.dma_id,
p.order_id,
p.power,
p.curve_id,
p.speed,
p.pattern_id,
p.status,
effic_curve_id,
energy_price,
energy_pattern_id,
n.the_geom
FROM selector_sector,v_node n
JOIN inp_pump_additional p USING (node_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_dscenario_pump_additional;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_pump_additional AS 
SELECT d.dscenario_id,
p.node_id,
p.order_id,
p.power,
p.curve_id,
p.speed,
p.pattern_id,
p.status,
effic_curve_id,
energy_price,
energy_pattern_id,
n.the_geom
FROM selector_sector,
selector_inp_dscenario,v_node n
JOIN inp_dscenario_pump_additional p USING (node_id)
JOIN cat_dscenario d USING (dscenario_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;

DROP VIEW IF EXISTS v_edit_inp_pump;
CREATE OR REPLACE VIEW v_edit_inp_pump AS 
SELECT n.node_id,
n.elevation,
n.depth,
n.nodecat_id,
n.sector_id,
n.dma_id,
--n.macrosector_id,
n.state,
n.state_type,
n.annotation,
--n.expl_id,
concat(node_id,'_n2a') as nodarc_id,
power,
curve_id,
speed,
pattern_id,
to_arc,
status,
pump_type,
effic_curve_id,
energy_price,
energy_pattern_id,
n.the_geom
FROM selector_sector, v_node n
JOIN inp_pump USING (node_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;



DROP VIEW IF EXISTS v_edit_inp_dscenario_pipe;
CREATE OR REPLACE VIEW SCHEMA_NAME.v_edit_inp_dscenario_pipe AS 
 SELECT d.dscenario_id,
p.arc_id,
p.minorloss,
p.status,
p.roughness,
p.dint,
bulk_coeff,
wall_coeff,
a.the_geom
FROM selector_sector,selector_inp_dscenario, v_arc a
JOIN SCHEMA_NAME.inp_dscenario_pipe p USING (arc_id)
JOIN SCHEMA_NAME.cat_dscenario d USING (dscenario_id)
WHERE a.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text 
AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_pipe;
CREATE OR REPLACE VIEW v_edit_inp_pipe AS 
 SELECT arc.arc_id,
arc.node_1,
arc.node_2,
arc.arccat_id,
arc.sector_id,
--arc.macrosector_id,
arc.dma_id,
arc.state,
arc.state_type,
arc.custom_length,
arc.annotation,
--arc.expl_id,
minorloss,
status,
custom_roughness,
custom_dint,
bulk_coeff,
wall_coeff,
arc.the_geom
FROM selector_sector,v_arc arc
JOIN inp_pipe USING (arc_id)
WHERE arc.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_dscenario_shortpipe;
CREATE OR REPLACE VIEW SCHEMA_NAME.v_edit_inp_dscenario_shortpipe AS 
SELECT d.dscenario_id,
p.node_id,
p.minorloss,
p.status,
bulk_coeff,
wall_coeff,
n.the_geom
FROM selector_sector, selector_inp_dscenario, v_node n
JOIN inp_dscenario_shortpipe p USING (node_id)
JOIN cat_dscenario d USING (dscenario_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text AND 
p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_shortpipe;
CREATE OR REPLACE VIEW v_edit_inp_shortpipe AS 
 SELECT n.node_id,
n.elevation,
n.depth,
n.nodecat_id,
n.sector_id,
--n.macrosector_id,
n.dma_id,
n.state,
n.state_type,
n.annotation,
--n.expl_id,
concat(n.node_id,'_n2a') AS nodarc_id,
minorloss,
to_arc,
status,
bulk_coeff,
wall_coeff,
n.the_geom
FROM selector_sector, v_node n
JOIN inp_shortpipe USING (node_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;
  

DROP VIEW IF EXISTS v_edit_inp_dscenario_tank;
CREATE OR REPLACE VIEW SCHEMA_NAME.v_edit_inp_dscenario_tank AS 
SELECT d.dscenario_id,
p.node_id,
p.initlevel,
p.minlevel,
p.maxlevel,
p.diameter,
p.minvol,
p.curve_id,
p.overflow,
mixing_model,
mixing_fraction,
reaction_coeff,
init_quality,
source_type,
source_quality,
source_pattern_id,
n.the_geom
FROM selector_sector, selector_inp_dscenario, v_node n
JOIN inp_dscenario_tank p USING (node_id)
JOIN cat_dscenario d USING (dscenario_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text 
AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;

  
DROP VIEW IF EXISTS v_edit_inp_tank;
CREATE OR REPLACE VIEW v_edit_inp_tank AS 
 SELECT n.node_id,
n.elevation,
n.depth,
n.nodecat_id,
n.sector_id,
--n.macrosector_id,
n.dma_id,
n.state,
n.state_type,
n.annotation,
--n.expl_id,
initlevel,
minlevel,
maxlevel,
diameter,
minvol,
curve_id,
mixing_model,
mixing_fraction,
reaction_coeff,
init_quality,
source_type,
source_quality,
source_pattern_id,
n.the_geom
FROM selector_sector, v_node n
JOIN inp_tank USING (node_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;

DROP VIEW IF EXISTS v_edit_inp_dscenario_reservoir;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_reservoir AS 
SELECT d.dscenario_id,
p.node_id,
p.pattern_id,
p.head,
init_quality,
source_type,
source_quality,
source_pattern_id,
n.the_geom
FROM selector_sector,
selector_inp_dscenario, v_node n
JOIN inp_dscenario_reservoir p USING (node_id)
JOIN cat_dscenario d USING (dscenario_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text 
AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;

  
DROP VIEW IF EXISTS v_edit_inp_reservoir;
CREATE OR REPLACE VIEW v_edit_inp_reservoir AS 
 SELECT n.node_id,
n.elevation,
n.depth,
n.nodecat_id,
n.sector_id,
--n.macrosector_id,
n.dma_id,
n.state,
n.state_type,
n.annotation,
--n.expl_id,
pattern_id,
head,
init_quality,
source_type,
source_quality,
source_pattern_id,
n.the_geom
FROM selector_sector, v_node n
JOIN inp_reservoir USING (node_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;

DROP VIEW IF EXISTS v_edit_inp_dscenario_valve;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_valve AS 
SELECT d.dscenario_id,
p.node_id,
concat(p.node_id,'_n2a') AS nodarc_id,
p.valv_type,
p.pressure,
p.flow,
p.coef_loss,
p.curve_id,
p.minorloss,
p.status,
p.add_settings,
init_quality,
n.the_geom
FROM selector_sector, selector_inp_dscenario, v_node n
JOIN inp_dscenario_valve p USING (node_id)
JOIN cat_dscenario d USING (dscenario_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;

  
DROP VIEW IF EXISTS v_edit_inp_valve;
CREATE OR REPLACE VIEW v_edit_inp_valve AS 
SELECT n.node_id,
n.elevation,
n.depth,
n.nodecat_id,
n.sector_id,
n.dma_id,
--v_node.macrosector_id,
n.state,
n.state_type,
n.annotation,
--v_node.expl_id,
concat(n.node_id,'_n2a') AS nodarc_id,
valv_type,
pressure,
flow,
coef_loss,
curve_id,
minorloss,
to_arc,
status,
custom_dint,
add_settings,
init_quality,
n.the_geom
FROM selector_sector, v_node n
JOIN inp_valve USING (node_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;

DROP VIEW IF EXISTS v_edit_inp_dscenario_virtualvalve;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_virtualvalve AS 
SELECT d.dscenario_id,
p.arc_id,
p.valv_type,
p.pressure,
P.diameter,
p.flow,
p.coef_loss,
p.curve_id,
p.minorloss,
p.status,
--p.add_settings,
init_quality,
a.the_geom
FROM selector_sector, selector_inp_dscenario, v_arc a
JOIN inp_dscenario_virtualvalve p USING (arc_id)
JOIN cat_dscenario d USING (dscenario_id)
WHERE a.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text 
AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_virtualvalve;
CREATE OR REPLACE VIEW v_edit_inp_virtualvalve AS 
SELECT v_arc.arc_id,
v_arc.node_1,
v_arc.node_2,
(v_arc.elevation1 + v_arc.elevation2) / 2::numeric AS elevation,
(v_arc.depth1 + v_arc.depth2) / 2::numeric AS depth,
v_arc.arccat_id,
v_arc.sector_id,
--v_arc.macrosector_id,
v_arc.dma_id,
v_arc.state,
v_arc.state_type,
v_arc.custom_length,
v_arc.annotation,
--v_arc.expl_id,
valv_type,
pressure,
flow,
coef_loss,
curve_id,
minorloss,
status,
init_quality,
v_arc.the_geom
FROM selector_sector,v_arc
JOIN inp_virtualvalve USING (arc_id)
WHERE v_arc.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_dscenario_inlet;
CREATE OR REPLACE VIEW v_edit_inp_dscenario_inlet AS 
SELECT p.dscenario_id, 
node_id, 
initlevel, 
minlevel, 
maxlevel,
diameter, 
minvol, 
curve_id, 
overflow, 
head, 
pattern_id,
mixing_model,
mixing_fraction,
reaction_coeff,
init_quality,
source_type,
source_quality,
source_pattern_id,
n.the_geom
FROM selector_sector, selector_inp_dscenario, v_node n
JOIN inp_dscenario_inlet p USING (node_id)
JOIN cat_dscenario d USING (dscenario_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text 
AND p.dscenario_id = selector_inp_dscenario.dscenario_id AND selector_inp_dscenario.cur_user = "current_user"()::text;


DROP VIEW IF EXISTS v_edit_inp_inlet;
CREATE OR REPLACE VIEW v_edit_inp_inlet AS 
 SELECT n.node_id,
n.elevation,
n.depth,
n.nodecat_id,
n.sector_id,
--n.macrosector_id,
n.dma_id,
n.state,
n.state_type,
n.annotation,
--n.expl_id,
initlevel,
minlevel,
maxlevel,
diameter,
minvol,
curve_id,
pattern_id,
mixing_model,
mixing_fraction,
reaction_coeff,
init_quality,
source_type,
source_quality,
source_pattern_id,
n.the_geom
FROM selector_sector,v_node n
JOIN inp_inlet USING (node_id)
WHERE n.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;

/*
DROP VIEW IF EXISTS v_edit_inp_connec;
CREATE OR REPLACE VIEW v_edit_inp_connec AS 
 SELECT connec.connec_id,
connec.elevation,
connec.depth,
connec.connecat_id,
connec.arc_id,
connec.sector_id,
connec.dma_id,
connec.state,
connec.state_type,
--connec.expl_id,
connec.pjoint_type,
connec.pjoint_id,
connec.annotation,
inp_connec.demand,
inp_connec.pattern_id,
inp_connec.peak_factor,
inp_connec.custom_roughness,
inp_connec.custom_length,
inp_connec.custom_dint,
--connec.epa_type
connec.the_geom
FROM selector_sector,v_connec connec
JOIN inp_connec USING (connec_id)
WHERE connec.sector_id = selector_sector.sector_id AND selector_sector.cur_user = "current_user"()::text;*/



CREATE OR REPLACE VIEW ve_epa_junction AS 
SELECT inp_junction.*,
result_id,
demand_max, 
demand_min,
demand_avg,
head_max, 
head_min, 
head_avg,
press_max, 
press_min, 
press_avg,
quality_max, 
quality_min,
quality_avg
FROM inp_junction 
LEFT JOIN v_rpt_node USING (node_id);

CREATE OR REPLACE VIEW ve_epa_tank AS 
SELECT inp_tank.*, 
result_id,
demand_max, 
demand_min,
demand_avg, 
head_max, 
head_min, 
head_avg,
press_max, 
press_min, 
press_avg,
quality_max, 
quality_min,
quality_avg
FROM inp_tank 
LEFT JOIN v_rpt_node USING (node_id);

CREATE OR REPLACE VIEW ve_epa_reservoir AS 
SELECT inp_reservoir.*, 
result_id,
demand_max, 
demand_min,
demand_avg,
head_max, 
head_min, 
head_avg,
press_max, 
press_min, 
press_avg,
quality_max, 
quality_min,
quality_avg
FROM inp_reservoir 
LEFT JOIN v_rpt_node USING (node_id);

CREATE OR REPLACE VIEW ve_epa_inlet AS 
SELECT inp_inlet.*, 
result_id,
demand_max, 
demand_min,
demand_avg,
head_max, 
head_min, 
head_avg,
press_max, 
press_min,
press_avg, 
quality_max, 
quality_min,
quality_avg
FROM inp_inlet 
LEFT JOIN v_rpt_node USING (node_id);

CREATE OR REPLACE VIEW ve_epa_pipe AS 
SELECT inp_pipe.*, 
result_id,
round(avg(flow_max), 2) as flow_max, 
round(avg(flow_min), 2) as flow_min, 
round(avg(flow_avg), 2) as flow_avg,
round(avg(vel_max), 2) as vel_max, 
round(avg(vel_min), 2) as vel_min,
round(avg(vel_avg), 2) as vel_avg, 
round(avg(headloss_max), 2) as headloss_max, 
round(avg(headloss_min), 2) as headloss_min,
round(avg(uheadloss_max), 2) as uheadloss_max,
round(avg(uheadloss_min), 2) as uheadloss_min, 
round(avg(setting_max), 2) as setting_max, 
round(avg(setting_min), 2) as setting_min, 
round(avg(reaction_max), 2) as reaction_max, 
round(avg(reaction_min), 2) as reaction_min, 
round(avg(ffactor_max), 2) as ffactor_max, 
round(avg(ffactor_min), 2) as ffactor_min
FROM inp_pipe 
LEFT JOIN v_rpt_arc on split_part(v_rpt_arc.arc_id, 'P',1) = inp_pipe.arc_id 
group by inp_pipe.arc_id, result_id;


CREATE OR REPLACE VIEW ve_epa_pump AS 
SELECT inp_pump.*, 
concat(node_id,'_n2a') as nodarc_id,
result_id,
flow_max, 
flow_min, 
flow_avg,
vel_max, 
vel_min,
vel_avg,
headloss_max, 
headloss_min, 
uheadloss_max,
uheadloss_min,
setting_max, 
setting_min, 
reaction_max, 
reaction_min, 
ffactor_max, 
ffactor_min
FROM inp_pump 
LEFT JOIN v_rpt_arc ON concat(node_id,'_n2a') = arc_id;

CREATE OR REPLACE VIEW ve_epa_valve AS 
SELECT inp_valve.*, 
concat(node_id,'_n2a') as nodarc_id,
result_id,
flow_max, 
flow_min, 
flow_avg,
vel_max, 
vel_min,
vel_avg, 
headloss_max, 
headloss_min, 
uheadloss_max,
uheadloss_min,
setting_max, 
setting_min, 
reaction_max, 
reaction_min, 
ffactor_max, 
ffactor_min
FROM inp_valve 
LEFT JOIN v_rpt_arc ON concat(node_id,'_n2a') = arc_id;

CREATE OR REPLACE VIEW ve_epa_shortpipe AS 
 SELECT inp_shortpipe.*,
concat(inp_shortpipe.node_id, '_n2a') AS nodarc_id,
v_rpt_arc.result_id,
v_rpt_arc.flow_max,
v_rpt_arc.flow_min,
v_rpt_arc.flow_avg,
v_rpt_arc.vel_max,
v_rpt_arc.vel_min,
v_rpt_arc.vel_avg,
v_rpt_arc.headloss_max,
v_rpt_arc.headloss_min,
v_rpt_arc.uheadloss_max,
v_rpt_arc.uheadloss_min,
v_rpt_arc.setting_max,
v_rpt_arc.setting_min,
v_rpt_arc.reaction_max,
v_rpt_arc.reaction_min,
v_rpt_arc.ffactor_max,
v_rpt_arc.ffactor_min,
v_rpt_node.demand_max,
v_rpt_node.demand_min,
v_rpt_node.demand_avg,
v_rpt_node.head_max,
v_rpt_node.head_min,
v_rpt_node.head_avg,
v_rpt_node.press_max,
v_rpt_node.press_min,
v_rpt_node.press_avg,
v_rpt_node.quality_max,
v_rpt_node.quality_min,
v_rpt_node.quality_avg
FROM inp_shortpipe
LEFT JOIN v_rpt_node ON inp_shortpipe.node_id = v_rpt_node.node_id::text
LEFT JOIN v_rpt_arc ON concat(inp_shortpipe.node_id, '_n2a') = v_rpt_arc.arc_id::text;

CREATE OR REPLACE VIEW ve_epa_virtualvalve AS 
SELECT inp_virtualvalve.*, 
result_id,
flow_max, 
flow_min, 
flow_avg,
vel_max, 
vel_min,
vel_avg,
headloss_max, 
headloss_min, 
uheadloss_max,
uheadloss_min,
setting_max, 
setting_min, 
reaction_max, 
reaction_min, 
ffactor_max, 
ffactor_min
FROM inp_virtualvalve 
LEFT JOIN v_rpt_arc USING (arc_id);

CREATE OR REPLACE VIEW ve_epa_pump_additional AS
SELECT inp_pump_additional.*, 
concat(node_id,'_n2a') as nodarc_id,
result_id,
flow_max, 
flow_min, 
flow_avg,
vel_max, 
vel_min,
vel_avg, 
headloss_max, 
headloss_min, 
uheadloss_max,
uheadloss_min,
setting_max, 
setting_min, 
reaction_max, 
reaction_min, 
ffactor_max, 
ffactor_min
FROM inp_pump_additional 
LEFT JOIN v_rpt_arc ON concat(node_id,'_n2a',order_id) = arc_id;

CREATE OR REPLACE VIEW ve_epa_connec AS
SELECT inp_connec.*, 
result_id,
demand_max, 
demand_min,
demand_avg,
head_max, 
head_min, 
head_avg,
press_max, 
press_min, 
press_avg,
quality_max, 
quality_min,
quality_avg
FROM inp_connec 
LEFT JOIN v_rpt_node ON connec_id = node_id;


CREATE OR REPLACE VIEW vu_arc  AS
 SELECT arc.arc_id,
    arc.code,
    arc.node_1,
    arc.node_2,
    arc.elevation1,
    arc.depth1,
    arc.elevation2,
    arc.depth2,
    arc.arccat_id,
    cat_arc.arctype_id AS arc_type,
    cat_feature.system_id AS sys_type,
    cat_arc.matcat_id AS cat_matcat_id,
    cat_arc.pnom AS cat_pnom,
    cat_arc.dnom AS cat_dnom,
    arc.epa_type,
    arc.expl_id,
    exploitation.macroexpl_id,
    arc.sector_id,
    sector.name AS sector_name,
    sector.macrosector_id,
    arc.state,
    arc.state_type,
    arc.annotation,
    arc.observ,
    arc.comment,
    st_length2d(arc.the_geom)::numeric(12,2) AS gis_length,
    arc.custom_length,
    arc.minsector_id,
    arc.dma_id,
    dma.name AS dma_name,
    dma.macrodma_id,
    arc.presszone_id,
    presszone.name AS presszone_name,
    arc.dqa_id,
    dqa.name AS dqa_name,
    dqa.macrodqa_id,
    arc.soilcat_id,
    arc.function_type,
    arc.category_type,
    arc.fluid_type,
    arc.location_type,
    arc.workcat_id,
    arc.workcat_id_end,
    arc.buildercat_id,
    arc.builtdate,
    arc.enddate,
    arc.ownercat_id,
    arc.muni_id,
    arc.postcode,
    arc.district_id,
    c.descript::character varying(100) AS streetname,
    arc.postnumber,
    arc.postcomplement,
    d.descript::character varying(100) AS streetname2,
    arc.postnumber2,
    arc.postcomplement2,
    arc.descript,
    concat(cat_feature.link_path, arc.link) AS link,
    arc.verified,
    arc.undelete,
    cat_arc.label,
    arc.label_x,
    arc.label_y,
    arc.label_rotation,
    arc.publish,
    arc.inventory,
    arc.num_value,
    cat_arc.arctype_id AS cat_arctype_id,
    arc.nodetype_1,
    arc.staticpress1,
    arc.nodetype_2,
    arc.staticpress2,
    date_trunc('second'::text, arc.tstamp) AS tstamp,
    arc.insert_user,
    date_trunc('second'::text, arc.lastupdate) AS lastupdate,
    arc.lastupdate_user,
    arc.the_geom,
    arc.depth,
    arc.adate,
    arc.adescript,
    dma.stylesheet ->> 'featureColor'::text AS dma_style,
    presszone.stylesheet ->> 'featureColor'::text AS presszone_style,
    arc.workcat_id_plan,
    arc.asset_id,
    arc.pavcat_id,
    arc.om_state,
    arc.conserv_state,
    e.flow_max,
    e.flow_min,
    e.flow_avg,
    e.vel_max,
    e.vel_min,
    e.vel_avg,
    arc.parent_id,
    arc.expl_id2,
    vst.is_operative
   FROM arc
     LEFT JOIN sector ON arc.sector_id = sector.sector_id
     LEFT JOIN exploitation ON arc.expl_id = exploitation.expl_id
     LEFT JOIN cat_arc ON arc.arccat_id::text = cat_arc.id::text
     JOIN cat_feature ON cat_feature.id::text = cat_arc.arctype_id::text
     LEFT JOIN dma ON arc.dma_id = dma.dma_id
     LEFT JOIN dqa ON arc.dqa_id = dqa.dqa_id
     LEFT JOIN presszone ON presszone.presszone_id::text = arc.presszone_id::text
     LEFT JOIN v_ext_streetaxis c ON c.id::text = arc.streetaxis_id::text
     LEFT JOIN v_ext_streetaxis d ON d.id::text = arc.streetaxis2_id::text
     LEFT JOIN arc_add e ON arc.arc_id::text = e.arc_id::text
     LEFT JOIN value_state_type vst ON vst.id = state_type;


CREATE OR REPLACE VIEW v_arc AS 
SELECT vu_arc.*
FROM vu_arc
JOIN v_state_arc USING (arc_id)
JOIN v_expl_arc e on e.arc_id = vu_arc.arc_id;


CREATE OR REPLACE VIEW v_edit_arc AS 
SELECT * FROM v_arc;

CREATE OR REPLACE VIEW ve_arc AS 
SELECT * FROM v_arc;


SELECT gw_fct_admin_manage_views($${"client":{"lang":"ES"}, "feature":{},
"data":{"viewName":["v_edit_arc"], "fieldName":"is_operative", "action":"ADD-FIELD","hasChilds":"True"}}$$);



CREATE OR REPLACE VIEW vu_node AS
 SELECT node.node_id,
    node.code,
    node.elevation,
    node.depth,
    cat_node.nodetype_id AS node_type,
    cat_feature.system_id AS sys_type,
    node.nodecat_id,
    cat_node.matcat_id AS cat_matcat_id,
    cat_node.pnom AS cat_pnom,
    cat_node.dnom AS cat_dnom,
    node.epa_type,
    node.expl_id,
    exploitation.macroexpl_id,
    node.sector_id,
    sector.name AS sector_name,
    sector.macrosector_id,
    node.arc_id,
    node.parent_id,
    node.state,
    node.state_type,
    node.annotation,
    node.observ,
    node.comment,
    node.minsector_id,
    node.dma_id,
    dma.name AS dma_name,
    dma.macrodma_id,
    node.presszone_id,
    presszone.name AS presszone_name,
    node.staticpressure,
    node.dqa_id,
    dqa.name AS dqa_name,
    dqa.macrodqa_id,
    node.soilcat_id,
    node.function_type,
    node.category_type,
    node.fluid_type,
    node.location_type,
    node.workcat_id,
    node.workcat_id_end,
    node.builtdate,
    node.enddate,
    node.buildercat_id,
    node.ownercat_id,
    node.muni_id,
    node.postcode,
    node.district_id,
    a.descript::character varying(100) AS streetname,
    node.postnumber,
    node.postcomplement,
    b.descript::character varying(100) AS streetname2,
    node.postnumber2,
    node.postcomplement2,
    node.descript,
    cat_node.svg,
    node.rotation,
    concat(cat_feature.link_path, node.link) AS link,
    node.verified,
    node.undelete,
    cat_node.label,
    node.label_x,
    node.label_y,
    node.label_rotation,
    node.publish,
    node.inventory,
    node.hemisphere,
    node.num_value,
    cat_node.nodetype_id,
    date_trunc('second'::text, node.tstamp) AS tstamp,
    node.insert_user,
    date_trunc('second'::text, node.lastupdate) AS lastupdate,
    node.lastupdate_user,
    node.the_geom,
    node.adate,
    node.adescript,
    node.accessibility,
    dma.stylesheet ->> 'featureColor'::text AS dma_style,
    presszone.stylesheet ->> 'featureColor'::text AS presszone_style,
    node.workcat_id_plan,
    node.asset_id,
    node.om_state,
    node.conserv_state,
    node.access_type,
    node.placement_type,
    e.demand_max,
    e.demand_min,
    e.demand_avg,
    e.press_max,
    e.press_min,
    e.press_avg,
    e.head_max,
    e.head_min,
    e.head_avg,
    e.quality_max,
    e.quality_min,
    e.quality_avg,
    node.expl_id2,
    vst.is_operative
   FROM node
     LEFT JOIN cat_node ON cat_node.id::text = node.nodecat_id::text
     JOIN cat_feature ON cat_feature.id::text = cat_node.nodetype_id::text
     LEFT JOIN dma ON node.dma_id = dma.dma_id
     LEFT JOIN sector ON node.sector_id = sector.sector_id
     LEFT JOIN exploitation ON node.expl_id = exploitation.expl_id
     LEFT JOIN dqa ON node.dqa_id = dqa.dqa_id
     LEFT JOIN presszone ON presszone.presszone_id::text = node.presszone_id::text
     LEFT JOIN v_ext_streetaxis a ON a.id::text = node.streetaxis_id::text
     LEFT JOIN v_ext_streetaxis b ON b.id::text = node.streetaxis2_id::text
     LEFT JOIN node_add e ON e.node_id::text = node.node_id::text
     LEFT JOIN value_state_type vst ON vst.id = state_type;


CREATE OR REPLACE VIEW v_node AS 
SELECT vu_node.*
FROM vu_node
JOIN v_state_node USING (node_id)
JOIN v_expl_node e on e.node_id = vu_node.node_id;


CREATE OR REPLACE VIEW v_edit_node AS 
 SELECT v_node.node_id,
    v_node.code,
    v_node.elevation,
    v_node.depth,
    v_node.node_type,
    v_node.sys_type,
    v_node.nodecat_id,
    v_node.cat_matcat_id,
    v_node.cat_pnom,
    v_node.cat_dnom,
    v_node.epa_type,
    v_node.expl_id,
    v_node.macroexpl_id,
    v_node.sector_id,
    v_node.sector_name,
    v_node.macrosector_id,
    v_node.arc_id,
    v_node.parent_id,
    v_node.state,
    v_node.state_type,
    v_node.annotation,
    v_node.observ,
    v_node.comment,
    v_node.minsector_id,
    v_node.dma_id,
    v_node.dma_name,
    v_node.macrodma_id,
    v_node.presszone_id,
    v_node.presszone_name,
    v_node.staticpressure,
    v_node.dqa_id,
    v_node.dqa_name,
    v_node.macrodqa_id,
    v_node.soilcat_id,
    v_node.function_type,
    v_node.category_type,
    v_node.fluid_type,
    v_node.location_type,
    v_node.workcat_id,
    v_node.workcat_id_end,
    v_node.builtdate,
    v_node.enddate,
    v_node.buildercat_id,
    v_node.ownercat_id,
    v_node.muni_id,
    v_node.postcode,
    v_node.district_id,
    v_node.streetname,
    v_node.postnumber,
    v_node.postcomplement,
    v_node.streetname2,
    v_node.postnumber2,
    v_node.postcomplement2,
    v_node.descript,
    v_node.svg,
    v_node.rotation,
    v_node.link,
    v_node.verified,
    v_node.undelete,
    v_node.label,
    v_node.label_x,
    v_node.label_y,
    v_node.label_rotation,
    v_node.publish,
    v_node.inventory,
    v_node.hemisphere,
    v_node.num_value,
    v_node.nodetype_id,
    v_node.tstamp,
    v_node.insert_user,
    v_node.lastupdate,
    v_node.lastupdate_user,
    v_node.the_geom,
    v_node.adate,
    v_node.adescript,
    v_node.accessibility,
    v_node.dma_style,
    v_node.presszone_style,
    man_valve.closed AS closed_valve,
    man_valve.broken AS broken_valve,
    v_node.workcat_id_plan,
    v_node.asset_id,
    v_node.om_state,
    v_node.conserv_state,
    v_node.access_type,
    v_node.placement_type,
    v_node.demand_max, 
    v_node.demand_min, 
    v_node.demand_avg, 
    v_node.press_max, 
    v_node.press_min, 
    v_node.press_avg, 
    v_node.head_max, 
    v_node.head_min, 
    v_node.head_avg, 
    v_node.quality_max, 
    v_node.quality_min, 
    v_node.quality_avg,
    v_node.expl_id2,
    v_node.is_operative
   FROM v_node
     LEFT JOIN man_valve USING (node_id);

CREATE OR REPLACE VIEW ve_node AS 
SELECT * FROM v_node;


SELECT gw_fct_admin_manage_views($${"client":{"lang":"ES"}, "feature":{},
"data":{"viewName":["v_edit_node"], "fieldName":"is_operative", "action":"ADD-FIELD","hasChilds":"True"}}$$);



CREATE OR REPLACE VIEW vu_connec  AS
 SELECT connec.connec_id,
    connec.code,
    connec.elevation,
    connec.depth,
    cat_connec.connectype_id AS connec_type,
    cat_feature.system_id AS sys_type,
    connec.connecat_id,
    connec.expl_id,
    exploitation.macroexpl_id,
    connec.sector_id,
    sector.name AS sector_name,
    sector.macrosector_id,
    connec.customer_code,
    cat_connec.matcat_id AS cat_matcat_id,
    cat_connec.pnom AS cat_pnom,
    cat_connec.dnom AS cat_dnom,
    connec.connec_length,
    connec.state,
    connec.state_type,
    a.n_hydrometer,
    connec.arc_id,
    connec.annotation,
    connec.observ,
    connec.comment,
    connec.minsector_id,
    connec.dma_id,
    dma.name AS dma_name,
    dma.macrodma_id,
    connec.presszone_id,
    presszone.name AS presszone_name,
    connec.staticpressure,
    connec.dqa_id,
    dqa.name AS dqa_name,
    dqa.macrodqa_id,
    connec.soilcat_id,
    connec.function_type,
    connec.category_type,
    connec.fluid_type,
    connec.location_type,
    connec.workcat_id,
    connec.workcat_id_end,
    connec.buildercat_id,
    connec.builtdate,
    connec.enddate,
    connec.ownercat_id,
    connec.muni_id,
    connec.postcode,
    connec.district_id,
    c.descript::character varying(100) AS streetname,
    connec.postnumber,
    connec.postcomplement,
    b.descript::character varying(100) AS streetname2,
    connec.postnumber2,
    connec.postcomplement2,
    connec.descript,
    cat_connec.svg,
    connec.rotation,
    concat(cat_feature.link_path, connec.link) AS link,
    connec.verified,
    connec.undelete,
    cat_connec.label,
    connec.label_x,
    connec.label_y,
    connec.label_rotation,
    connec.publish,
    connec.inventory,
    connec.num_value,
    cat_connec.connectype_id,
    connec.pjoint_id,
    connec.pjoint_type,
    date_trunc('second'::text, connec.tstamp) AS tstamp,
    connec.insert_user,
    date_trunc('second'::text, connec.lastupdate) AS lastupdate,
    connec.lastupdate_user,
    connec.the_geom,
    connec.adate,
    connec.adescript,
    connec.accessibility,
    dma.stylesheet ->> 'featureColor'::text AS dma_style,
    presszone.stylesheet ->> 'featureColor'::text AS presszone_style,
    connec.workcat_id_plan,
    connec.asset_id,
    connec.epa_type,
    connec.om_state,
    connec.conserv_state,
    connec.priority,
    connec.valve_location,
    connec.valve_type,
    connec.shutoff_valve,
    connec.access_type,
    connec.placement_type,
    connec.crmzone_id,
    crm_zone.name AS crmzone_name,
    e.press_max,
    e.press_min,
    e.press_avg,
    e.demand,
    connec.expl_id2,
    vst.is_operative
   FROM connec
     LEFT JOIN ( SELECT connec_1.connec_id,
            count(ext_rtc_hydrometer.id)::integer AS n_hydrometer
           FROM selector_hydrometer,
            ext_rtc_hydrometer
             JOIN connec connec_1 ON ext_rtc_hydrometer.connec_id::text = connec_1.customer_code::text
          WHERE selector_hydrometer.state_id = ext_rtc_hydrometer.state_id AND selector_hydrometer.cur_user = "current_user"()::text
          GROUP BY connec_1.connec_id) a USING (connec_id)
     JOIN cat_connec ON connec.connecat_id::text = cat_connec.id::text
     JOIN cat_feature ON cat_feature.id::text = cat_connec.connectype_id::text
     LEFT JOIN dma ON connec.dma_id = dma.dma_id
     LEFT JOIN sector ON connec.sector_id = sector.sector_id
     LEFT JOIN exploitation ON connec.expl_id = exploitation.expl_id
     LEFT JOIN dqa ON connec.dqa_id = dqa.dqa_id
     LEFT JOIN presszone ON presszone.presszone_id::text = connec.presszone_id::text
     LEFT JOIN crm_zone ON crm_zone.id::text = connec.crmzone_id::text
     LEFT JOIN v_ext_streetaxis c ON c.id::text = connec.streetaxis_id::text
     LEFT JOIN v_ext_streetaxis b ON b.id::text = connec.streetaxis2_id::text
     LEFT JOIN connec_add e ON e.connec_id::text = connec.connec_id::text
     LEFT JOIN value_state_type vst ON vst.id = state_type;



CREATE OR REPLACE VIEW v_connec AS 
 SELECT vu_connec.connec_id,
    vu_connec.code,
    vu_connec.elevation,
    vu_connec.depth,
    vu_connec.connec_type,
    vu_connec.sys_type,
    vu_connec.connecat_id,
    vu_connec.expl_id,
    vu_connec.macroexpl_id,
    (case when a.sector_id is null then vu_connec.sector_id else a.sector_id end) as sector_id,
    vu_connec.sector_name,
    vu_connec.macrosector_id,
    vu_connec.customer_code,
    vu_connec.cat_matcat_id,
    vu_connec.cat_pnom,
    vu_connec.cat_dnom,
    vu_connec.connec_length,
    vu_connec.state,
    vu_connec.state_type,
    vu_connec.n_hydrometer,
    v_state_connec.arc_id,
    vu_connec.annotation,
    vu_connec.observ,
    vu_connec.comment,
    (case when a.minsector_id is null then vu_connec.minsector_id else a.minsector_id end) as minsector_id,
    (case when a.dma_id is null then vu_connec.dma_id else a.dma_id end) as dma_id,
    (case when a.dma_name is null then vu_connec.dma_name else a.dma_name end) as dma_name,
    (case when a.macrodma_id is null then vu_connec.macrodma_id else a.macrodma_id end) as macrodma_id,
    (case when a.presszone_id is null then vu_connec.presszone_id::varchar(30) else a.presszone_id::varchar(30) end) as presszone_id,
    (case when a.presszone_name is null then vu_connec.presszone_name else a.presszone_name end) as presszone_name,
    vu_connec.staticpressure,
    (case when a.dqa_id is null then vu_connec.dqa_id else a.dqa_id end) as dqa_id,
    (case when a.dqa_name is null then vu_connec.dqa_name else a.dqa_name end) as dqa_name,
    (case when a.macrodqa_id is null then vu_connec.macrodqa_id else a.macrodqa_id end) as macrodqa_id,
    vu_connec.soilcat_id,
    vu_connec.function_type,
    vu_connec.category_type,
    vu_connec.fluid_type,
    vu_connec.location_type,
    vu_connec.workcat_id,
    vu_connec.workcat_id_end,
    vu_connec.buildercat_id,
    vu_connec.builtdate,
    vu_connec.enddate,
    vu_connec.ownercat_id,
    vu_connec.muni_id,
    vu_connec.postcode,
    vu_connec.district_id,
    vu_connec.streetname,
    vu_connec.postnumber,
    vu_connec.postcomplement,
    vu_connec.streetname2,
    vu_connec.postnumber2,
    vu_connec.postcomplement2,
    vu_connec.descript,
    vu_connec.svg,
    vu_connec.rotation,
    vu_connec.link,
    vu_connec.verified,
    vu_connec.undelete,
    vu_connec.label,
    vu_connec.label_x,
    vu_connec.label_y,
    vu_connec.label_rotation,
    vu_connec.publish,
    vu_connec.inventory,
    vu_connec.num_value,
    vu_connec.connectype_id,
    (case when a.exit_id is null then vu_connec.pjoint_id else a.exit_id end) as pjoint_id,
    (case when a.exit_type is null then vu_connec.pjoint_type else a.exit_type end) as pjoint_type,
    vu_connec.tstamp,
    vu_connec.insert_user,
    vu_connec.lastupdate,
    vu_connec.lastupdate_user,
    vu_connec.the_geom,
    vu_connec.adate,
    vu_connec.adescript,
    vu_connec.accessibility,
    vu_connec.workcat_id_plan,
    vu_connec.asset_id,
    vu_connec.dma_style,
    vu_connec.presszone_style,
    vu_connec.epa_type,
    vu_connec.priority,
    vu_connec.valve_location,
    vu_connec.valve_type,
    vu_connec.shutoff_valve,
    vu_connec.access_type,
    vu_connec.placement_type,
    vu_connec.press_max,
    vu_connec.press_min,
    vu_connec.press_avg,
    vu_connec.demand,
    vu_connec.om_state,
    vu_connec.conserv_state,
    crmzone_id,
    crmzone_name,
    vu_connec.expl_id2,
    vu_connec.is_operative
   FROM vu_connec
     JOIN v_state_connec USING (connec_id)
    LEFT JOIN (SELECT DISTINCT ON (feature_id) * FROM v_link_connec WHERE state = 2) a ON feature_id = connec_id;
    

CREATE OR REPLACE VIEW v_edit_connec AS 
SELECT * FROM v_connec;

CREATE OR REPLACE VIEW ve_connec AS 
SELECT * FROM v_connec;


SELECT gw_fct_admin_manage_views($${"client":{"lang":"ES"}, "feature":{},
"data":{"viewName":["v_edit_connec"], "fieldName":"is_operative", "action":"ADD-FIELD","hasChilds":"True"}}$$);


CREATE OR REPLACE VIEW vu_link AS
 SELECT l.link_id,
    l.feature_type,
    l.feature_id,
    l.exit_type,
    l.exit_id,
    l.state,
    l.expl_id,
    l.sector_id,
    l.dma_id,
    presszone_id::character varying(16) AS presszone_id,
    l.dqa_id,
    l.minsector_id,
    l.exit_topelev,
    l.exit_elev,
    l.fluid_type,
    st_length2d(l.the_geom)::numeric(12,3) AS gis_length,
    l.the_geom,
    s.name AS sector_name,
    d.name AS dma_name,
    q.name AS dqa_name,
    p.name AS presszone_name,
    s.macrosector_id,
    d.macrodma_id,
    q.macrodqa_id,
    l.expl_id2,
    l.epa_type,
    l.is_operative
   FROM link l
     LEFT JOIN sector s USING (sector_id)
     LEFT JOIN presszone p USING (presszone_id)
     LEFT JOIN dma d USING (dma_id)
     LEFT JOIN dqa q USING (dqa_id);


create or replace view v_link_connec as 
select * from vu_link
JOIN v_state_link_connec USING (link_id);


create or replace view v_link as 
select * from vu_link
JOIN v_state_link USING (link_id);

CREATE OR REPLACE VIEW v_edit_link AS SELECT *
FROM v_link l;