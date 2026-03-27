import json
import time
from pyspark.sql import SparkSession
from datetime import datetime

def inject_failure_event():
    spark = SparkSession.builder.appName("MiaAI-Volt-Mocker").getOrCreate()

    # 1. Define the "Critical Failure" Payload (Winter Night @ 180°F)
    # This matches config/schemas/scada-tags/v1_schema.json
    failure_payload = {
        "asset_id": "TRANSFORMER_SUB_042",
        "tag_name": "TOP_OIL_TEMP",
        "value": 180.5,             # Critical Anomaly for Winter
        "unit": "F",
        "event_timestamp": datetime.now().isoformat(),
        "quality": "GOOD",
        "metadata": {
            "ambient_temp_f": 32.0, # Freezing outside
            "load_amps": 45.0       # Low load, high heat = Internal Failure
        }
    }

    # 2. Convert to Spark DataFrame
    df = spark.createDataFrame([failure_payload])

    # 3. Write to the Bronze Layer (Mocking the MSK Ingestion)
    print("⚡ Injecting 180.5°F Winter Anomaly into Bronze Layer...")
    df.write.format("delta").mode("append").saveAsTable("bronze_scada_raw")

    print("✅ Injection Complete. Check your Agentic Monitor logs.")

if __name__ == "__main__":
    inject_failure_event()
