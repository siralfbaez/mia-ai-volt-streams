# Project Variables
ENV = dev
TF_DIR = terraform/environments/$(ENV)
MONITOR_DIR = services/ai-agentic-monitor
VENV = venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip

.PHONY: all init infrastructure monitor-dev clean

all: init infrastructure monitor-dev

# 1. Initialize Terraform and Python Environment
init:
	@echo "⚡ Initializing Terraform for $(ENV)..."
	cd $(TF_DIR) && terraform init
	@echo "🐍 Setting up Python Virtual Environment..."
	python3 -m venv $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r $(MONITOR_DIR)/requirements.txt

# 2. Deploy AWS and Databricks Infrastructure
infrastructure:
	@echo "🏗️ Deploying Data Diode (PrivateLink) and Databricks Workspace..."
	cd $(TF_DIR) && terraform apply -auto-approve

# 3. Launch the Agentic Monitor (Fahrenheit Logic)
monitor-dev:
	@echo "🔍 Launching mia-ai-volt Agentic Monitor [Units: °F]..."
	export PYTHONPATH=$${PYTHONPATH}:$(shell pwd) && \
	$(PYTHON) $(MONITOR_DIR)/monitor.py

# 4. Cleanup Environment
clean:
	@echo "🧹 Cleaning up..."
	rm -rf $(VENV)
	find . -type d -name "__pycache__" -exec rm -rf {} +

# 5. Inject Mock Data for Demo
mock-failure:
	@echo "🧪 Injecting 180°F Winter Failure Event..."
	$(PYTHON) services/transformation-worker/mock_telemetry.py

# 6. Run Thermal Logic Tests
test:
	@echo "🧪 Running Fahrenheit Logic Validation..."
	$(PYTHON) -m pytest tests/test_thermal_logic.py -v
