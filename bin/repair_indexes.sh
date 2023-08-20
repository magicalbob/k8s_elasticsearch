# Disable Shard Allocation
curl -X PUT "http://dev.ellisbs.co.uk:9200/_cluster/settings" -H "Content-Type: application/json" -d '{
  "transient": {
    "cluster.routing.allocation.enable": "primaries"
  }
}'

# Delete Replicas
curl http://dev.ellisbs.co.uk:9200/_cat/indices | awk '{print $3}' | while read index_name; do   curl -X PUT "http://dev.ellisbs.co.uk:9200/$index_name/_settings" -H "Content-Type: application/json" -d '{
    "settings": {
      "number_of_replicas": 0
    }
  }'; done

# Enable Shard Allocation
curl -X PUT "http://dev.ellisbs.co.uk:9200/_cluster/settings" -H "Content-Type: application/json" -d '{
  "transient": {
    "cluster.routing.allocation.enable": "all"
  }
}'
