# Tasks

1. Docker-compose:
   ```yaml
   version: '3.5'
   services:
     postgres:
       container_name: psql
       image: postgres:12
       environment:
         - POSTGRES_USER=postgres
         - POSTGRES_PASSWORD=postgres
       volumes:
         - ./data:/var/lib/postgresql/data
         - ./backup:/data/backup/postgres
       ports:
         - "5432:5432"
       restart: always
       networks:
         - psql

   networks:
     psql:
       driver: bridge
   ```
   Output:
   ```bash
   ~/hmwrk-dev/06-db-01-basics/src  docker ps -a             
   CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                    NAMES
   6944a411eb41   postgres:12   "docker-entrypoint.s…"   14 seconds ago   Up 13 seconds   0.0.0.0:5432->5432/tcp   psql
   ~/hmwrk-dev/06-db-01-basics/src  docker exec -it psql psql --version
   postgres (PostgreSQL) 12.12 (Debian 12.12-1.pgdg110+1)
   ```
2. Код mysql для создания всего требуемого:
   ```sql
   CREATE USER "test-admin-user" WITH LOGIN;
   CREATE DATABASE test_db;
   CREATE TABLE orders (
           id SERIAL PRIMARY KEY, 
           наименование TEXT, 
           цена INT
   );

   CREATE TABLE clients (
           id SERIAL PRIMARY KEY, 
           фамилия TEXT, 
           "страна проживания" TEXT, 
           заказ INT REFERENCES orders (id)
   );

   CREATE INDEX ON clients ("страна проживания");

   GRANT ALL ON TABLE clients, orders TO "test-admin-user";
   CREATE USER "test-simple-user" WITH LOGIN;
   GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE clients,orders TO "test-simple-user";
   ```
   Итоговый список БД:
   ```bash
   test_db=# \l
                                    List of databases
      Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
   -----------+----------+----------+------------+------------+-----------------------
    postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
    template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
              |          |          |            |            | postgres=CTc/postgres
    template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
              |          |          |            |            | postgres=CTc/postgres
    test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
   (4 rows)
   ```
   Описание таблиц:
   ```bash
   test_db=# \d+ orders
                                                      Table "public.orders"
       Column    |  Type   | Collation | Nullable |              Default               | Storage  | Stats target | Description 
   --------------+---------+-----------+----------+------------------------------------+----------+--------------+-------------
    id           | integer |           | not null | nextval('orders_id_seq'::regclass) | plain    |              | 
    наименование | text    |           |          |                                    | extended |              | 
    цена         | integer |           |          |                                    | plain    |              | 
   Indexes:
       "orders_pkey" PRIMARY KEY, btree (id)
   Referenced by:
       TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
   Access method: heap
   test_db=# \d+ clients
                                                         Table "public.clients"
         Column       |  Type   | Collation | Nullable |               Default               | Storage  | Stats target | Description 
   -------------------+---------+-----------+----------+-------------------------------------+----------+--------------+-------------
    id                | integer |           | not null | nextval('clients_id_seq'::regclass) | plain    |              | 
    фамилия           | text    |           |          |                                     | extended |              | 
    страна проживания | text    |           |          |                                     | extended |              | 
    заказ             | integer |           |          |                                     | plain    |              | 
   Indexes:
       "clients_pkey" PRIMARY KEY, btree (id)
       "clients_страна проживания_idx" btree ("страна проживания")
   Foreign-key constraints:
       "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
   Access method: heap
   ```
   SQL-запрос для выдачи списка пользователей (не знаю, как избавиться от ручного указания имени таблиц):
   ```sql
   SELECT table_name, array_agg(privilege_type), grantee
   FROM information_schema.table_privileges
   WHERE table_name = 'orders' OR table_name = 'clients'
   GROUP BY table_name, grantee ;
   ```
   Послученный список пользователей:
   ```sql
    table_name |                         array_agg                         |     grantee      
   ------------+-----------------------------------------------------------+------------------
    clients    | {INSERT,TRIGGER,REFERENCES,TRUNCATE,DELETE,UPDATE,SELECT} | postgres
    clients    | {INSERT,TRIGGER,REFERENCES,TRUNCATE,DELETE,UPDATE,SELECT} | test-admin-user
    clients    | {DELETE,INSERT,SELECT,UPDATE}                             | test-simple-user
    orders     | {INSERT,TRIGGER,REFERENCES,TRUNCATE,DELETE,UPDATE,SELECT} | postgres
    orders     | {INSERT,TRIGGER,REFERENCES,TRUNCATE,DELETE,UPDATE,SELECT} | test-admin-user
    orders     | {DELETE,SELECT,UPDATE,INSERT}                             | test-simple-user
   (6 rows)
   ```
