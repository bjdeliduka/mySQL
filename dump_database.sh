#!/bin/bash

# check for parameters
if [ $# -lt 1 ]; then
   echo
    echo "proper calling sequence: $0 database_name"
    exit 1
fi
echo
echo

PWD=`pwd`

for TABLE_NAME in `mysql -u root --batch -N -e 'use '"$1"'; show tables'`; do
  OUT_FILENAME="$1"."$TABLE_NAME".csv

  echo -n 'Dumping "'"$TABLE_NAME"'" to "'"$OUT_FILENAME"'" .....'

  # extract column names
  mysql -u root "$1" -e 'select group_CONCAT(COLUMN_NAME) from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = "'"$TABLE_NAME"'" AND TABLE_SCHEMA = "'"$1"'" order BY ORDINAL_POSITION;' > "$OUT_FILENAME"

  # strip header line and convert , to tab
  sed -i 1d "$OUT_FILENAME"
  sed -i 's/,/\t/g' "$OUT_FILENAME"

  rm -f "$1"."$TABLE_NAME".tmp

  mysql -u root "$1" -e 'select * from '"$TABLE_NAME"' into outfile "'"$PWD"/"$1"."$TABLE_NAME"'.tmp" '

  cat "$1"."$TABLE_NAME".tmp >> "$OUT_FILENAME"

  rm -f "$1"."$TABLE_NAME".tmp
  echo 'Done.'
done
