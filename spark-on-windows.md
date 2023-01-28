# Spark 

In this readme, I'll try to figure out how to run Spark locally, to play a bit with it. 

## Running on Docker 

Spark depends on the JVM, spark, and setting some environment vars. However, a faster way to play around is to use a Docker image provides by the Jupyter community. 

```powershell 
docker volume create spark-vol  # Only if not existent
docker run -it --rm `
    --name spark-jupyter `
    -p 8888:8888 `  
    -p 4040:4040 `  
    --mount "type=volume,src=spark-vol,dst=/home/jovyan/work" `
    jupyter/pyspark-notebook
```

## Manual installation 

Manual installation is a bit more elaborate. 

1. Install JDK 8, from the Oracle archive; for some reason, 8 is the business...
    - Download and run the installer
    - Change the install directory to something without weird characters; spark doesn't like it (e.g. `C:\java\jdk1.8.0_351`)
2. Install Spark 
    - Download Spark for Hadoop 2.7 from Spark website; for some reason Hadoop 2.7 is the bees knees. 
    - Extract `tar -xvf spark-3.3.1-bin-hadoop2.tar.gz`
    - Copy to nice location (e.g. `C:\Program Files\spark-3.3.1-bin-hadoop2`)
3. Download winutils for Hadoop 2.7, and copy to `C:\Program Files\spark-3.3.1-bin-hadoop2\bin`
4. Set environment variables
    - `JAVA_HOME=C:\java\jdk1.8.0_351`
    - `JAVA_PATH=C:\java\jdk1.8.0_351\bin`
    - `SPARK_HOME=C:\Program Files\spark-3.3.1-bin-hadoop2`
    - `HADOOP_HOME=C:\Program Files\spark-3.3.1-bin-hadoop2`
5. Add the following to user scoped path variable: 
    - `%SPARK_HOME%\bin`
    - `JAVA_PATH`
