DROP TABLE IF EXISTS test_table_facebook;

CREATE EXTERNAL TABLE test_table_facebook (
	userId string,
	command string,
	segmentTimestamps map<string,string>
) 
STORED AS PARQUET
LOCATION '/user/cloudera/spark_output/out17/facebook';
