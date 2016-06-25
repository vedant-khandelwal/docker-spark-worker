
FROM docker.io/falkonry/spark-base:1.6.0

RUN apt-get update && apt-get install -y wget

apt-get install libgfortran3
RUN apt-get install -y gfortran && apt-get install -y libopenblas-base libatlas3-base

# Spark Worker Port
EXPOSE 7078

# Spark Worker Web UI Port
EXPOSE 8081

# Configuration
#ENV SPARK_MASTER_URL
#ENV SPARK_WORKER_CORES
#ENV SPARK_WORKER_MEMORY
#ENV SPARK_WORKER_DIR


RUN cd "$SPARK_HOME"/lib/ && \
    mv spark-assembly-1.6.0-hadoop2.6.0.jar spark-assembly-1.6.0-hadoop2.6.0.jar_old && \
    wget https://storage.googleapis.com/spark-resources/spark-assembly-1.6.0-hadoop2.6.0.jar 

ENTRYPOINT exec "$SPARK_HOME"/bin/spark-class org.apache.spark.deploy.worker.Worker \
  --port 7078 --webui-port 8081 "$SPARK_MASTER_URL"

