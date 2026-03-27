# Quick snippet for your silver_transform.py
import dlt
from pyspark.sql.functions import col, from_json
import json

# Reference the versioned schema from your config tree
SCHEMA_PATH = "/conf/config/schemas/scada-tags/v1_schema.json"

@dlt.table(comment="Curated SCADA telemetry with 10m Watermarking")
def silver_grid_telemetry():
    return (
        dlt.read_stream("bronze_scada_raw")
        .withWatermark("event_timestamp", "10 minutes")
        .select(from_json(col("payload"), scada_v1_schema).alias("data"))
        .select("data.*")
    )
