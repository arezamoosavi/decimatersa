#!/bin/sh


set -o errexit
set -o nounset


echo "wait"


start-history-server.sh
echo "History server is sarting ...."
sleep 2
echo "Master is sarting ...."
start-master.sh

sleep 1
echo "Master started at port 8080 ...."

echo "worker is sarting ...."

start-slave.sh spark://spark:7077

sleep 1
echo "worker started at port 8081 ...."


start-cluster.sh
taskmanager.sh start
jobmanager.sh start

sleep 1
echo "flink started at port 3030 ...."

# ./flink/build-target/bin/pyflink3.sh ~./flink-examples/word_count.py

sleep 100000