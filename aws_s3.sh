#!/bin/bash
DB_HOST=$1
DB_PASSWD=$2
DB_TABLE=$3
AWS_SECRET=$4
BUCKET_NAME=$5
DATE=$(date +%H-%M-%S)
echo "Dumping database"
mysqldump -u root -h $DB_HOST -p$DB_PASSWD $DB_TABLE > /tmp/db-$DATE.sql
export AWS_ACCESS_KEY_ID=AKIAR2HFXNK57VVTCN6Q
#Secret key passed as variable
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET
echo "Database Dump complete"
echo "Uploading DB Backup"
aws s3 cp /tmp/db-$DATE.sql s3://$BUCKET_NAME/db-$DATE.sql
echo "Upload complete"
