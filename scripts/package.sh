
#!/bin/bash

BASE_DIR=`dirname $0`
ROOT_DIR=$BASE_DIR/..

mkdir -p $ROOT_DIR/target
rm -rf $ROOT_DIR/target/banyan_config.zip

cd $ROOT_DIR && zip -r target/banyan_config.zip openmrs/* migrations/* openelis/*
