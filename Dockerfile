
FROM docker.io/falkonry/spark-base:hive.latest

# Spark Worker Port
EXPOSE 7078

# Spark Worker Web UI Port
EXPOSE 8081

# Configuration
#ENV SPARK_MASTER_URL
#ENV SPARK_WORKER_CORES
#ENV SPARK_WORKER_MEMORY
#ENV SPARK_WORKER_DIR

ENTRYPOINT exec "$SPARK_HOME"/bin/spark-class org.apache.spark.deploy.worker.Worker \
  --port 7078 --webui-port 8081 "$SPARK_MASTER_URL"

