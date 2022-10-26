# Tasks

1. [Docker-compose](src/docker-compose.yml) (Не проверил, презентация чуть ввела в заблуждение на текущий момент актуальная версия уже 15, поставил её...)  
   Output:
   ```bash
   docker ps -a
   CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS                    NAMES
   c4c62c2aa30e   postgres:latest   "docker-entrypoint.s…"   8 seconds ago   Up 7 seconds   0.0.0.0:5432->5432/tcp   postgres
   docker exec -it postgres bash
   root@c4c62c2aa30e:/# psql -U postgres
   # вывод списка БД
   postgres=# \l
   # подключение к БД
   postgres=# \c db_name
   # вывод списка таблиц
   postgres=# \dt или postgres=# \dt+
   # вывод описания содержимого таблиц
   postgres=# \d pg_database
   # выход из psql
   postgres=# \q
   ```
2. Output and queries:
   ```bash
   postgres=# create database test_database;
   root@c4c62c2aa30e:/# psql -U postgres test_database < /backup/test_dump.sql
   postgres=# \c test_database 
   test_database=# \d
                 List of relations
    Schema |     Name      |   Type   |  Owner   
   --------+---------------+----------+----------
    public | orders        | table    | postgres
    public | orders_id_seq | sequence | postgres
   (2 rows)

   test_database=# analyze verbose public.orders;
   INFO:  analyzing "public.orders"
   INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
   ANALYZE

   test_database=# select tablename, attname, avg_width from pg_stats where avg_width in (select max(avg_width) from pg_stats where tablename = 'orders') and tablename = 'orders';
    tablename | attname | avg_width 
   -----------+---------+-----------
    orders    | title   |        16
   (1 row)
   ```
3. Transaction:
   ```sql
   begin;
   alter table orders rename to orders_old;
   create table orders as table orders_old with no data;
   create table orders_1 (
       check (price > 499)
   ) inherits (orders);
   create table orders_2 (
       check (price <= 499)
   ) inherits (orders);
   create rule orders_1_insert as
   on insert to orders where
       (price > 499)
   do instead
       insert into orders_1 values (new.*);
   create rule orders_2_insert as
   on insert to orders where
       (price <= 499)
   do instead
       insert into orders_2 values (new.*);
   insert into orders
   select * from orders_old;
   commit;
   ```
   Check:
   ```sql
   test_database=# \dt+
                                           List of relations
    Schema |    Name    | Type  |  Owner   | Persistence | Access method |    Size    | Description 
   --------+------------+-------+----------+-------------+---------------+------------+-------------
    public | orders     | table | postgres | permanent   | heap          | 0 bytes    | 
    public | orders_1   | table | postgres | permanent   | heap          | 8192 bytes | 
    public | orders_2   | table | postgres | permanent   | heap          | 8192 bytes | 
    public | orders_old | table | postgres | permanent   | heap          | 8192 bytes | 

   test_database=# table orders_1;
    id |       title        | price 
   ----+--------------------+-------
     2 | My little database |   500
     6 | WAL never lies     |   900
     8 | Dbiezdmin          |   501

   test_database=# table orders_2;
    id |        title         | price 
   ----+----------------------+-------
     1 | War and peace        |   100
     3 | Adventure psql time  |   300
     4 | Server gravity falls |   300
     5 | Log gossips          |   123
     7 | Me and my bash-pet   |   499
   ```
   Проектирование таблицы `orders` с учётом разбивки:
   ```sql
   create table orders (
       id integer not null,
       title character varying(80) not null,
       price integer default 0
   ) partition by range (price);
   create table orders_1 partition of orders
       for values greater than ('499');
   create table orders_2 partition of orders
       for values from ('0') to ('499');
   ```
4. Dump:
   ```bash
   root@c4c62c2aa30e:/# pg_dump -U postgres -v -f /backup/test_dump_my.sql
   ```
   Unique for `title`(need to add `unique`):
   ```sql
   create table orders (
       id integer not null,
       title character varying(80) not null unique,
       price integer default 0
   );
   ```