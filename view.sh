#!/bin/sh
project_id=$1
sql_file=$2
echo "$sql_file"
query="$(cat $sql_file)"
echo "${query//root-micron-336614/$project_id}"
bq query --batch --use_legacy_sql=false "${query//root-micron-336614/$project_id}"