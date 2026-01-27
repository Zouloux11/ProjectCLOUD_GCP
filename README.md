# ProjectCLOUD_GCP

## Lancer le cluster

Tout est déja lancé de base par ansible mais si on veut le relancer :

Sur master:

```bash
ssh hadoop@
/opt/hadoop-3.3.6/sbin/start-dfs.sh
/opt/spark-3.5.0-bin-hadoop3/sbin/start-all.sh
jps  # vérification
```

## Uploader des fichiers

Sur edge:

```bash
ssh caploic_outlook_fr@
hdfs dfs -mkdir -p /input
hdfs dfs -put test_10mb.txt /input/
hdfs dfs -ls /input/
```

## Lancer un job

```bash
cd /opt/spark-app/spark-app

spark-submit \
    --master spark://10.0.0.4:7077 \
    --total-executor-cores 2 \
    --executor-memory 2G \
    --class WordCount \
    wc.jar \
    hdfs://10.0.0.4:9000/input/test_10mb.txt \
    hdfs://10.0.0.4:9000/output/result
```

- `--total-executor-cores` : 2 pour 1 worker, 4 pour 2 workers, 6 pour 3 workers
- `--executor-memory` : RAM par executor (2G par défaut)

## Voir les résultats

```bash
hdfs dfs -ls /output/result/
hdfs dfs -cat /output/result/part-* | head -20
```

Supprimer avant de relancer:

```bash
hdfs dfs -rm -r /output/result
```

## UIs

- Spark Master: http://<master-external-ip>:8080
- HDFS NameNode: http://<master-external-ip>:9870

## Arrêter le cluster

```bash
ssh hadoop@
/opt/spark-3.5.0-bin-hadoop3/sbin/stop-all.sh
/opt/hadoop-3.3.6/sbin/stop-dfs.sh
```
