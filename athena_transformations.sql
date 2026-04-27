#IP-to-Integer conversion query
enriched_threat_v_final_dots CREATE TABLE enriched_threat_v_final_dots
WITH (
  format = 'PARQUET',
  external_location = 's3://cyber-pipeline-data/transformed-data/v_final_dots/'
) AS
SELECT 
    t.ip_address,
    t.threat_count,
    g.col3 AS country_name
FROM (
    SELECT 
        trim(col0) AS ip_address, 
        col1 AS threat_count,
        CAST(split_part(trim(col0), '.', 1) AS BIGINT) * 16777216 +
        CAST(split_part(trim(col0), '.', 2) AS BIGINT) * 65536 +
        CAST(split_part(trim(col0), '.', 3) AS BIGINT) * 256 +
        CAST(split_part(trim(col0), '.', 4) AS BIGINT) AS ip_int
    FROM threat_intel
    WHERE col0 LIKE '%.%.%.%' 
    AND col0 NOT LIKE '#%'
    LIMIT 25000
) t
INNER JOIN geoip_lookup g 
ON t.ip_int BETWEEN CAST(g.col0 AS BIGINT) AND CAST(g.col1 AS BIGINT);

#Botnet Density query
CREATE OR REPLACE VIEW high_intensity_threats AS
SELECT country_name, SUM(threat_count) as total_threats
FROM "enriched_threat_v_final_dots"
GROUP BY country_name
HAVING SUM(threat_count) > 1000
ORDER BY total_threats DESC;

CREATE OR REPLACE VIEW botnet_density AS
SELECT 
    country_name, 
    COUNT(DISTINCT ip_address) as unique_ip_count,
    SUM(threat_count) as threat_volume
FROM "enriched_threat_v_final_dots"
GROUP BY country_name
ORDER BY unique_ip_count DESC;
