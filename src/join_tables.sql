\c lg

DROP VIEW IF EXISTS join_tables;

CREATE VIEW join_tables
AS
SELECT
    ma.district_name                      --AS district
   ,ma.subcounty_name
   ,ma.parish_name

   ,ma.qn201_know
 	,ma.qn202_know
 	,ma.qn203_know
 -- 	,ma.qn203_know_other
	-- ,ma.qn203_know_split1
	-- ,ma.qn203_know_split2
	-- ,ma.qn203_know_split3
	-- ,ma.qn203_know_split4
 	,ma.qn204_know
 	,ma.qn205_know
 -- 	,ma.qn205_know_other
 -- 	,ma.qn205_know_otherspecify
	-- ,ma.qn205_know_split1
	-- ,ma.qn205_know_split2
	-- ,ma.qn205_know_split3
	-- ,ma.qn205_know_split4
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
-- --  	,ma.qn213_know_other
-- -- -- 	,ma.qn213_know_split1
-- -- -- 	,ma.qn213_know_split2
-- -- -- 	,ma.qn213_know_split3
 	,ma.qn214_know
 	,ma.qn215_know
-- --  	,ma.qn215_know_other
-- --  	,ma.qn215_know_otherspecify
-- -- -- 	,ma.qn215_know_split1
-- -- -- 	,ma.qn215_know_split2
-- -- -- 	,ma.qn215_know_split3
-- -- -- 	,ma.qn215_know_split4
-- -- -- 	,ma.qn215_know_split5
 	,ma.qn216_know
-- --  	,ma.qn216_know_other
 	,ma.qn217_know
 	,ma.qn218_know
 	,ma.qn219_know
-- --  	,ma.qn219_know_other
 	,ma.qn220_know
-- --  	,ma.qn220_know_other
	,ma.qn221_know
-- -- -- 	,ma.qn221_know_other
 	,ma.qn222_know
 	,ma.qn223_know
 	,ma.qn224_know
-- --  	,ma.qn224_know_other
-- --  	,ma.qn224_know_otherspecify
-- -- -- 	,ma.qn224_know_split1
-- -- -- 	,ma.qn224_know_split2
-- -- -- 	,ma.qn224_know_split3
-- -- -- 	,ma.qn224_know_split4
-- -- -- 	,ma.qn224_know_split5
-- -- -- 	,ma.qn224_know_split6
-- -- -- 	,ma.qn224_know_split7
-- -- -- 	,ma.qn224_know_split8
 	,ma.qn225_know
-- --  	,ma.qn225_know_other
 	,ma.qn226_know
 	,ma.qn227_know
-- --  	,ma.qn227_know_other
-- -- -- 	,ma.qn227_know_split1
-- -- -- 	,ma.qn227_know_split10
-- -- -- 	,ma.qn227_know_split2
-- -- -- 	,ma.qn227_know_split3
-- -- -- 	,ma.qn227_know_split4
-- -- -- 	,ma.qn227_know_split5
-- -- -- 	,ma.qn227_know_split6
-- -- -- 	,ma.qn227_know_split7
-- -- -- 	,ma.qn227_know_split8
-- -- -- 	,ma.qn227_know_split9
  ,ma.qn1001_hhw
	,ma.qn1002_hhw
-- -- 	,ma.qn1002_hhw_other
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
-- -- 	,ma.qn1013_hhw_other
	,ma.qn1014_hhw
-- -- 	,ma.qn1014_hhw_other
  ,ra.qn01_103
  ,ra.qn01_104
  ,ra.qn01_105
  ,ra.qn01_106
  ,ma.totalshops_village
  ,ma.shop_village
  ,CASE
    WHEN (ra.qn01_106 = 'S1') THEN 'S1'
    WHEN (ra.qn01_106 IS NULL) THEN 'missing'
    ELSE 'Not S1'
  END AS qn01_106_binned
FROM mainhh ma
 JOIN child_mortality cm
  ON (ma.hhid = cm.hhid)
 LEFT JOIN roster_adults_edu ra
  ON (cm.hhid = ra.hhid);
