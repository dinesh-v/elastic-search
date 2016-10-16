#!/usr/bin/env bash
# Is Elastic search running? 9200 is where elastic search is configured to run by default
curl localhost:9200

# https://www.elastic.co/guide/en/elasticsearch/reference/current/_cluster_health.html#_cluster_health
curl 'localhost:9200/_cat/health?v'
# List of nodes in our cluster
curl 'localhost:9200/_cat/nodes?v'

# https://www.elastic.co/guide/en/elasticsearch/reference/current/_list_all_indices.html#_list_all_indices
curl 'localhost:9200/_cat/indices?v'

# https://www.elastic.co/guide/en/elasticsearch/reference/current/_create_an_index.html#_create_an_index
# Here the index name is called customer. ?pretty is ignorable. Just displayes the output in human readable format
curl -XPUT 'localhost:9200/customer?pretty'


curl -XPUT 'localhost:9200/customer/external/1?pretty' -d '
{
  "name": "John Doe"
}'

# Delete an index - Here customer is the index being deleted
curl -XDELETE localhost:9200/medical_insurance
curl 'localhost:9200/_cat/indices?v'

curl -XPUT 'localhost:9200/twitter/tweets/<id>?pretty' -d '
{
  "tweet_id": "John Doe",
  "user_name": "Dinesh V",
  "tweet_text": "Whatever user tweeted",
  "created_at": "20161007"
}'

curl localhost:9200/twitter/tweets/1?pretty

# Get n records from index (medical_insurance)
curl 127.0.0.1:9200/medical_insurance/_search/?size=10&pretty=1


curl -XPUT 'http://127.0.0.1:9200/medical_insurance/ipps_summary/1?pretty' -d '
{
    "tweet_id": "John Doe",
    "user_name": "Dinesh V",
    "tweet_text": "Whatever user tweeted",
    "created_at": "20161007"
}'