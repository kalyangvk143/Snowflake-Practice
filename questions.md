# Snowflake Interview Questions (Topic Wise)

For **3 to 5 years Data Engineer interviews**, focus on these topics in order.

***

# 1. Snowflake Architecture

### Q1. What is Snowflake?

### Q2. Explain Snowflake Architecture.

### Q3. What are the layers in Snowflake?

### Q4. How does Snowflake separate Storage and Compute?

### Q5. What are Snowflake editions?

**Expected Answer Areas**

* Storage Layer
* Compute Layer
* Cloud Services Layer
* Multi-cluster architecture

***

# 2. Virtual Warehouses

### Q1. What is a Virtual Warehouse?

### Q2. How do you create a Warehouse?

### Q3. Difference between Warehouse and Database?

### Q4. What is Auto Suspend?

### Q5. What is Auto Resume?

### Q6. What is Multi-Cluster Warehouse?

### Q7. How do you resize a Warehouse?

***

# 3. Databases, Schemas & Tables

### Q1. Difference between Database and Schema?

### Q2. Types of Tables in Snowflake?

### Q3. Temporary Table vs Transient Table vs Permanent Table?

### Q4. What is Zero Copy Cloning?

### Q5. What are External Tables?

***

# 4. Data Loading

### Q1. What is COPY INTO Command?

```sql
COPY INTO EMPLOYEE
FROM @STAGE;
```

### Q2. What are Stages?

### Q3. Internal vs External Stage?

### Q4. How do you load files from Azure Blob?

### Q5. How do you load Parquet files?

### Q6. How do you load JSON files?

***

# 5. Snowpipe

### Q1. What is Snowpipe?

### Q2. Difference between COPY INTO and Snowpipe?

### Q3. How does Snowpipe work?

### Q4. Event-based vs Scheduled Loading?

### Q5. Snowpipe architecture?

***

# 6. Streams and Tasks

### Q1. What is a Stream?

### Q2. What is CDC?

### Q3. How does Stream capture changes?

### Q4. What is a Task?

### Q5. Difference between Stream and Task?

### Q6. How do you build Incremental Loads?

### Scenario

```text
Source Table
     ↓
Stream
     ↓
Task
     ↓
Target Table
```

### Interview Favorite

"Explain end-to-end CDC implementation using Streams and Tasks."

***

# 7. Time Travel & Fail-safe

### Q1. What is Time Travel?

### Q2. What is Fail-safe?

### Q3. Difference between Time Travel and Fail-safe?

### Q4. How do you recover deleted data?

Example:

```sql
UNDROP TABLE EMPLOYEE;
```

***

# 8. Micro Partitions

### Q1. What are Micro Partitions?

### Q2. Does Snowflake support manual partitioning?

### Q3. What is Partition Pruning?

### Q4. How does Snowflake store data?

### Important Question

"How does Snowflake improve query performance?"

**Answer**

* Metadata
* Partition pruning
* Columnar storage

***

# 9. Clustering

### Q1. What is Clustering Key?

### Q2. When should we use Clustering?

### Q3. Advantages of Clustering?

### Q4. What is Automatic Clustering?

Example:

```sql
CLUSTER BY (ORDER_DATE)
```

***

# 10. Semi-Structured Data

### Q1. What is VARIANT?

### Q2. What is OBJECT?

### Q3. What is ARRAY?

### Q4. How do you load JSON data?

### Q5. How do you query JSON fields?

Example:

```sql
SELECT DATA:name
FROM EMPLOYEE_JSON;
```

***

# 11. Security

### Q1. What is RBAC?

### Q2. Difference between Roles and Users?

### Q3. What is Network Policy?

### Q4. What is Data Masking?

### Q5. What is Row-Level Security?

### Commands

```sql
GRANT SELECT
ON TABLE EMP
TO ROLE ANALYST;
```

***

# 12. Snowflake Performance Tuning

### Q1. How do you improve query performance?

### Q2. What is Query Profile?

### Q3. What is Search Optimization Service?

### Q4. How do you identify slow queries?

### Q5. What is Warehouse Scaling?

### Common Interview Scenario

"A query is taking 30 minutes. What will you check?"

Answer:

* Query Profile
* Clustering
* Warehouse Size
* Filter Conditions
* Data Skew

***

# 13. Snowflake Stored Procedures

### Q1. What is a Stored Procedure?

### Q2. Types of Stored Procedures?

### Q3. JavaScript Stored Procedures?

### Q4. Snowpark Procedures?

Example:

```sql
CALL LOAD_EMPLOYEE();
```

***

# 14. User Defined Functions (UDF)

### Q1. What is UDF?

### Q2. Difference between Procedure and UDF?

### Q3. Types of UDF?

***

# 15. Snowpark

### Q1. What is Snowpark?

### Q2. Snowpark vs Spark?

### Q3. Languages supported in Snowpark?

### Q4. Why Snowpark is important?

***

# 16. Data Sharing

### Q1. What is Secure Data Sharing?

### Q2. How do you share data across accounts?

### Q3. Reader Accounts?

***

# 17. Dynamic Tables

### Q1. What are Dynamic Tables?

### Q2. Dynamic Tables vs Materialized Views?

### Q3. Use Cases?

***

# 18. Git Integration

### Q1. How to integrate GitHub with Snowflake?

### Q2. What is Git Repository Object?

### Q3. What is API Integration?

### Q4. How do you fetch code from GitHub?

***

# 19. Azure + Snowflake

### Q1. How do you connect Azure Blob Storage to Snowflake?

### Q2. What is Storage Integration?

### Q3. How do you load files from ADLS Gen2?

### Architecture

```text
Azure Blob
     ↓
External Stage
     ↓
COPY INTO
     ↓
Snowflake Table
```

***

# 20. Scenario-Based Questions

### Q1. How would you design a CDC pipeline?

### Q2. How would you process 100 million records daily?

### Q3. How do you handle duplicate records?

### Q4. What will you do if Snowpipe stops loading files?

### Q5. A warehouse is consuming more credits. How will you optimize it?

### Q6. How do you migrate data from SQL Server to Snowflake?

### Q7. Explain a real-time project architecture using Snowflake.

***

# Most Important Topics for Your Data Engineer Interviews

Priority order:

1. Snowflake Architecture
2. Virtual Warehouses
3. Stages
4. COPY INTO
5. Snowpipe
6. Streams
7. Tasks
8. Time Travel
9. Fail-safe
10. Micro Partitions
11. Clustering
12. Performance Tuning
13. Security (RBAC)
14. Semi-Structured Data
15. Snowpark
16. Azure Blob + Snowflake Integration
17. Git Integration
18. Dynamic Tables
19. Stored Procedures
20. Real-Time CDC Scenarios
