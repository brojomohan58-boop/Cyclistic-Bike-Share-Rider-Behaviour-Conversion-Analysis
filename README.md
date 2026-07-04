# 🚴 Cyclistic Bike-Share Rider Behaviour & Membership Conversion Analysis

**End-to-end analytics case study** — transforming over **5.4 million Cyclistic bike-share rides** into data-driven insights and business recommendations to increase annual membership conversion.

</p>

<p align="center">

![Google BigQuery](https://img.shields.io/badge/Google%20BigQuery-4285F4?style=for-the-badge&logo=googlebigquery&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=tableau&logoColor=white)
![Google Colab](https://img.shields.io/badge/Google%20Colab-F9AB00?style=for-the-badge&logo=googlecolab&logoColor=white)

</p>

---

# 👨‍💻 Author

**Brojo Mohan Dutta**

**Google Data Analytics Professional Certificate**

**Capstone Project 1**

---

# 📌 Project Overview

This end-to-end data analytics project analyzes more than **5.4 million Cyclistic bike-share rides** to understand behavioural differences between **casual riders** and **annual members**, and identify strategies to increase annual membership conversion.

Using **Google BigQuery**, **SQL**, **Python**, and **Tableau**, the project transforms raw trip data into actionable business insights through data cleaning, statistical analysis, exploratory data analysis, and interactive dashboards.

---

# 🎯 Business Problem

Cyclistic wants to increase the number of annual memberships.

The primary business question is:

> **How do annual members and casual riders use Cyclistic bikes differently, and how can these insights help convert casual riders into annual members?**

---

# 📊 Project Summary

| Category | Details |
|-----------|---------|
| Project | Cyclistic Bike-Share Rider Behaviour Analysis |
| Author | Brojo Mohan Dutta |
| Course | Google Data Analytics Professional Certificate |
| Case Study | Capstone Project 1 |
| Dataset | Divvy / Cyclistic Bike-Share Dataset |
| Total Rides Analyzed | **5.4 Million+** |
| Time Period | **Jan–Dec 2025** |
| Final Dataset | **1 Cleaned Analytical Table** |
| Tools | Google BigQuery, SQL, Python, Google Colab, Tableau Desktop |
| Dashboard | Interactive Tableau Dashboard |
| Project Type | End-to-End Data Analytics |

---

# 🛠 Technology Stack

| Tool | Purpose |
|------|---------|
| Google BigQuery | Cloud data warehouse & SQL processing |
| SQL | Data cleaning, transformation & analysis |
| Python (Pandas, NumPy, SciPy, Matplotlib) | Statistical analysis & visualization |
| Google Colab | Python development environment |
| Tableau Desktop | Interactive dashboards & business storytelling |

---

# 🔄 Project Workflow

<p align="center">
<img src="05_presentation/work_flow.png" width="70%">
</p>

The project followed this analytical workflow:

1. Download monthly Divvy trip datasets
2. Upload raw data into Google BigQuery
3. Clean and transform data using SQL
4. Create analytical features and metrics
5. Perform exploratory and statistical analysis in Python
6. Build interactive Tableau dashboards
7. Generate business insights and membership conversion recommendations

---

# 📂 Dataset Overview

The project combines monthly Cyclistic bike-share trip data into a unified analytical dataset.

The final dataset includes:

- Ride Information
- Rider Type
- Bike Type
- Ride Duration
- Time Features
- Distance Metrics
- Start & End Stations
- Geographic Coordinates

The cleaned dataset was used for SQL analysis, Python statistical testing, and Tableau dashboard development.

---

# 📈 Exploratory Data Analysis

Analysis includes:

- Descriptive Statistics
- Ride Duration Analysis
- Rider Behaviour Comparison
- Seasonal Trend Analysis
- Hourly & Weekly Usage Patterns
- Ride Distance Analysis
- Welch's t-Test
- Cohen's d Effect Size
- Conversion Opportunity Analysis

---

# 📊 Dashboard Preview

## Executive Overview

![Dashboard 1](04_tableau/dashboard_1_executive_overview.png)

---

## Rider Behaviour Analysis

![Dashboard 2](04_tableau/dashboard_2_rider_behavior.png)

---

## Conversion Opportunities

![Dashboard 3](04_tableau/dashboard_3_conversion_opportunity.png)

---

# 📈 Key Findings

- Annual members complete rides approximately **1.7× shorter** than casual riders.
- Welch's **t-test confirmed a statistically significant difference** (**p < 0.001**).
- Members primarily ride during **commuting hours (8 AM and 5 PM)**.
- Casual riders are most active during **late morning and afternoon**, indicating leisure-oriented behaviour.
- Casual ridership declines by approximately **93% between August and December**.
- Casual riders complete approximately **3.7× more round trips**, suggesting recreational riding behaviour.

---

# 💡 Business Recommendations

### 🥇 Install Membership Kiosks

Deploy membership kiosks at the highest-volume tourist stations where casual rider share reaches **57–82%**.

---

### 🥈 Weekend Marketing Campaigns

Launch targeted promotions during **Saturday and Sunday (10 AM–2 PM)** when casual ridership is highest.

---

### 🥉 Promote Membership During Leisure Trips

Offer membership incentives to riders completing **11–20 minute trips**, the largest segment of convertible casual riders.

---

# 📂 Repository Structure

```text
CYCLISTIC-BIKE-SHARE-Rider-Behaviour-Conversion-Analysis/

│── README.md
│── LICENSE
│── .gitignore

├── 01_data
│   ├── sample_data.csv
│   ├── sample_cleaned_data.csv
│   ├── DATA_SOURCE.md
│   └── data_dictionary.md
│
├── 02_sql
│   ├── 01_combine_months.sql
│   ├── 02_transform.sql
│   ├── 03_clean.sql
│   ├── 04_analysis_queries.sql
│   ├── 05_dashboard_export.sql
│   ├── 06_python_sample.sql
│   ├── sql_documentation.docx
│   └── sql_documentation.pdf
│
├── 03_python
│   ├── visuals/
│   ├── cyclistic_analysis.ipynb
│   ├── python_documentation.docx
│   ├── python_documentation.pdf
│   └── requirements.txt
│
├── 04_tableau
│   ├── Cyclistic Rider Behavior & Membership Conversion Analysis.twbx
│   ├── dashboard_1_executive_overview.png
│   ├── dashboard_2_rider_behavior.png
│   ├── dashboard_3_conversion_opportunity.png
│   └── tableau_public_link.md
│
├── 05_presentation
│   ├── case_study_brief_README.md
│   ├── case_study_report.docx
│   ├── case_study_report.pdf
│   ├── key_findings.md
│   └── work_flow.png
```

---

# 📈 Tableau Dashboard

### Live Dashboard

👉 **Tableau Public**

https://public.tableau.com/views/CyclisticRiderBehaviorMembershipConversionAnalysis/ExecutiveOverview?:language=en-US&:display_count=n&:origin=viz_share_link

---

# 📂 Dataset

**Source:** Divvy Trip Data (Motivate International Inc.)

https://divvy-tripdata.s3.amazonaws.com/index.html

The raw monthly datasets were processed using **Google BigQuery** before statistical analysis and dashboard development.

---

# 📄 Project Deliverables

✔ SQL Scripts

✔ Python Notebook

✔ Tableau Dashboard

✔ Business Report

✔ Executive Brief

✔ Documentation

---

# 📜 License

This project is licensed under the **MIT License**.

---

# ⭐ Support

If you found this project helpful, please consider giving this repository a ⭐.

Thank you for visiting!
