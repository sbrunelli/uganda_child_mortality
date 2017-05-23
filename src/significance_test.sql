\c lg

DROP VIEW IF EXISTS significance_test;

CREATE VIEW significance_test AS
SELECT
  ma.district_name
 ,ma.subcounty_name
 ,ma.parish_name
 -- ,ma.village_name_old
 -- ,ma.qn0_06
 -- ,ma.qn0_06b
 -- ,ma.qn0_06c
 -- ,ma.qn0_07
 -- ,ma.qn0_07_othr
 -- ,ma.qn0_08
 -- ,ma.qn0_08b
 -- ,ma.qn0_09
 -- ,ma.qn0_11
 -- ,ma.qn0_15
 -- ,ma.qn0_16
 -- ,ma.qn0_16b_1
 -- ,ma.qn0_16b_note1
 -- ,ma.qn0_16b_2
 -- ,ma.qn0_16b_note2
 -- ,ma.qn0_16b_3
 -- ,ma.qn0_16b_note3
 -- ,ma.qn0_16b_4
 -- ,ma.qn0_16b_note4
 -- ,ma.qn0_17_b1
 -- ,ma.qn0_17_bcheck1
 -- ,ma.qn0_17_bcheck_other1
 -- ,ma.qn0_17_b2
 -- ,ma.qn0_17_bcheck2
 -- ,ma.qn0_17_bcheck_other2
 -- ,ma.qn0_17_b3
 -- ,ma.qn0_17_bcheck3
 -- ,ma.qn0_17_bcheck_other3
 -- ,ma.qn0_17_b4
 -- ,ma.qn0_17_bcheck4
 -- ,ma.qn0_17_bcheck_other4
 -- ,ma.qn0_18_g1
 -- ,ma.qn0_18_g1_female
 -- ,ma.qn0_18_g2
 -- ,ma.qn0_18_g3
 -- ,ma.qn0_18_g4
 -- ,ma.qn0_19_d1
 -- ,ma.qn0_19_dcheck1
 -- ,ma.qn0_19_dcheck_other1
 -- ,ma.qn0_19_d2
 -- ,ma.qn0_19_dcheck2
 -- ,ma.qn0_19_dcheck_other2
 -- ,ma.qn0_19_d3
 -- ,ma.qn0_19_dcheck3
 -- ,ma.qn0_19_dcheck_other3
 -- ,ma.qn0_19_d4
 -- ,ma.qn0_19_dcheck4
 -- ,ma.qn0_19_dcheck_other4
 -- ,ma.qn0_20_cause1
 -- ,ma.qn0_20_othr
 -- ,ma.qn0_20_cause2
 -- ,ma.qn0_20_othr2
 -- ,ma.qn0_20_cause3
 -- ,ma.qn0_20_othr3
 -- ,ma.qn0_20_cause4
 -- ,ma.qn0_20_othr4
 -- ,cm.qn01_405
 -- ,cm.qn01_405_othr
 ,ra.qn01_103
 ,ra.qn01_104
 ,ra.qn01_105
 ,ra.qn01_106
 ,ma.qn201_know
 ,ma.qn202_know
 ,ma.qn203_know
 -- ,ma.qn203_know_split1
 -- ,ma.qn203_know_split2
 -- ,ma.qn203_know_split3
 -- ,ma.qn203_know_split4
 -- ,ma.qn203_know_other
 ,ma.qn204_know
 ,ma.qn205_know
 -- ,ma.qn205_know_other
 -- ,ma.qn205_know_otherspecify
 ,ma.qn206a_know
 ,ma.qn206b_know
 ,ma.qn206c_know
 ,ma.qn206d_know
 -- ,ma.qn206_malflag1
 -- ,ma.qn206_malflag2
 -- ,ma.qn206_malflag3
 -- ,ma.qn206_malflag4
 ,ma.qn206_totmalflag5
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
 -- ,ma.qn213_know_split1
 -- ,ma.qn213_know_split2
 -- ,ma.qn213_know_split3
 -- ,ma.qn213_know_other
 ,ma.qn214_know
 ,ma.qn215_know
 -- ,ma.qn215_know_split1
 -- ,ma.qn215_know_split2
 -- ,ma.qn215_know_split3
 -- ,ma.qn215_know_split4
 -- ,ma.qn215_know_split5
 -- ,ma.qn215_know_other
 -- ,ma.qn215_know_otherspecify
 ,ma.qn216_know
 -- ,ma.qn216_know_other
 ,ma.qn217_know
 ,ma.qn218_know
 ,ma.qn219_know
 -- ,ma.qn219_know_other
 ,ma.qn220_know
 -- ,ma.qn220_know_other
 ,ma.qn221_know
 -- ,ma.qn221_know_other
 ,ma.qn222_know
 ,ma.qn223_know
 ,ma.qn224_know
 -- ,ma.qn224_know_split1
 -- ,ma.qn224_know_split2
 -- ,ma.qn224_know_split3
 -- ,ma.qn224_know_split4
 -- ,ma.qn224_know_split5
 -- ,ma.qn224_know_split6
 -- ,ma.qn224_know_split7
 -- ,ma.qn224_know_split8
 -- ,ma.qn224_know_other
 -- ,ma.qn224_know_otherspecify
 ,ma.qn225_know
 -- ,ma.qn225_know_other
 ,ma.qn226_know
 ,ma.qn227_know
 -- ,ma.qn227_know_split1
 -- ,ma.qn227_know_split2
 -- ,ma.qn227_know_split3
 -- ,ma.qn227_know_split4
 -- ,ma.qn227_know_split5
 -- ,ma.qn227_know_split6
 -- ,ma.qn227_know_split7
 -- ,ma.qn227_know_split8
 -- ,ma.qn227_know_split9
 -- ,ma.qn227_know_split10
 -- ,ma.qn227_know_other
 -- ,ml.qn302c_mal
 -- ,ml.qn303c_mal
 -- ,ml.qn304c_mal
 -- ,ml.qn305c_mal
 -- ,ml.qn305c_mal_other
 -- ,ml.qn306c_mal
 -- ,ml.qn307c_mal
 -- ,ml.qn308c_mal
 -- ,ml.qn308c_mal_other
 -- ,ml.qn309c_mal_other
 -- ,ml.qn309ac_mal
 -- ,ml.qn309bc_mal
 -- ,ml.qn310c_mal
 -- ,ml.qn310bc_mal
 -- ,ml.qn311c_mal
 -- ,ml.qn311c_mal_other
 -- ,ml.qn311bc_mal
 -- ,ml.qn311bc_mal_other
 -- ,ml.qn312c_mal
 -- ,ml.qn313c_mal
 -- ,ml.qn313c_mal_other
 -- ,ml.qn313bc_mal
 -- ,ml.qn313bc_mal_other
 -- ,ml.qn314c_mal
 -- ,ml.qn314bc_mal
 -- ,ml.qn315c_mal
 -- ,ml.qn315bc_mal
 -- ,ml.qn316c_mal
 -- ,ml.qn317c_mal
 -- ,ml.qn318c_mal
 -- ,ml.qn318c_mal_other
 -- ,ml.qn319c_mal
 -- ,ml.qn320c_mal
 -- ,ml.qn320c_mal_other
 -- ,ml.qn313c_mal_split1
 -- ,ml.qn313bc_mal_split1
 -- ,ml.qn313c_mal_split2
 -- ,ml.qn313bc_mal_split2
 -- ,dh.qn502c_dia
 -- ,dh.qn503c_dia
 -- ,dh.qn504c_dia
 -- ,dh.qn504c_dia_other
 -- ,dh.qn505c_dia_other
 -- ,dh.qn505ca_dia
 -- ,dh.qn505cb_dia
 -- ,dh.qn506c_dia
 -- ,dh.qn506c_dia_other
 -- ,dh.qn506cb_dia
 -- ,dh.qn506cb_dia_other
 -- ,dh.qn507c_dia
 -- ,dh.qn508c_dia
 -- ,dh.qn508cb_dia
 -- ,dh.qn509c_dia
 -- ,dh.qn509cb_dia
 -- ,dh.qn510c_dia
 -- ,dh.qn511c_dia
 -- ,dh.qn511c_dia_other
 -- ,dh.qn512c_dia
 -- ,dh.qn513c_dia
 -- ,dh.qn513c_dia_other
 -- ,dh.qn506cb_dia_other1specify
 -- ,dh.qn506cb_dia_other2specify
 -- ,dh.qn506cb_dia_other3specify
 -- ,dh.qn506cb_dia_other4specify
 -- ,dh.qn506cb_dia_other5specify
 -- ,dh.qn506cb_dia_other6specify
 -- ,dh.qn506c_dia_split1
 -- ,dh.qn506cb_dia_split1
 -- ,dh.qn506cb_dia_split2
 -- ,dh.qn506c_dia_split2
 -- ,fo.qn602c_fort
 -- ,fo.qn603c_fort
 -- ,fo.qn604cb_fort
 -- ,fo.qn604c_fort
 -- ,fo.qn605c_fort
 -- ,fo.qn606c_fort
 -- ,fo.qn607c_fort
 -- ,fo.qn607c_fort_other
 -- ,fo.qn607c_fort_other1specify
 -- ,fo.qn607c_fort_other2specify
 -- ,fo.qn607c_fort_other3specify
 -- ,fo.qn607c_fort_other4specify
 -- ,fo.qn607c_fort_other5specify
 -- ,fo.qn607c_fort_other6specify
 -- ,fo.qn607c_fort_split1
 -- ,fo.qn607c_fort_split2
 -- ,fo.qn607c_fort_split3
 -- ,fo.qn607c_fort_split4
 -- ,fo.qn607c_fort_split5
 -- ,fo.qn607c_fort_split6
 -- ,fo.qn607c_fort_split7
 -- ,fo.qn607c_fort_split8
 -- ,ma.qn701_chp
 -- ,ma.qn702_chp
 -- ,ma.qn702_chp1
 -- ,ma.qn702_chp2
 -- ,ma.qn702_chp_other
 -- ,ma.qn702_chp_otherspecify
 -- ,ma.qn703_chp
 -- ,ma.qn704_chp
 -- ,ma.qn704_chp1
 -- ,ma.qn704_chp2
 -- ,ma.qn704_chp3
 -- ,ma.qn704_chp4
 -- ,ma.qn704_chp5
 -- ,ma.qn704_chp6
 -- ,ma.qn705_chp
 -- ,ma.qn706a_chp
 -- ,ma.qn706b_chp
 -- ,ma.qn707a_chp
 -- ,ma.qn707b_chp
 -- ,ma.qn708_chp
 -- ,ma.qn709_chp
 -- ,ma.qn709_chp1
 -- ,ma.qn709_chp2
 -- ,ma.qn709_chp3
 -- ,ma.qn709_chp4
 -- ,ma.qn709_chp5
 -- ,ma.qn709_chp_other
 -- ,ma.qn710_chp
 -- ,ma.qn710b_chp
 -- ,ma.qn711_chp
 -- ,ma.qn712_chp
 -- ,ma.qn712_chp1
 -- ,ma.qn712_chp2
 -- ,ma.qn712_chp3
 -- ,ma.qn712_chp4
 -- ,ma.qn712_chp5
 -- ,ma.qn712_chp6
 -- ,ma.qn712_chp_other
 -- ,ma.qn713_chp
 -- ,ma.qn714_chp
 -- ,ma.qn715_chp
 -- ,ma.qn716_chp
 -- ,ma.qn717_chp
 -- ,ma.qn717_chp1
 -- ,ma.qn717_chp2
 -- ,ma.qn717_chp3
 -- ,ma.qn717_chp_other
 -- ,ma.qn718_chp
 -- ,ma.qn719_chp
 -- ,ma.qn720_chp
 -- ,ma.qn720_chp1
 -- ,ma.qn720_chp2
 -- ,ma.qn720_chp3
 -- ,ma.qn720_chp4
 -- ,ma.qn720_chp_other
 -- ,ma.qn720_chp_otherspecify
 -- ,ma.qn721_chp
 -- ,ma.qn721_chp_other
 -- ,ma.qn722_chp
 -- ,ma.qn723_chp
 -- ,ma.qn724_chp
 -- ,ma.qn724_chp1
 -- ,ma.qn724_chp2
 -- ,ma.qn724_chp3
 -- ,ma.qn724_chp_other
 -- ,ma.qn725_chp
 -- ,ma.qn725a_chp
 -- ,ma.qn725b_chp
 -- ,ma.qn725c_chp
 -- ,ma.qn726_chp
 -- ,ma.qn726a_chp
 -- ,ma.qn726b_chp
 -- ,ma.qn726c_chp
 -- ,ma.qn727_chp
 -- ,ma.qn727_chp1
 -- ,ma.qn727_chp2
 -- ,ma.qn727_chp3
 -- ,ma.qn727_chp_other
 -- ,ma.qn728_chp
 -- ,ma.qn729_chp
 -- ,ma.qn729_chpother
 -- ,ma.qn730_chp
 -- ,ma.qn731_chp
 -- ,ma.qn732_chp
 -- ,ma.qn733_chp
 -- ,ma.qn734_chp
 -- ,ma.qn735_chp
 -- ,ma.qn736_chp
 -- ,ma.qn737_chp
 -- ,ma.qn738_chp
 -- ,ma.qn739_chp
 -- ,ma.qn740_chp
 -- ,ma.qn741_chp
 -- ,pn.qn801w
 -- ,pn.qn8id
 -- ,pn.qn803w_pnc
 -- ,pn.qn804w_pnc
 -- ,pn.qn805w_pnc
 -- ,pn.qn806w_pnc
 -- ,pn.qn806w_pnc_other
 -- ,pn.qn807w_pnc
 -- ,pn.qn808w_pnc
 -- ,pn.qn808w_pnc_other
 -- ,pn.qn809w_pnc
 -- ,pn.qn810w_pnc
 -- ,pn.qn810w_pnc_other
 -- ,pn.qn811w_pnc
 -- ,pn.qn812w_pnc
 -- ,pn.qn812w_pnc_other
 -- ,pn.qn813w_pnc
 -- ,pn.qn814w_pnc
 -- ,pn.qn814w_pnc_other
 -- ,pn.qn815w_pnc
 -- ,pn.qn816w_pnc
 -- ,pn.qn817w_pnc
 -- ,pn.qn818w_pnc
 -- ,pn.qn819w_pnc
 -- ,pn.qn820w_pnc
 -- ,pn.qn820aw_pnc
 -- ,pn.qn821w_pnc
 -- ,pn.qn822w_pnc
 -- ,pn.qn822aw_pnc
 -- ,pn.qn823w_pnc
 -- ,pn.qn824w_pnc
 -- ,pn.qn824aw_pnc
 -- ,pn.qn825w_pnc
 -- ,pn.qn826w_pnc
 -- ,pn.qn826aw_pnc
 -- ,pn.qn827w_pnc
 -- ,pn.qn828w_pnc
 -- ,pn.qn828aw_pnc
 -- ,pn.qn829w_pnc
 -- ,pn.qn830w_pnc
 -- ,pn.qn830aw_pnc
 -- ,pn.qn831w_pnc
 -- ,pn.qn832w_pnc
 -- ,pn.qn832aw_pnc
 -- ,pn.qn833w_pnc
 -- ,pn.qn834w_pnc
 -- ,pn.qn834aw_pnc
 -- ,pn.qn835w_pnc
 -- ,pn.qn836w_pnc
 -- ,pn.qn836aw_pnc
 -- ,pn.qn837w_pnc
 -- ,pn.qn810w_pnc_other1specify
 -- ,pn.qn812w_pnc_other1specify
 -- ,pn.qn814w_pnc_other1specify
 -- ,pn.qn810w_pnc_split1
 -- ,pn.qn814w_pnc_split1
 -- ,pn.qn8id_note
 -- ,pn.qn810w_pnc_split2
 -- ,pn.qn810w_pnc_split3
 -- ,pn.qn810w_pnc_split4
 -- ,pn.qn810w_pnc_split5
 -- ,pn.qn812w_pnc_split1
 -- ,pn.qn812w_pnc_split2
 -- ,pn.qn812w_pnc_split3
 -- ,pn.qn812w_pnc_split4
 -- ,pn.qn814w_pnc_split2
 -- ,pn.qn814w_pnc_split3
 -- ,an.qn901w
 -- ,an.qn9id
 -- ,an.qn9id_note
 -- ,an.qn903w_anc
 -- ,an.qn904w_anc
 -- ,an.qn905w_anc
 -- ,an.qn906w_anc
 -- ,an.qn907w_anc
 -- ,an.qn907w_anc_other
 -- ,an.qn908w_anc
 -- ,an.qn909w_anc
 -- ,an.qn910w_anc
 -- ,an.qn910w_anc_other
 -- ,an.qn911w_anc
 -- ,an.qn912w_anc
 -- ,an.qn912w_anc_other
 -- ,an.qn910w_anc_other1specify
 -- ,an.qn912w_anc_other1specify
 -- ,an.qn907w_anc_split1
 -- ,an.qn910w_anc_split1
 -- ,an.qn912w_anc_split1
 -- ,an.qn912w_anc_split2
 -- ,an.qn907w_anc_split2
 -- ,an.qn907w_anc_split3
 -- ,an.qn907w_anc_split4
 -- ,an.qn910w_anc_split2
 -- ,an.qn912w_anc_split3
 ,ma.qn1001_hhw
 ,ma.qn1002_hhw
 -- ,ma.qn1002_hhw_other
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
 -- ,ma.qn1013_hhw_other
 ,ma.qn1014_hhw
 -- ,ma.qn1014_hhw_other
 -- ,ma.villageid
 -- ,ma.districtname_actual
 -- ,ma.districtid
 -- ,ma.villagename_actual
 -- ,ma.subcounty_actual
 -- ,ma.parish_actual
 ,ma.totalshops_village
 ,ma.shop_village
 -- ,ma.hhs_village
 -- ,ma.hhs_village_eligible
 -- ,ma.mchildren2008_village
 -- ,ma.bednets_village
 -- ,ma.district_name_baseline
 -- ,ma.district_id_baseline
 -- ,ma.village_name_baseline
 -- ,cm.childid
 -- ,cm.datebirth
 -- ,cm.female
 ,cm.died
 -- ,cm.datedeath
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
