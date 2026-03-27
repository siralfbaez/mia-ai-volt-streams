# ⚡ Demo Script: mia-ai-volt-streams Agentic Observability
**Audience:** Stakeholders, Grid Operations, and Security Teams

**Goal:** Demonstrate a secure, context-aware "Nervous System" for transformer health.

## 1. The Hook: The Problem with "Dumb" Alerts
*   **Narrative:** "Traditional SCADA systems are static. They alert at 180°F regardless of the environment. In July, 180°F is a heavy load; in January, it’s a transformer on the verge of explosion. We’re moving from 'Static Thresholds' to 'Agentic Intelligence'."

* **Action:** Show the **README.md** and the "The Narrative" blockquote.

## 2. The Security Layer: The "Data Diode"
* **Narrative:** "Security in utilities isn't optional. We’ve implemented a Data Diode pattern using AWS PrivateLink. Our telemetry flows from the OT DMZ to the Cloud, but the Cloud has zero inbound access back to the grid. This is NERC CIP compliance by design."

* **Action:** Point to the `terraform/modules/aws-privatelink` code or the Mermaid diagram in the README.

## 3. The Engine: Databricks & Delta Live Tables
* **Narrative:** "We aren't just moving data; we're evolving it. Our Bronze layer is the immutable audit trail. Our Silver layer handles protocol translation and 10-minute watermarking. By the time data hits Gold, it's a Digital Twin ready for AI analysis."

* **Action:** Briefly show `services/transformation-worker/internal/medallion/silver_transform.py.`

## 4. The Live "Failure" Event (The Climax)
* **Narrative:** "Let's simulate a real-world crisis. It’s a freezing winter night—32°F ambient. A transformer starts failing internally, pushing temperatures to 180°F while the load remains low."


* **Action: 1.**  Run `make monitor-dev` in Terminal 1.
* **Action: 2.**  Run `make mock-failure` in Terminal 2.

* **Observation:** Highlight the Agentic Monitor’s output. Point out how it identified the Winter Anomaly specifically because of the temperature/ambient/season correlation.

## 5. The Conclusion: Scalable Intelligence

* **Narrative:** "This isn't just an alert; it's a root-cause analysis. The system tells the operator why it's failing and what to do next. We’ve built a system that understands the grid's context."

* **Action:** Show the `services/ai-agentic-monitor/prompts/winter_anomaly_detection.md` to demonstrate how easy it is to update the "Brain's" logic.

## Final Technical Summary
Language: Python 3 / PySpark

Infrastructure: Terraform (AWS + Databricks)

Units: Imperial (°F)

Security: Unidirectional PrivateLink