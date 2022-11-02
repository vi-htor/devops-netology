# Tasks

1. [Dockerfile](src/Dockerfile)
   (ох и намучался я с эластиком и их баном, но вроде сбилдилось всё)
   [Config file](src/elasticsearch.yml)
   [Link to docker hub](https://hub.docker.com/repository/docker/vihtor/06-db-05-elasticsearch)
   Curl output:
   ```bash
   $curl --insecure -u elastic https://localhost:9200                        
   Enter host password for user 'elastic':
   {
     "name" : "netology_test",
     "cluster_name" : "elasticsearch",
     "cluster_uuid" : "xMaBJgGfRnK4iXT7kh9x_g",
     "version" : {
       "number" : "8.5.0",
       "build_flavor" : "default",
       "build_type" : "tar",
       "build_hash" : "c94b4700cda13820dad5aa74fae6db185ca5c304",
       "build_date" : "2022-10-24T16:54:16.433628434Z",
       "build_snapshot" : false,
       "lucene_version" : "9.4.1",
       "minimum_wire_compatibility_version" : "7.17.0",
       "minimum_index_compatibility_version" : "7.0.0"
     },
     "tagline" : "You Know, for Search"
   }
   ```
2. Add indexes:
   ```bash
   curl -X PUT --insecure -u elastic "https://localhost:9200/ind-1" -H 'Content-Type: application/json' -d'       
   {
     "settings": {
       "number_of_shards": 1,
       "number_of_replicas": 0
     }
   }
   '
   curl -X PUT --insecure -u elastic "https://localhost:9200/ind-2" -H 'Content-Type: application/json' -d'       
   {
     "settings": {
       "number_of_shards": 2,
       "number_of_replicas": 1
     }
   }
   '
   curl -X PUT --insecure -u elastic "https://localhost:9200/ind-3" -H 'Content-Type: application/json' -d'       
   {
     "settings": {
       "number_of_shards": 4,
       "number_of_replicas": 2
     }
   }
   '
   ```
   List of indexes:
   ```bash
   curl -X GET --insecure -u elastic "https://localhost:9200/_cat/indices?v=true"                                 
   Enter host password for user 'elastic':
   health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
   green  open   ind-1 NH1DZ1ieSMuZWeG9wqnZgQ   1   0          0            0       225b           225b
   yellow open   ind-3 KNlx7u2BR5-8Yw2MeOJ_rQ   4   2          0            0       900b           900b
   yellow open   ind-2 JU-1JqaJQfub_RAcZIt9LQ   2   1          0            0       450b           450b
   ```
   Cluster status:
   ```bash
   curl -X GET --insecure -u elastic "https://localhost:9200/_cluster/health?pretty"                      
   Enter host password for user 'elastic':
   {
     "cluster_name" : "elasticsearch",
     "status" : "yellow",
     "timed_out" : false,
     "number_of_nodes" : 1,
     "number_of_data_nodes" : 1,
     "active_primary_shards" : 9,
     "active_shards" : 9,
     "relocating_shards" : 0,
     "initializing_shards" : 0,
     "unassigned_shards" : 10,
     "delayed_unassigned_shards" : 0,
     "number_of_pending_tasks" : 0,
     "number_of_in_flight_fetch" : 0,
     "task_max_waiting_in_queue_millis" : 0,
     "active_shards_percent_as_number" : 47.368421052631575
   }
   ```
   Индексы и кластер имеют `state: yellow` так как количество реплик больше 1-ой, а в кластере всего одна нода, поэтому репликация не возможна.  
   Удаление индексов:
   ```bash
   curl -X DELETE --insecure -u elastic "https://localhost:9200/ind-1"
   curl -X DELETE --insecure -u elastic "https://localhost:9200/ind-2"
   curl -X DELETE --insecure -u elastic "https://localhost:9200/ind-3"
   ```
3. Register a snapshot repo:
   ```bash
   curl -X PUT --insecure -u elastic:$ESPASS "https://localhost:9200/_snapshot/netology_backup?verify=false" -H 'Content-Type: application/json' -d'{
     "type": "fs",
     "settings": {
       "location": "/opt/elasticsearch-8.5.0/snapshots"
     }
   }
   '
   {"acknowledged":true}          
   curl -X POST --insecure -u elastic:$ESPASS "https://localhost:9200/_snapshot/netology_backup/_verify"                                     
   {"nodes":{"rZQM4dUHQRyIWq9MZ7sF-A":{"name":"netology_test"}}}%  
   ```
   Create index `test` and show it:
   ```bash
   curl -X GET --insecure -u elastic:$ESPASS "https://localhost:9200/_cat/indices?v=true"
   health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
   green  open   test  tdlfBocjQa6kViOqipB6iA   1   0          0            0       225b           225b
   ```
   Create and check snapshot:
   ```bash
   curl -X PUT --insecure -u elastic:$ESPASS "https://localhost:9200/_snapshot/netology_backup/test_snapshot" 
   #Check snapshot status
   curl -X GET --insecure -u elastic:$ESPASS "https://localhost:9200/_snapshot/netology_backup/test_snapshot/_status?pretty"
   #List os files on snapshots dir
   bash-4.2$ ls snapshots/
   index-0  index.latest  indices  meta-L2G2h9zLRGGt7fuF-DdCFg.dat  snap-L2G2h9zLRGGt7fuF-DdCFg.dat
   ```
   Delete `test` and create `test-2`:
   ```bash
   curl -X GET --insecure -u elastic:$ESPASS "https://localhost:9200/_cat/indices?v=true"
   health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
   green  open   test-2 qNmSAIrHQFecAm22mxduxw   1   0          0            0       225b           225b
   ```
   Restore snapshot and show list of indexes:
   ```bash
   curl -X POST --insecure -u elastic:$ESPASS "https://localhost:9200/_snapshot/netology_backup/test_snapshot/_restore?pretty"
   {
     "accepted" : true
   }
   curl -X GET --insecure -u elastic:$ESPASS "https://localhost:9200/_cat/indices?v=true"                                     
   health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
   green  open   test-2 qNmSAIrHQFecAm22mxduxw   1   0          0            0       225b           225b
   green  open   test   ZLHJPFF8QPSFcGjBRjoqOA   1   0          0            0       225b           225b
   ```