# CrimeLens – Crime Management System

## 📌 Project Overview

CrimeLens is a **MySQL-based Crime Management System** developed to store, manage, and analyze crime-related information.

The system manages details about **crimes, victims, suspects, police officers, cases, and evidence** using a relational database.

## 🎯 Objectives

- Store crime records efficiently
- Maintain victim and suspect information
- Manage police officers and cases
- Track evidence related to crimes
- Analyze crimes based on type, location, severity, and status
- Generate useful crime reports
- Practice advanced SQL concepts

## 🛠️ Technologies Used

- **MySQL**
- **SQL**
- **Git**
- **GitHub**

## 🗃️ Database Tables

The project contains the following tables:

1. `crimes`
2. `victims`
3. `suspects`
4. `officers`
5. `cases`
6. `evidence`
7. `crime_audit`

## 🔑 SQL Concepts Implemented

- Database & Table Creation
- Primary Keys
- Foreign Keys
- Constraints
- INSERT / SELECT
- WHERE
- GROUP BY
- ORDER BY
- Aggregate Functions
- JOINs
- Subqueries
- Views
- Stored Procedures
- Functions
- Triggers
- Transactions
- Indexes
- Reports

## 📊 Reports Generated

The system provides:

- Crime Summary Report
- Location-wise Crime Report
- Pending Cases Report
- Monthly Crime Report
- High-Severity Crime Report

## 🔗 Database Relationships

- A **crime** can have multiple victims
- A **crime** can have multiple suspects
- A **crime** can have multiple cases
- An **officer** can handle multiple cases
- A **crime** can have multiple evidence records
- Crime activities can be tracked using the audit table

## 🚀 How to Run the Project

### Step 1: Install MySQL

Install **MySQL Server** and **MySQL Workbench**.

### Step 2: Open the SQL File

Open `crimelens.sql` in MySQL Workbench.

### Step 3: Execute the Script

Run the complete SQL script.

The script will:

- Create the `crimelens` database
- Create all required tables
- Insert sample data
- Create views
- Create procedures and functions
- Create triggers
- Demonstrate transactions
- Create indexes
- Generate reports

### Step 4: Verify the Database

```sql
USE crimelens;
SHOW TABLES;
