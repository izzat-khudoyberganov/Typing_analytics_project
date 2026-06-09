# ⌨️ Typing Test Performance Data Warehouse

A SQL Server Data Warehouse project designed to collect, transform, and analyze typing test performance data. This project demonstrates modern Data Engineering concepts including Medallion Architecture, ETL pipelines, data quality management, and analytical data modeling.

---

## 🚀 Project Overview

The objective of this project is to transform raw typing test data into a structured analytical model that enables performance tracking and trend analysis over time.

The solution follows the **Medallion Architecture** pattern:

* 🥉 **Bronze Layer** – Raw data ingestion
* 🥈 **Silver Layer** – Data cleansing and standardization
* 🥇 **Gold Layer** – Analytical reporting and business-ready datasets

The project showcases practical skills in:

* SQL Server Development
* ETL Pipeline Design
* Data Warehousing
* Data Quality Management
* Analytical Reporting

---

## 🏗️ Architecture

```text
Raw CSV / JSON Files
          │
          ▼
    Bronze Layer
   (Raw Ingestion)
          │
          ▼
    Silver Layer
(Data Cleansing &
 Standardization)
          │
          ▼
     Gold Layer
(Analytics &
 Reporting)
```

---

## 📂 Repository Structure

```text
typing-test-warehouse/
│
├── datasets/
│   └── typing_test_results.csv
│
├── scripts/
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   └── proc_load_bronze.sql
│   │
│   ├── silver/
│   │   ├── ddl_silver.sql
│   │   └── proc_load_silver.sql
│   │
│   └── gold/
│       ├── ddl_gold.sql
│       └── proc_load_gold.sql
│
├── README.md
└── .gitignore
```

---

# 🥉 Bronze Layer

The Bronze layer stores raw typing test data exactly as received from source files.

### Responsibilities

* Raw data ingestion
* Historical preservation
* Source data auditing
* Reprocessing support

No transformations are performed in this layer.

---

# 🥈 Silver Layer

The Silver layer cleanses, validates, and standardizes raw data for downstream analytics.

## Table: `silver.typing_tests`

Stores typing performance metrics.

| Column        | Data Type    |
| ------------- | ------------ |
| id            | VARCHAR(100) |
| wpm           | DECIMAL(5,2) |
| acc           | DECIMAL(5,2) |
| rawWpm        | DECIMAL(5,2) |
| consistency   | DECIMAL(5,2) |
| test_duration | DECIMAL(8,2) |
| test_datetime | DATETIME2    |
| skill_level   | VARCHAR(20)  |
| created_at    | DATETIME     |

---

## Table: `silver.test_config`

Stores test configuration details.

| Column      | Data Type    |
| ----------- | ------------ |
| id          | VARCHAR(100) |
| mode        | VARCHAR(50)  |
| mode2       | INT          |
| quoteLength | VARCHAR(50)  |
| punctuation | VARCHAR(20)  |
| numbers     | VARCHAR(20)  |
| language    | VARCHAR(50)  |
| funbox      | VARCHAR(100) |
| difficulty  | VARCHAR(50)  |
| lazyMode    | VARCHAR(20)  |
| blindMode   | VARCHAR(20)  |
| bailedOut   | VARCHAR(20)  |
| tags        | VARCHAR(500) |
| isPb        | VARCHAR(20)  |
| created_at  | DATETIME     |

---

## Table: `silver.date_info`

Stores date-related attributes used for reporting and trend analysis.

| Column      | Data Type    |
| ----------- | ------------ |
| id          | VARCHAR(100) |
| timestamp   | VARCHAR(50)  |
| date_day    | INT          |
| date_month  | VARCHAR(20)  |
| date_year   | INT          |
| day_of_week | VARCHAR(20)  |
| is_weekend  | VARCHAR(20)  |
| created_at  | DATETIME     |

---

## Silver Layer Transformations

* Data type conversion
* Null handling
* Standardization
* Duplicate removal
* Skill level classification
* Date enrichment

---

# 🥇 Gold Layer

The Gold layer provides business-ready datasets optimized for reporting and dashboarding.

### Analytical Use Cases

* WPM trend analysis
* Accuracy tracking
* Consistency monitoring
* Performance by typing mode
* Performance by language
* Difficulty analysis
* Weekend vs Weekday performance
* Skill level distribution

---

## 🎯 Skill Classification

Typing tests are automatically categorized into skill levels based on WPM performance.

| Skill Level | Description                           |
| ----------- | ------------------------------------- |
| Normal      | Beginner to intermediate typing speed |
| Expert      | Advanced typing speed                 |
| Master      | Elite typing performance              |

---

## 🔄 ETL Pipeline

### Bronze → Silver

* Clean raw data
* Remove invalid records
* Standardize formats
* Generate derived columns
* Calculate skill levels

### Silver → Gold

* Load reporting tables
* Aggregate metrics
* Prepare analytical datasets

---

## 📊 Example Business Questions

* How has typing speed changed over time?
* What is the average accuracy rate?
* Which typing mode produces the best results?
* How does difficulty affect performance?
* What percentage of tests reach Expert or Master level?
* Is weekend performance different from weekday performance?

---

## 🛠️ Technologies Used

* Microsoft SQL Server
* T-SQL
* Stored Procedures
* Window Functions
* Medallion Architecture
* Git
* GitHub

---

## 🚀 Getting Started

### Prerequisites

* SQL Server 2019+
* SQL Server Management Studio (SSMS)

### Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/typing-test-warehouse.git
```

### Execution Order

```text
1. Execute Bronze DDL scripts
2. Load raw typing test data
3. Execute Silver DDL scripts
4. Run Silver ETL procedures
5. Execute Gold DDL scripts
6. Run Gold ETL procedures
```

---

## 📈 Future Enhancements

* Power BI Dashboard
* Automated ETL Scheduling
* Incremental Data Loads
* Data Quality Monitoring
* Historical Performance Snapshots

---

## 👨‍💻 Author

Izzat

Software Engineer | Data Engineer

This project was built as a portfolio project to demonstrate practical Data Engineering, Data Warehousing, and SQL Server development skills.
