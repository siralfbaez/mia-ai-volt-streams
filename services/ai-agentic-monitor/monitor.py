import time
from pyspark.sql import SparkSession
from internal.handler import AnomalyHandler

def run_monitor():
    spark = SparkSession.builder.appName("MiaAI-Volt-Monitor").getOrCreate()

    # Path to your localized prompt
    PROMPT_PATH = "services/ai-agentic-monitor/prompts/winter_anomaly_detection.md"
    handler = AnomalyHandler(PROMPT_PATH)

    print("⚡ mia-ai-volt-streams: Agentic Monitor Active [Units: °F] ⚡")

    while True:
        # 1. Query the Gold Layer for the latest asset state
        # In a real PoC, we'd look for rows where temp > 165°F to reduce LLM costs
        latest_telemetry = spark.sql("""
            SELECT * FROM gold_asset_digital_twins
            WHERE last_updated >= current_timestamp() - INTERVAL 5 MINUTES
            AND temperature_f > 165
        """).toPandas()

        if not latest_telemetry.empty:
            for _, row in latest_telemetry.iterrows():
                asset_id = row['asset_id']
                print(f"🔍 Analyzing potential anomaly for Asset: {asset_id}")

                # 2. Run Agentic Analysis
                result = handler.analyze_telemetry(row.to_json())

                # 3. Handle Critical Findings
                if result.get("status") == "CRITICAL":
                    print(f"🚨 ALERT: {result['reasoning']}")
                    # Here you would trigger an SNS alert or AWS Lambda

        # Sleep to respect grid telemetry polling intervals
        time.sleep(60)

if __name__ == "__main__":
    run_monitor()
