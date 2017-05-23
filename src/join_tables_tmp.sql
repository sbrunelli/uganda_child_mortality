\c lg

DROP VIEW IF EXISTS join_tables_tmp;

CREATE VIEW join_tables_tmp
AS
SELECT
    ma.parish_name
 	 ,ma.qn204_know
   ,ma.qn209b_know
   ,ma.qn210_know
   ,ma.qn211a_know
 	 ,ma.qn216_know
 	 ,ma.qn217_know
	 ,ma.qn1002_hhw
	 ,ma.qn1009_hhw
   ,ma.shop_village
   ,ma.totalshops_village
   ,cm.died
FROM mainhh ma
 JOIN child_mortality cm
  ON (ma.hhid = cm.hhid)
 LEFT JOIN roster_adults_edu ra
  ON (cm.hhid = ra.hhid);
