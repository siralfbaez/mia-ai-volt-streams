import os
import json
import logging
from langchain.prompts import PromptTemplate
from langchain_community.chat_models import ChatOpenAI # Swap for BedrockChat if using AWS

# Setup logging for Agentic Observability
logger = logging.getLogger("mia-ai-volt.handler")

class AnomalyHandler:
    def __init__(self, prompt_path):
        self.prompt_template = self._load_prompt(prompt_path)
        self.llm = ChatOpenAI(model="gpt-4-turbo", temperature=0) # Deterministic for grid safety

    def _load_prompt(self, path):
        if not os.path.exists(path):
            raise FileNotFoundError(f"Prompt file missing at {path}")
        with open(path, "r") as f:
            return f.read()

    def analyze_telemetry(self, gold_data_json):
        """
        Executes the Winter Anomaly Detection logic using Fahrenheit thresholds.
        """
        prompt = PromptTemplate.from_template(self.self.prompt_template)
        formatted_query = prompt.format(gold_layer_telemetry_json=gold_data_json)

        try:
            response = self.llm.predict(formatted_query)
            return json.loads(response)
        except Exception as e:
            logger.error(f"Agent analysis failed: {e}")
            return {"status": "ERROR", "reasoning": str(e)}
