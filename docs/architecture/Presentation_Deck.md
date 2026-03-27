## Slide 1: Title & Vision
* **Headline:** `mia-ai-volt-streams:` The Agentic Nervous System

* **Sub-headline:** Bridging the OT/IT Gap with Contextual Grid Intelligence

* **Visual:**

## Slide 2: The Security Perimeter (NERC CIP)

* **Key Points:**

    * Unidirectional Data Flow via AWS PrivateLink.
    * Elimination of Public Internet Exposure for SCADA telemetry.
    * "Data Diode" pattern protecting the Industrial DMZ.

* **Visual:**

## Slide 3: Data Evolution (The Medallion Model)
* **Key Points:**

    * Bronze: Raw, immutable audit pings. 
    * Silver: 10-minute watermarking & Fahrenheit normalization. 
    * Gold: Digital Twins (Assets + Topology).

* **Visual:**

## Slide 4: Agentic vs. Static Monitoring

#### SCADA vs. mia-ai-volt (Agentic)
| Feature | Traditional SCADA | mia-ai-volt (Agentic) |
| :--- | :--- | :--- |
| **Thresholds** | Static (e.g., 180°F) | Contextual (Seasonal/Temporal) |
| **Reasoning** | None | Chain-of-Thought (LLM) |
| **Action** | Alarm Only | Root Cause + Suggested Action |
---

## Slide 5: Live Demo - The Winter Anomaly
* **The Scenario:** Freezing night (32°F) + Low Load + High Temperature (180°F).

* **The Logic:** "If ambient is cold but internal heat is rising, it's a cooling or mechanical failure, not a heavy load."

Visual: