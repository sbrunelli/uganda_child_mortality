/*
  This view is the main data provider.
  It joins together all database tables, each of which represents a different survey section.

  This way the machine learning part of the project as a unified flat view of the survey
  as a single table.
*/

\c lg

DROP VIEW IF EXISTS features;
DROP VIEW IF EXISTS survey;

CREATE VIEW survey AS
SELECT
  ma.district_name
 ,ma.subcounty_name
 ,ma.parish_name
 ,ma.village_name_old
 ,cm.qn01_405
 ,cm.qn01_405_othr
 ,ra.qn01_103
 ,ra.qn01_104
 ,ra.qn01_105
 ,ra.qn01_106
 ,ma.qn201_know
 ,ma.qn202_know
 ,ma.qn203_know
 ,ma.qn204_know
 ,ma.qn205_know
 ,ma.qn206a_know
 ,ma.qn206b_know
 ,ma.qn206c_know
 ,ma.qn206d_know
 ,ma.qn207a_know
 ,ma.qn208_know
 ,ma.qn209a_know
 ,ma.qn209b_know
 ,ma.qn209c_know
 ,ma.qn210_know
 ,ma.qn211a_know
 ,ma.qn211b_know
 ,ma.qn211c_know
 ,ma.qn212_know
 ,ma.qn213_know
 ,ma.qn214_know
 ,ma.qn215_know
 ,ma.qn216_know
 ,ma.qn217_know
 ,ma.qn218_know
 ,ma.qn219_know
 ,ma.qn220_know
 ,ma.qn221_know
 ,ma.qn222_know
 ,ma.qn223_know
 ,ma.qn224_know
 ,ma.qn225_know
 ,ma.qn226_know
 ,ma.qn227_know
 ,ml.qn302c_mal
 ,ml.qn303c_mal
 ,ml.qn304c_mal
 ,ml.qn305c_mal
 ,ml.qn306c_mal
 ,ml.qn307c_mal
 ,ml.qn308c_mal
 ,ml.qn309ac_mal
 ,ml.qn309bc_mal
 ,ml.qn310c_mal
 ,ml.qn310bc_mal
 ,ml.qn311c_mal
 ,ml.qn311bc_mal
 ,ml.qn312c_mal
 ,ml.qn313c_mal
 ,ml.qn313bc_mal
 ,ml.qn314c_mal
 ,ml.qn314bc_mal
 ,ml.qn315c_mal
 ,ml.qn315bc_mal
 ,ml.qn316c_mal
 ,ml.qn317c_mal
 ,ml.qn318c_mal
 ,ml.qn319c_mal
 ,ml.qn320c_mal
 ,dh.qn502c_dia
 ,dh.qn503c_dia
 ,dh.qn504c_dia
 ,dh.qn505ca_dia
 ,dh.qn505cb_dia
 ,dh.qn506c_dia
 ,dh.qn506cb_dia
 ,dh.qn507c_dia
 ,dh.qn508c_dia
 ,dh.qn508cb_dia
 ,dh.qn509c_dia
 ,dh.qn509cb_dia
 ,dh.qn510c_dia
 ,dh.qn511c_dia
 ,dh.qn512c_dia
 ,dh.qn513c_dia
 ,fo.qn602c_fort
 ,fo.qn603c_fort
 ,fo.qn604cb_fort
 ,fo.qn604c_fort
 ,fo.qn605c_fort
 ,fo.qn606c_fort
 ,fo.qn607c_fort
 ,ma.qn701_chp
 ,ma.qn702_chp
 ,ma.qn703_chp
 ,ma.qn704_chp
 ,ma.qn705_chp
 ,ma.qn706a_chp
 ,ma.qn706b_chp
 ,ma.qn707a_chp
 ,ma.qn707b_chp
 ,ma.qn708_chp
 ,ma.qn709_chp
 ,ma.qn710_chp
 ,ma.qn710b_chp
 ,ma.qn711_chp
 ,ma.qn712_chp
 ,ma.qn713_chp
 ,ma.qn714_chp
 ,ma.qn715_chp
 ,ma.qn716_chp
 ,ma.qn717_chp
 ,ma.qn718_chp
 ,ma.qn719_chp
 ,ma.qn720_chp
 ,ma.qn721_chp
 ,ma.qn722_chp
 ,ma.qn723_chp
 ,ma.qn724_chp
 ,ma.qn725_chp
 ,ma.qn725a_chp
 ,ma.qn725b_chp
 ,ma.qn725c_chp
 ,ma.qn726_chp
 ,ma.qn726a_chp
 ,ma.qn726b_chp
 ,ma.qn726c_chp
 ,ma.qn727_chp
 ,ma.qn728_chp
 ,ma.qn729_chp
 ,ma.qn730_chp
 ,ma.qn731_chp
 ,ma.qn732_chp
 ,ma.qn733_chp
 ,ma.qn734_chp
 ,ma.qn735_chp
 ,ma.qn736_chp
 ,ma.qn737_chp
 ,ma.qn738_chp
 ,ma.qn739_chp
 ,ma.qn740_chp
 ,ma.qn741_chp
 ,pn.qn801w
 ,pn.qn8id
 ,pn.qn803w_pnc
 ,pn.qn804w_pnc
 ,pn.qn805w_pnc
 ,pn.qn806w_pnc
 ,pn.qn807w_pnc
 ,pn.qn808w_pnc
 ,pn.qn809w_pnc
 ,pn.qn810w_pnc
 ,pn.qn811w_pnc
 ,pn.qn812w_pnc
 ,pn.qn813w_pnc
 ,pn.qn814w_pnc
 ,pn.qn815w_pnc
 ,pn.qn816w_pnc
 ,pn.qn817w_pnc
 ,pn.qn818w_pnc
 ,pn.qn819w_pnc
 ,pn.qn820w_pnc
 ,pn.qn820aw_pnc
 ,pn.qn821w_pnc
 ,pn.qn822w_pnc
 ,pn.qn822aw_pnc
 ,pn.qn823w_pnc
 ,pn.qn824w_pnc
 ,pn.qn824aw_pnc
 ,pn.qn825w_pnc
 ,pn.qn826w_pnc
 ,pn.qn826aw_pnc
 ,pn.qn827w_pnc
 ,pn.qn828w_pnc
 ,pn.qn828aw_pnc
 ,pn.qn829w_pnc
 ,pn.qn830w_pnc
 ,pn.qn830aw_pnc
 ,pn.qn831w_pnc
 ,pn.qn832w_pnc
 ,pn.qn832aw_pnc
 ,pn.qn833w_pnc
 ,pn.qn834w_pnc
 ,pn.qn834aw_pnc
 ,pn.qn835w_pnc
 ,pn.qn836w_pnc
 ,pn.qn836aw_pnc
 ,pn.qn837w_pnc
 ,an.qn901w
 ,an.qn9id
 ,an.qn903w_anc
 ,an.qn904w_anc
 ,an.qn905w_anc
 ,an.qn906w_anc
 ,an.qn907w_anc
 ,an.qn908w_anc
 ,an.qn909w_anc
 ,an.qn910w_anc
 ,an.qn911w_anc
 ,an.qn912w_anc
 ,ma.qn1001_hhw
 ,ma.qn1002_hhw
 ,ma.qn1003_hhw
 ,ma.qn1004_hhw
 ,ma.qn1005_hhw
 ,ma.qn1006_hhw
 ,ma.qn1007_hhw
 ,ma.qn1008_hhw
 ,ma.qn1009_hhw
 ,ma.qn1010_hhw
 ,ma.qn1011_hhw
 ,ma.qn1012_hhw
 ,ma.qn1013_hhw
 ,ma.qn1014_hhw
 ,ma.villagename_actual
 ,ma.subcounty_actual
 ,ma.parish_actual
 ,ma.totalshops_village
 ,ma.shop_village
 ,ma.mchildren2008_village
 ,ma.bednets_village
 ,cm.childid
 ,cm.datebirth
 ,cm.female
 ,cm.died
 ,cm.datedeath
FROM child_mortality cm
LEFT JOIN mainhh ma
 ON (ma.hhid = cm.hhid)
LEFT JOIN malaria ml
 ON (cm.hhid = ml.hhid AND cm.childid = ml.childid)
LEFT JOIN diarrhea_u5 dh
  ON (cm.hhid = dh.hhid AND cm.childid = dh.childid)
LEFT JOIN fortified_u5 fo
  ON (cm.hhid = fo.hhid AND cm.childid = fo.childid)
LEFT JOIN postnatal pn
   ON (cm.hhid = pn.hhid)
LEFT JOIN antenatal an
   ON (cm.hhid = an.hhid)
LEFT JOIN roster_adults_edu ra
 ON (cm.hhid = ra.hhid);
