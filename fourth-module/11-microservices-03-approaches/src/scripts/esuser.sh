#!/bin/bash

sleep 10

curl -X POST -u elastic:$ELASTIC_PASSWORD "es:9200/_security/user/${my_el_usr}?pretty" -H 'Content-Type: application/json' -d'
{
  "password" : "'${ELASTIC_PASSWORD}'",
  "roles" : [ "superuser" ],
  "enabled" : true
}
'

curl -X PUT --silent --output $(mktemp) -u ${my_el_usr}:$ELASTIC_PASSWORD "es:9200/_security/user/kibana_system/_password?pretty" -H 'Content-Type: application/json' -d'
{
  "password" : "'${ELASTIC_PASSWORD}'"
}
'