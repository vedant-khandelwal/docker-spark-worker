
FROM docker.io/falkonry/spark-base:1.6.0

RUN apt-get update && apt-get install -y wget

# Spark Worker Port
EXPOSE 7078

# Spark Worker Web UI Port
EXPOSE 8081

# Configuration
#ENV SPARK_MASTER_URL
#ENV SPARK_WORKER_CORES
#ENV SPARK_WORKER_MEMORY
#ENV SPARK_WORKER_DIR

RUN mkdir "$SPARK_HOME"/src

ADD ./lib/* "$SPARK_HOME"/src/

RUN cd "$SPARK_HOME"/src/ && \
    tar cvzf spark-assembly-1.6.0-hadoop2.6.0.jar * && \
    mv "$SPARK_HOME"/src/spark-assembly-1.6.0-hadoop2.6.0.jar "$SPARK_HOME"/lib/spark-assembly-1.6.0-hadoop2.6.0.jar

ENTRYPOINT exec "$SPARK_HOME"/bin/spark-class org.apache.spark.deploy.worker.Worker \
  --port 7078 --webui-port 8081 "$SPARK_MASTER_URL"

