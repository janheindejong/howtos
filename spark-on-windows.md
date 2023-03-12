# Spark 

In this readme, I'll try to figure out how to run Spark locally, to play a bit with it. 

## Project installation

This is the simplest way; it allows you to run Spark programs locally, either through `spark-submit` or through an interactive shell (e.g. `pyspark` or `IPython`).

1. Install supported Java Developer Kit (8/11/17) from Oracle downloads page
    - Download installer from Oracle website, and run.
    - Either add `JAVA_HOME=C:\Program Files\Java\jdk-17` to environment variables, or ensure Java is added to `PATH`. 
2. Create new environment: 
    - Create new env based off supported Python version `py -3.10 venv .venv`.
    - Activate the environment `.venv\Scripts\activate`.
3. Install and configure PySpark: 
    - `pip install pyspark`; this install PySpark and a basic version of Spark
    - By default, PySpark goes looking for the command `python3`, which isn't automatically created on Windows... very annoying. So, we can either set to `$env:PYSPARK_PYTHON = "python"`, or create a simlink ` New-Item -ItemType SymbolicLink -Path .\.venv\Scripts\python3.exe -Target .\.venv\Scripts\python.exe`.
4. See if everything works, by running PySpark in interactive mode:
    - `pyspark`
    - `spark.range(1, 100).collect()`

Now, you have a basic version of Spark, that you can use for local development, and for communicating with a cluster. Love it...

## System-wide installation 

Manual installation is a bit more elaborate, but allows for more control and functionality. 

1. Install supported Java Developer Kit (8/11/17) from Oracle downloads page
    - Download installer from Oracle website, and run 
    - Add `JAVA_HOME=C:\Program Files\Java\jdk-17` to environment variables  
2. Install Spark 
    - Download Spark for Hadoop 2.7 from Spark website; for some reason Hadoop 2.7 is the bees knees. 
    - Extract `tar -xvf spark-3.3.1-bin-hadoop2.tar.gz`
    - Copy to nice location (e.g. `C:\Program Files\Spark\spark-3.3.1-bin-hadoop2`)
    - Add `SPARK_HOME=C:\Program Files\Spark\spark-3.3.1-bin-hadoop2` to environment variables
3. Setup Hadooop
    - Download winutils for Hadoop 2.7, and copy to `%SPARK_HOME%\bin`
    - Add `HADOOP_HOME=%SPARK_HOME%` to environment variables 
4. See if everything works, by running PySpark in interactive mode:
    - `%SPARK_HOME%\bin\pyspark`
    - `spark.range(1, 100).collect()`

You can now create a new virtual environment, and install PySpark there. It will be used for code inspection by your IDE, but due to the environment variables we've set, the configuration and JARs from your global installation will be used. 

To configure Spark, create a file `%SPARK_HOME\conf\spark-defaults.conf` and add the following: 

```
spark.eventLog.enabled          true
spark.history.fs.logDirectory   file:///c:/tmp/spark-events
spark.eventLog.dir              file:///c:/tmp/spark-events
spark.sql.shuffle.partitions    8
```

Create the spark events folder: `mkdir C:\tmp\spark-events`.

You can now run Spark history server: 

```powershell 
& '$env:SPARK_HOME\bin\spark-class.cmd' org.apache.spark.deploy.history.HistoryServer  # Serves Spark logs at localhost:18080
```

## In Docker container 

The Jupyter community provides a convenience container that has all batteries included. 

```powershell 
docker volume create spark-vol  # Only if not existent
docker run -it --rm `
    --name spark-jupyter `
    -p 8888:8888 `  
    -p 4040:4040 `  
    --mount "type=volume,src=spark-vol,dst=/home/jovyan/work" `
    jupyter/pyspark-notebook
```


## Devcontainer

I've noticed that Spark on Windows is not really a match made in heaven. I think devcontainers could be solution, where we should: 

1. Start with the Python devcontainer 
2. Add Java 
3. Add Spark 

This might be nice... don't know. 
