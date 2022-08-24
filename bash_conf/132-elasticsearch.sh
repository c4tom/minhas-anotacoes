
[[ `isWin` == "1" ]] || { return ; }

# https://www.elastic.co/guide/en/elasticsearch/reference/master/docker.html

ct_elasticsearch_apply_VM_MAX_MAP_COUNT() {
   sysctl -w vm.max_map_count=262144
}
