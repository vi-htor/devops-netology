# Tasks

1. [Docker-compose](src/docker-compose.yml)
   Commands and queries:  
   ```bash
   docker ps -a
   CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                               NAMES
   a2d4d154fc65   mysql:latest   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   0.0.0.0:3306->3306/tcp, 33060/tcp   mysql
   docker exec -it mysql bash
   bash-4.4# mysql -u root -p db < /backup/test_dump.sql 
   bash-4.4# mysql -u root -p
   mysql> \s
   --------------
   mysql  Ver 8.0.31 for Linux on aarch64 (MySQL Community Server - GPL)
   mysql> use db;
   Reading table information for completion of table and column names
   You can turn off this feature to get a quicker startup with -A

   Database changed
   mysql> show tables;
   +--------------+
   | Tables_in_db |
   +--------------+
   | orders       |
   +--------------+
   1 row in set (0.00 sec)
   mysql> SELECT count(*) FROM orders WHERE price > 300;
   +----------+
   | count(*) |
   +----------+
   |        1 |
   +----------+
   1 row in set (0.00 sec)
   ```
2. Queries for create user and grant him permissions:
   ```bash
   mysql> CREATE USER 'test'@'localhost'
       -> IDENTIFIED WITH mysql_native_password BY 'test-pass'
       -> WITH MAX_QUERIES_PER_HOUR 100
       -> PASSWORD EXPIRE INTERVAL 180 DAY
       -> FAILED_LOGIN_ATTEMPTS 3
       -> ATTRIBUTE '{"fname": "James", "lname": "Pretty"}';
   mysql> GRANT SELECT ON test_db.* TO 'test'@'localhost';
   ```
   Data about new user from `INFORMATION_SCHEMA.USER_ATTRIBUTES`:
   ```bash
   mysql> select * from information_schema.user_attributes where user='test';
   +------+-----------+---------------------------------------+
   | USER | HOST      | ATTRIBUTE                             |
   +------+-----------+---------------------------------------+
   | test | localhost | {"fname": "James", "lname": "Pretty"} |
   +------+-----------+---------------------------------------+
   ```
3. Queries:
   ```bash
   mysql> use db
   Database changed
   mysql> SET profiling = 1;
   mysql> SHOW PROFILES;
   +----------+------------+-------------------+
   | Query_ID | Duration   | Query             |
   +----------+------------+-------------------+
   |        1 | 0.00021950 | SELECT DATABASE() |
   |        2 | 0.00067775 | SET profiling = 1 |
   +----------+------------+-------------------+
   ---
   mysql> select table_name, engine from information_schema.tables where table_schema='db';
   +------------+--------+
   | TABLE_NAME | ENGINE |
   +------------+--------+
   | orders     | InnoDB |
   +------------+--------+
   mysql> alter table orders engine = myisam;
   Query OK, 5 rows affected (0.14 sec)
   Records: 5  Duplicates: 0  Warnings: 0

   mysql> alter table orders engine = innodb;
   Query OK, 5 rows affected (0.12 sec)
   Records: 5  Duplicates: 0  Warnings: 0

   mysql> show profiles;
   +----------+------------+----------------------------------------------------------------------------------+
   | Query_ID | Duration   | Query                                                                            |
   +----------+------------+----------------------------------------------------------------------------------+
   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
   |        6 | 0.13941550 | alter table orders engine = myisam                                               |
   |        7 | 0.12010900 | alter table orders engine = innodb                                               |
   +----------+------------+----------------------------------------------------------------------------------+
   ```
4. [my.cnf](src/my.cnf)