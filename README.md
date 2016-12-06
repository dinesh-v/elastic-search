# Elastic search performance
This project contains exported SQL and elastic search data, which can be used to compare performance of elastic search engine over MySQL and Oracle database

# Pre-requisite
~~~
 1. Elastic search
 2. Kibana
 3. Database
     3.1 Oracle
     3.2 MySQL
 4. Node js - Elastic search import & export
    4.1 [taskrabbit/elasticsearch-dump](https://github.com/taskrabbit/elasticsearch-dump)
~~~ 
# Elastic Search
GET /medical_insurance/ipps_summary/_search?q=provider_name:*bay*
	Result : "took": 31 (millisecond) = 0.031 sec
# MySQL
select * from ipps_summary where provider_name LIKE "%bay%";
	Result : 2162 rows in set (0.10 sec)
# Oracle
SELECT
    id,
    provider_id,
    drg_definition,
    provider_name,
    provider_street_address,
    provider_city,
    provider_state,
    provider_zip_code,
    hrrd,
    total_discharges,
    average_covered_charges,
    average_total_payments,
    average_medicare_payments
FROM
    ipps_summary
WHERE
    provider_name LIKE '%BAY%';
       Result : 1+ seconds