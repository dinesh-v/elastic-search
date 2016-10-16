CREATE DATABASE medical_insurance;
USE medical_insurance;
CREATE TABLE `ipps_summary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) NOT NULL,
  `drg_definition` varchar(100) NOT NULL,
  `provider_name` varchar(100) NOT NULL,
  `provider_street_address` varchar(100) NOT NULL,
  `provider_city` varchar(50) NOT NULL,
  `provider_state` varchar(5) NOT NULL,
  `provider_zip_code` int(11) NOT NULL,
  `hospital_referral_region_description` varchar(100) NOT NULL,
  `total_discharges` int(11) NOT NULL,
  `average_covered_charges` varchar(30) NOT NULL,
  `average_total_payments` varchar(30) NOT NULL,
  `average_medicare_payments` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DESC ipps_summary;
# Didn't work for me. I used MySQL Workbench to import data from CSV into table
LOAD DATA INFILE '/Users/dinesh/workspace/elastic-search/src/main/resources/ipps_summary.csv'
INTO TABLE ipps_summary
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 2162 rows in set (0.50 sec)
select provider_name from ipps_summary where provider_name like '%bay%';