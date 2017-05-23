\c lg

DROP VIEW IF EXISTS roster_adults_edu;

CREATE VIEW roster_adults_edu AS
SELECT hhid, qn01_103, qn01_104, qn01_105, qn01_106
FROM (
  SELECT hhid, qn01_103, qn01_104, qn01_105, qn01_106,
    qn01_106_code, MAX(qn01_106_code) OVER(PARTITION BY hhid) AS qn01_106_code_max
  FROM (
    SELECT hhid,
      qn01_103,
      qn01_104,
      qn01_105,
      qn01_106,
      CASE qn01_106
        WHEN 'P1' THEN 2
        WHEN 'P2' THEN 3
        WHEN 'P3' THEN 4
        WHEN 'P4' THEN 5
        WHEN 'P5' THEN 6
        WHEN 'P6' THEN 7
        WHEN 'P7' THEN 8
        WHEN 'S1' THEN 9
        WHEN 'S2' THEN 10
        WHEN 'S3' THEN 11
        WHEN 'S4' THEN 12
        WHEN 'J1' THEN 13
        WHEN 'J2' THEN 14
        WHEN 'J3' THEN 15
        WHEN 'S5' THEN 16
        WHEN 'S6' THEN 17
        WHEN 'C1' THEN 18
        WHEN 'C1' THEN 19
        WHEN 'C1' THEN 20
        WHEN 'Diploma' THEN 21
        WHEN 'University Degree' THEN 22
        WHEN 'No Education' THEN 0
        WHEN 'Other' THEN 1
      END qn01_106_code
    FROM roster_adults
    WHERE qn01_105 = 'Household Head') AS pass1) AS pass2
WHERE qn01_106_code = qn01_106_code_max;
