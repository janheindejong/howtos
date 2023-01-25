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