3. Добавление данных в таблицы и вывод количества записей:
   ```sql
   test_db=# INSERT INTO orders (наименование, цена )
   VALUES 
       ('Шоколад', '10'),
       ('Принтер', '3000'),
       ('Книга', '500'),
       ('Монитор', '7000'),
       ('Гитара', '4000')
   ;
   INSERT 0 5
   test_db=# INSERT INTO clients ("фамилия", "страна проживания")
   VALUES 
       ('Иванов Иван Иванович', 'USA'),
       ('Петров Петр Петрович', 'Canada'),
       ('Иоганн Себастьян Бах', 'Japan'),
       ('Ронни Джеймс Дио', 'Russia'),
       ('Ritchie Blackmore', 'Russia')
   ;
   INSERT 0 5
   test_db=# SELECT 'orders' AS name_table,  COUNT(*) AS number_rows FROM orders
   UNION ALL
   SELECT 'clients' AS name_table,  COUNT(*) AS number_rows  FROM clients;
    name_table | number_rows 
   ------------+-------------
    orders     |           5
    clients    |           5
   (2 rows)
   ```
4. Связь данных:
   ```sql
   UPDATE clients SET "заказ"=3 WHERE id=1; 
   UPDATE clients SET "заказ"=4 WHERE id=2; 
   UPDATE clients SET "заказ"=5 WHERE id=3;
   ```
   Выдача всех пользователей, совершивших заказ:
   ```sql
   SELECT * FROM clients
   WHERE "заказ" IS NOT null;
    id |       фамилия        | страна проживания | заказ 
   ----+----------------------+-------------------+-------
     1 | Иванов Иван Иванович | USA               |     3
     2 | Петров Петр Петрович | Canada            |     4
     3 | Иоганн Себастьян Бах | Japan             |     5
   (3 rows)
   ```
5. Explain:
   ```sql
   test_db=# EXPLAIN SELECT * FROM clients
   WHERE "заказ" IS NOT null;
                           QUERY PLAN                         
   -----------------------------------------------------------
    Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
      Filter: ("заказ" IS NOT NULL)
   (2 rows)
   ```
   Последовательно читаем данные из таблицы `clients`, стоимость получения первого значения `0.00`, последнего - `18.10`. Количество строк - `806`, средний размер строки - `72`. Используется фильтр `"заказ" IS NOT NULL`.
6. Commands:
   ```bash
   ~/hmwrk-dev/06-db-01-basics/src  docker exec -it psql bash                                                                  
   root@6944a411eb41:/# pg_dump -U postgres -F t test_db > /data/backup/postgres/test_db.tar
   ~/hmwrk-dev/06-db-01-basics/src  docker-compose stop
   ~/hmwrk-dev/06-db-01-basics/src  docker-compose -f docker-compose_new.yml up -d
   ~/hmwrk-dev/06-db-01-basics/src  docker ps -a                                  
   CONTAINER ID   IMAGE         COMMAND                  CREATED              STATUS                     PORTS                    NAMES
   c27a41ba00fe   postgres:12   "docker-entrypoint.s…"   About a minute ago   Up About a minute          0.0.0.0:5433->5432/tcp   psql2
   6944a411eb41   postgres:12   "docker-entrypoint.s…"   9 minutes ago        Exited (0) 3 seconds ago                            psql
   ~/hmwrk-dev/06-db-01-basics/src  docker exec -it psql2 bash
   root@c27a41ba00fe:/# ls /data/backup/postgres/
   test_db.tar
   ---Дабы избежать ошибок перед рестором были восстановлены два пользователя---
   root@c27a41ba00fe:/# pg_restore -U postgres --verbose -C -d postgres /data/backup/postgres/test_db.tar
   <...>
   ```
   ```sql
   postgres=# \c test_db 
   You are now connected to database "test_db" as user "postgres".
   test_db=# \d orders
                                  Table "public.orders"
       Column    |  Type   | Collation | Nullable |              Default               
   --------------+---------+-----------+----------+------------------------------------
    id           | integer |           | not null | nextval('orders_id_seq'::regclass)
    наименование | text    |           |          | 
    цена         | integer |           |          | 
   Indexes:
       "orders_pkey" PRIMARY KEY, btree (id)
   Referenced by:
       TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)

   test_db=# \d clients
                                     Table "public.clients"
         Column       |  Type   | Collation | Nullable |               Default               
   -------------------+---------+-----------+----------+-------------------------------------
    id                | integer |           | not null | nextval('clients_id_seq'::regclass)
    фамилия           | text    |           |          | 
    страна проживания | text    |           |          | 
    заказ             | integer |           |          | 
   Indexes:
       "clients_pkey" PRIMARY KEY, btree (id)
       "clients_страна проживания_idx" btree ("страна проживания")
   Foreign-key constraints:
       "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)

   test_db=# SELECT * FROM clients
      WHERE "заказ" IS NOT null;
    id |       фамилия        | страна проживания | заказ 
   ----+----------------------+-------------------+-------
     1 | Иванов Иван Иванович | USA               |     3
     2 | Петров Петр Петрович | Canada            |     4
     3 | Иоганн Себастьян Бах | Japan             |     5
   (3 rows)
   ```