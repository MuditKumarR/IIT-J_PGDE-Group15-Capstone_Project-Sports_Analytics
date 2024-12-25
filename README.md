# Capstone Project: Sports Analytics

## Team Members
- **Anup Shaw (G23AI2015)**
- **Mudit Kumar (G23AI2037)**
- **Abhinandan K R (G23AI2043)**
- **Pariniti Mishra (G23AI2036)**
- **Keyur Karve (G23AI2072)**

**Supervised By:** Shriya Raj Mahan

---

## Project Overview
This project focuses on the systematic analysis of sports data to derive insights, improve performance, and enhance decision-making in athletic environments. Leveraging advanced tools such as machine learning, predictive modeling, and big data analytics, the project demonstrates how analytics is revolutionizing sports. 

Inspired by the "Moneyball" approach popularized by the Oakland Athletics, this project applies analytics to various professional and amateur sports, including basketball, soccer, tennis, cricket, and American football.

---

## Team Win Prediction App
As part of this project, we developed a **Team Win Prediction App**. The app leverages machine learning models to predict the winning probabilities of teams based on various features such as team performance, weather conditions, and other match-related data.

You can access the app here: [Sports Analytics App](https://iit-j-capstone-project-group15-sports-analytics.streamlit.app/).

### Embedded App View:
<iframe src="https://iit-j-capstone-project-group15-sports-analytics.streamlit.app/" width="100%" height="600px" frameborder="0"></iframe>

---

## Project Architecture
The architecture of our project is structured to handle the entire lifecycle of data analytics in sports, from data collection to actionable insights:

!./image.png

1. **Data Sources:**
   - API, Databases, IoT Sensors, and Files (CSV, Parquet, ORC, Binary, JSON, XML, Excel, Avro).

2. **ETL Pipeline:**
   - **Glue:** Used for data extraction and transformation.
   - **AWS S3:** Acts as the central data lake.
   - **SNS (Simple Notification Service):** Triggers the pipeline.

3. **Snowflake Warehouse:**
   - **Snow Pipe:** Automates data loading into Snowflake.
   - **Snow Stream:** Processes real-time updates.
   - **Tables:** Stores structured data for analytics.

4. **Analytics Layer:**
   - Outputs are used for generating insights and powering dashboards.

---

## Table of Contents
1. [Introduction](#introduction)
2. [Agenda](#agenda)
3. [Data Overview & Preprocessing](#data-overview--preprocessing)
4. [Project Management](#project-management)
5. [ETL Process & Architecture](#etl-process--architecture)
6. [Challenges & Limitations](#challenges--limitations)
7. [Statistical Findings](#statistical-findings)
8. [Sports Analytics App Overview](#sports-analytics-app-overview)
9. [Dashboard Overview](#dashboard-overview)
10. [Conclusion](#conclusion)

---

## Introduction
Sports analytics combines statistics, technology, and data science to transform decision-making processes in sports. By integrating advanced tools, this field has evolved to optimize performance, strategy, and even business outcomes. It has become an integral part of most professional sports, improving both on-field and off-field decisions.

---

## Agenda
The project presentation covered the following key areas:
1. Introduction
2. Data Overview & Preprocessing
3. Project Management
4. ETL Process & Architecture
5. Challenges & Limitations
6. Statistical Findings
7. Sports Analytics App Overview
8. Dashboard Overview
9. Conclusion

---

## Data Overview & Preprocessing
### Match Data:
- **Teams:** Home and away team details.
- **Scores:** Final match scores for performance analysis.
- **Dates and Locations:** Temporal and geographic data for trend analysis.

### Player Data:
- **Goals and Assists:** Player contributions to match outcomes.
- **Minutes Played:** Metrics for player engagement and stamina.
- **Cards:** Analysis of yellow and red cards received.

### Preprocessing Steps:
- Addressed data gaps and inconsistencies, particularly in older records (e.g., missing attendance and weather conditions).
- Standardized player names and team abbreviations to ensure consistency.

---

## Project Management
The project was managed collaboratively by a team of five members under the guidance of our supervisor. A structured approach was taken for:
- **Requirement gathering:** Understanding data needs and project goals.
- **Task allocation:** Efficient distribution of responsibilities.
- **Milestone tracking:** Ensuring timely completion of tasks.

---

## Challenges & Limitations
### Data Challenges:
- Missing or incomplete records in older datasets (e.g., attendance, weather conditions).
- Variations in player naming conventions and team abbreviations required extensive preprocessing.

### Model Limitations:
- Predictive models like XGBoost require significant computational resources and large datasets to avoid overfitting.
- External factors, such as tactical adjustments and team dynamics, are not fully captured in structured datasets.

---

## Statistical Findings
### Features Used for Prediction:
- Weather, City, Team1, Team2, Attendance.

### Models Implemented:
1. Naive Bayes
2. Logistic Regression
3. Random Forest
4. XGBoost
5. LightGBM

### Best Model:
- **XGBoost:** Demonstrated the highest accuracy among the tested models.

---

## Sports Analytics App Overview
The sports analytics app is a comprehensive tool that allows users to explore match and player data interactively. Key features include:
- Team-level and player-level performance analysis.
- Insights on external factors like attendance and weather.
- Predictive analytics to forecast outcomes and trends.

---

## Dashboard Overview
The dashboard provides a user-friendly interface with:
- Visualizations for team and player performance metrics.
- Trends and patterns in match outcomes.
- Interactive charts for exploring various factors, such as possession and goals.

---

## Conclusion
### Key Insights:
- Strong relationships were identified between possession, goals, and match outcomes.
- Attendance and weather significantly influence team performance.
- Player-level analysis revealed high-impact contributors and trends.

### Recommendations:
1. Focus on improving shot conversion rates over possession metrics.
2. Adapt strategies to account for weather conditions.
3. Use predictive analytics to monitor players' workload and prevent injuries.
4. Recruit players with strong goal efficiency and assist metrics.

---

This README now includes details about your app, along with an embedded view. Note that GitHub’s markdown does not support iframe rendering directly, so for embedding, this feature works only in environments that support iframe, like your website or documentation hosted elsewhere.
