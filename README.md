# 🚴 Cyclistic Bike-Share Rider Behaviour & Membership Conversion Analysis

<p align="center">
  <img src="05_presentation/work_flow.png" alt="Cyclistic Workflow" width="100%">
</p>

<p align="center">

![Google BigQuery](https://img.shields.io/badge/Google%20BigQuery-4285F4?style=for-the-badge\&logo=googlebigquery\&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge\&logo=python\&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge\&logo=tableau\&logoColor=white)
![Google Colab](https://img.shields.io/badge/Google%20Colab-F9AB00?style=for-the-badge\&logo=googlecolab\&logoColor=white)

</p>

## 👨‍💻 Author

**Brojo Mohan Dutta**

**Google Data Analytics Professional Certificate**

**Capstone Project 1**

---

# 📌 Project Overview

This end-to-end data analytics project analyzes over **5.4 million Cyclistic bike-share rides** to understand behavioral differences between **casual riders** and **annual members**.

Using **Google BigQuery**, **Python**, and **Tableau**, the project transforms raw ride data into business insights and actionable recommendations that support Cyclistic's goal of increasing annual memberships.

---

# 🎯 Business Problem

Cyclistic wants to increase the number of annual memberships.

The primary business question is:

> **How do annual members and casual riders use Cyclistic bikes differently, and what strategies can convert casual riders into annual members?**

---

# 📊 Project Summary

| Category             | Details                                                     |
| -------------------- | ----------------------------------------------------------- |
| Project              | Cyclistic Bike-Share Rider Behaviour Analysis               |
| Author               | Brojo Mohan Dutta                                           |
| Course               | Google Data Analytics Professional Certificate              |
| Case Study           | Capstone Project 1                                          |
| Dataset              | Divvy / Cyclistic Bike-Share                                |
| Total Rides Analyzed | **5.4 Million+**                                            |
| Tools                | Google BigQuery, SQL, Python, Google Colab, Tableau Desktop |
| Dashboard            | Interactive Tableau Dashboard                               |
| Project Type         | End-to-End Data Analytics                                   |

---

# 🛠 Technology Stack

| Tool                                      | Purpose                                    |
| ----------------------------------------- | ------------------------------------------ |
| Google BigQuery                           | Data storage, SQL querying, transformation |
| SQL                                       | Data cleaning and exploratory analysis     |
| Python (Pandas, NumPy, SciPy, Matplotlib) | Statistical analysis and visualization     |
| Google Colab                              | Python development environment             |
| Tableau Desktop                           | Interactive dashboards and storytelling    |

---

# 🔄 Project Workflow

* Data Collection
* Data Storage (Google BigQuery)
* Data Cleaning & Transformation
* Exploratory Data Analysis (SQL & Python)
* Statistical Testing
* Interactive Dashboard Development
* Business Insights & Recommendations

---

# 📈 Key Findings

* Annual members complete rides approximately **1.7× shorter** than casual riders.
* Welch's **t-test confirmed a statistically significant difference** (**p < 0.001**).
* Members primarily ride during **commuting hours (8 AM and 5 PM)**.
* Casual riders are most active from **late morning through afternoon**, indicating leisure-oriented usage.
* Casual ridership declines by approximately **93% between August and December**, highlighting strong seasonality.
* Casual riders complete approximately **3.7× more round trips**, suggesting recreational riding behavior.

---

# 💡 Business Recommendations

### 1️⃣ Install Membership Kiosks

Deploy membership kiosks at the five highest-volume tourist stations where casual rider share ranges from **57%–82%**.

---

### 2️⃣ Weekend Marketing Campaigns

Target **Saturday and Sunday (10 AM–2 PM)** when casual ridership reaches its peak.

---

### 3️⃣ Promote Membership During Short Leisure Trips

Focus promotional offers on **11–20 minute casual rides**, representing the largest segment of convertible riders.

---

# 📊 Dashboard Preview

### Executive Overview

![Executive Dashboard](04_tableau/dashboard_1_executive_overview.png)

---

### Rider Behaviour Analysis

![Behaviour Dashboard](04_tableau/dashboard_2_rider_behavior.png)

---

### Conversion Opportunities

![Conversion Dashboard](04_tableau/dashboard_3_conversion_opportunity.png)

---

# 📂 Repository Structure

```text
01_data/
│── sample_data.csv
│── sample_cleaned_data.csv
│── DATA_SOURCE.md
│── data_dictionary.md

02_sql/
│── 01_combine_months.sql
│── 02_transform.sql
│── 03_clean.sql
│── 04_analysis_queries.sql
│── 05_dashboard_export.sql
│── 06_python_sample.sql
│── sql_documentation.docx
│── sql_documentation.pdf

03_python/
│── visuals/
│── cyclistic_analysis.ipynb
│── python_documentation.docx
│── python_documentation.pdf
│── requirements.txt

04_tableau/
│── Cyclistic Rider Behavior & Membership Conversion Analysis.twbx
│── dashboard_1_executive_overview.png
│── dashboard_2_rider_behavior.png
│── dashboard_3_conversion_opportunities.png
│── tableau_public_link.md

05_presentation/
│── case_study_brief_README.md
│── case_study_report.docx
│── case_study_report.pdf
│── key_findings.md
│── work_flow.png

README.md
LICENSE
.gitignore
```

---

# 🔗 Interactive Dashboard

👉 **Tableau Public**

https://public.tableau.com/views/CyclisticRiderBehaviorMembershipConversionAnalysis/ExecutiveOverview?:language=en-US&:display_count=n&:origin=viz_share_link

---

# 📂 Dataset

**Source:** Divvy Trip Data (Motivate International Inc.)

https://divvy-tripdata.s3.amazonaws.com/index.html

Processed using **Google BigQuery**.

---

# 📜 License

This project is licensed under the **MIT License**.

---

# ⭐ If you found this project useful

Please consider giving the repository a ⭐ on GitHub.
