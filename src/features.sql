\c lg

DROP VIEW IF EXISTS features;

CREATE VIEW features
AS
SELECT
   parish_name
  ,qn204_know
  ,qn209b_know
  ,qn210_know
  ,qn211a_know
  ,qn211b_know
  ,qn211c_know
  ,qn216_know
  ,qn217_know
  ,qn302c_mal
  ,qn303c_mal
  ,qn304c_mal
  ,qn320c_mal
  ,qn502c_dia
  ,qn503c_dia
  ,qn505ca_dia
  ,qn505cb_dia
  ,qn506cb_dia
  ,qn507c_dia
  ,qn510c_dia
  ,qn512c_dia
  ,qn603c_fort
  ,qn606c_fort
  ,qn706a_chp
  ,qn708_chp
  ,qn727_chp
  ,qn732_chp
  ,qn734_chp
  ,qn1002_hhw
  ,qn1005_hhw
  ,qn1009_hhw
  ,totalshops_village
  ,shop_village
  ,mchildren2008_village
  ,childid
  ,died
FROM survey;
