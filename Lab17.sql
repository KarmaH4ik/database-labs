pg_dump postgres_db > postgres_db_backup.sql

psql postgres_db < postgres_db_backup.sql

\copy people TO '/tmp/people.csv' DELIMITER ',' CSV HEADER;

\copy people FROM '/tmp/people.csv' DELIMITER ',' CSV HEADER;

pg_dump -t people postgres_db > people_table_backup.sql

psql postgres_db < people_table_backup.sql


