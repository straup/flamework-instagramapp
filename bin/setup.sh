#!/bin/sh

WHOAMI=`readlink -f $0`
WHEREAMI=`dirname $WHOAMI`
INSTAGRAM_APP=`dirname $WHEREAMI`

PROJECT=$1

echo "copying application files to ${PROJECT}"
cp ${INSTAGRAM_APP}/www/*.php ${PROJECT}/www/

# echo "copying templates to ${PROJECT}"
cp ${INSTAGRAM_APP}/www/templates/*.txt ${PROJECT}/www/templates/

echo "copying library code to ${PROJECT}"
cp ${INSTAGRAM_APP}/www/include/*.php ${PROJECT}/www/include/

echo "copying database schemas to ${PROJECT}; you will still need to run database alters manually"

YMD=`date "+%Y%m%d"`
mkdir ${PROJECT}/schema/alters

cat ${INSTAGRAM_APP}/schema/db_main.schema >> ${PROJECT}/schema/db_main.schema
cat ${INSTAGRAM_APP}/schema/db_main.schema >> ${PROJECT}/schema/alters/${YMD}.db_main.schema

echo "setup (mostly) complete"
echo "you will still need to update your config file(s) manually"
echo ""

# TO DO: generate oauth cookie secret

echo "Things you'll need to add to your config.php file:"
echo ""

cat ${INSTAGRAM_APP}/www/include/config.php.example

echo "--------------------------------------------"
echo ""

# TO DO: .htaccess configs

echo "Things you'll need to add to your .htaccess file:"
echo ""

cat ${INSTAGRAM_APP}/www/.htaccess

echo "--------------------------------------------"
echo ""
