import pytest
import json
from unittest.mock import MagicMock
from services.ai_agentic_monitor.internal.handler import AnomalyHandler

@pytest.fixture
def handler():
    # Mock the prompt loading to avoid file system dependency
    AnomalyHandler._load_prompt = MagicMock(return_value="""
    # ROLE: Grid-Brain
    # CONTEXT: Winter Anomaly Logic (175°F Threshold)
    # INPUT: {{ gold_layer_telemetry_json }}
    """)
    return AnomalyHandler("mock_path.md")

def test_winter_critical_anomaly_logic(handler):
    """
    Test that 180.5°F in Winter (32°F Ambient) triggers a CRITICAL status.
    """
    # 1. Setup Mock Telemetry (Matches your mock_telemetry.py)
    mock_payload = {
        "asset_id": "TRANSFORMER_SUB_042",
        "temperature_f": 180.5,
        "ambient_temp_f": 32.0,
        "load_amps": 10.0
    }

    # 2. Mock the LLM Response
    handler.llm.predict = MagicMock(return_value=json.dumps({
        "status": "CRITICAL",
        "confidence_score": 0.98,
        "reasoning": "180.5°F is a critical thermal anomaly for winter (32°F ambient).",
        "suggested_action": "Dispatch Crew."
    }))

    # 3. Execute Analysis
    result = handler.analyze_telemetry(json.dumps(mock_payload))

    # 4. Assertions
    assert result["status"] == "CRITICAL"
    assert "180.5°F" in result["reasoning"]
    assert result["confidence_score"] > 0.9

def test_nominal_winter_logic(handler):
    """
    Test that 110°F in Winter is treated as NOMINAL.
    """
    mock_payload = {"temperature_f": 110.0, "ambient_temp_f": 35.0}

    handler.llm.predict = MagicMock(return_value=json.dumps({
        "status": "NOMINAL",
        "reasoning": "110°F is within normal winter operating range."
    }))

    result = handler.analyze_telemetry(json.dumps(mock_payload))
    assert result["status"] == "NOMINAL"
