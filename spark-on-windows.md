# Spark 

In this readme, I'll try to figure out how to run Spark locally, to play a bit with it. 

## Simplest installation for running locally with PySpark 

1. Install a supported Java version, i.e. 8/11/17
2. Add an environment variable JAVA_HOME and point it to the installation directory of Java, or add that directory to PATH. This allows Spark to find Java, and create and communicate with JVMs  
3. Create a new virtual environment based of one of the supported Python versions: `py -3.10 venv .venv`
4. Activate the environment `.venv\Scripts\activate`
5. Install PySpark: `pip install pyspark`
6. By default, PySpark goes looking for the command `python3`, which isn't automatically created on Windows... very annoying. So, we can either set do `$env:PYSPARK_PYTHON = "python"`, or create a simlink ` New-Item -ItemType SymbolicLink -Path .\.venv\Scripts\python3.exe -Target .\.venv\Scripts\python.exe`
7. See if everything works, by running PySpark in interactive mode:
  - `pyspark`
  - `spark.range(1, 100).collect()`

Now, you have a fully working version of Spark, that you can use for local development, and for communicating with a cluster. Love it...

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
