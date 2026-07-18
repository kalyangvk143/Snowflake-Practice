# ❄️ Data sharing,Data Masking,Encryption

## 📚 Topics Covered

- Data Sharing
- Reader Accounts
- Dynamic Data Masking
- Data Encryption & Decryption
- SHA-256 Hashing
- Hands-on SQL Examples
- Interview Questions

---

# 1. Data Sharing

## What is Data Sharing?

Snowflake Data Sharing enables secure, live sharing of data between Snowflake accounts **without copying or moving the data**.

### Advantages

- No Data Copy
- Real-Time Access
- Read-Only for Consumers
- Secure Data Sharing
- No ETL Required

---

## Producer Side

### Create Share

```sql
CREATE SHARE order_data_share
COMMENT='Share order analytics with partner';
```

### Grant Database

```sql
GRANT USAGE ON DATABASE OMS_DEV
TO SHARE order_data_share;
```

### Grant Schema

```sql
GRANT USAGE ON SCHEMA OMS_DEV.BRONZE
TO SHARE order_data_share;
```

### Grant Table Access

```sql
GRANT SELECT ON TABLE OMS_DEV.BRONZE.ORDERS
TO SHARE order_data_share;

GRANT SELECT ON TABLE OMS_DEV.BRONZE.ORDERS_V2
TO SHARE order_data_share;
```

### Verify Share

```sql
SHOW SHARES;

DESC SHARE order_data_share;
```

### Add Consumer Account

```sql
ALTER SHARE order_data_share
ADD ACCOUNTS=THAJKWT.VITECH_JOY_ACCOUNT;
```

---

# Consumer Side

View available shares

```sql
SHOW SHARES;
```

View share details

```sql
DESC SHARE THAJKWT.PY97813.ORDER_DATA_SHARE;
```

Create database from share

```sql
CREATE DATABASE DATA_SHARE_DB
FROM SHARE THAJKWT.PY97813.ORDER_DATA_SHARE;
```

Query shared table

```sql
SELECT *
FROM DATA_SHARE_DB.BRONZE.ORDERS;
```

Attempting to modify data

```sql
DELETE FROM DATA_SHARE_DB.BRONZE.ORDERS;
```

NOTE:-This fails because shared databases are **Read Only**.

---

# Reader Account

A Reader Account allows organizations without a Snowflake account to access shared data.

```sql
CREATE MANAGED ACCOUNT vitech_joy_account
ADMIN_NAME='vitech_joy_admin'
ADMIN_PASSWORD='Test@123456789'
TYPE=READER;
```

Show Reader Accounts

```sql
SHOW MANAGED ACCOUNTS;
```

---

# Consumer vs Reader Account

| Consumer Account | Reader Account |
|------------------|---------------|
| Already has Snowflake | No Snowflake Account |
| Uses existing account | Producer creates account |
| Self-managed | Managed by Producer |

---

# 2. Dynamic Data Masking

Dynamic Data Masking protects sensitive information based on user roles.

Example

Original

```
262-665-9168
```

Masked

```
##-###-##
```

---

## Create Roles

```sql
CREATE ROLE ANALYST_FULL;

CREATE ROLE ANALYST_MASKED;
```

Grant Permissions

```sql
GRANT USAGE ON DATABASE OMS_DEV TO ROLE ANALYST_FULL;
GRANT USAGE ON DATABASE OMS_DEV TO ROLE ANALYST_MASKED;

GRANT USAGE ON SCHEMA OMS_DEV.PUBLIC TO ROLE ANALYST_FULL;
GRANT USAGE ON SCHEMA OMS_DEV.PUBLIC TO ROLE ANALYST_MASKED;

GRANT SELECT ON TABLE OMS_DEV.PUBLIC.CUSTOMERS TO ROLE ANALYST_FULL;
GRANT SELECT ON TABLE OMS_DEV.PUBLIC.CUSTOMERS TO ROLE ANALYST_MASKED;
```

---

## Create Phone Masking Policy

```sql
CREATE OR REPLACE MASKING POLICY phone
AS (val VARCHAR)
RETURNS VARCHAR ->
CASE
WHEN CURRENT_ROLE() IN ('ACCOUNTADMIN','ANALYST_FULL')
THEN val
ELSE '##-###-##'
END;
```

Apply Policy

```sql
ALTER TABLE CUSTOMERS
MODIFY COLUMN PHONE
SET MASKING POLICY phone;
```

---

## Mask Customer Name

```sql
CREATE OR REPLACE MASKING POLICY names
AS (val VARCHAR)
RETURNS VARCHAR ->
CASE
WHEN CURRENT_ROLE() IN ('ACCOUNTADMIN','ANALYST_FULL')
THEN val
ELSE CONCAT(LEFT(val,2),'*******')
END;
```

Apply

```sql
ALTER TABLE CUSTOMERS
MODIFY COLUMN FULL_NAME
SET MASKING POLICY names;
```

---

## Task Solution

Mask phone numbers like

```
**********9168
**********7120
**********3659
```

```sql
CREATE OR REPLACE MASKING POLICY phone_mask
AS (val VARCHAR)
RETURNS VARCHAR ->
CASE
WHEN CURRENT_ROLE() IN ('ACCOUNTADMIN','ANALYST_FULL')
THEN val
ELSE REPEAT('*', LENGTH(val)-4) || RIGHT(val,4)
END;
```

Apply

```sql
ALTER TABLE CUSTOMERS
MODIFY COLUMN PHONE
SET MASKING POLICY phone_mask;
```

---

# 3. Encryption

Encryption converts readable data into encrypted binary data.

Example

```
abc@gmail.com

↓

Encrypted Binary
```

Encrypt Email

```sql
SELECT
encrypt(
to_binary(hex_encode(email)),
'sample_passphrase',
NULL,
'aes-cbc/pad:pkcs'
)
FROM CUSTOMERS;
```

---

# SHA-256 Hashing

Generate SHA-256 hash

```sql
SELECT SHA2(email,256)
FROM CUSTOMERS;
```

---

## SHA Variants

```sql
SHA2(value,224)

SHA2(value,256)

SHA2(value,384)

SHA2(value,512)
```

Most commonly used:

```
SHA-256
```

---

# Create Secured Table

```sql
CREATE OR REPLACE TABLE CUSTOMERS_SECURED AS
SELECT

FULL_NAME,

PHONE,

encrypt(
to_binary(hex_encode(email)),
'sample_passphrase',
NULL,
'aes-cbc/pad:pkcs'
) AS encrypted_email,

SHA2(email,256) AS email_sha256

FROM CUSTOMERS;
```

---

# Decryption

```sql
SELECT

FULL_NAME,

HEX_DECODE_STRING(

CAST(

DECRYPT(
encrypted_email,
'sample_passphrase',
NULL,
'aes-cbc/pad:pkcs'
)

AS VARCHAR)

) AS decrypted_email

FROM CUSTOMERS_SECURED;
```

---

# Encryption vs Hashing

| Feature | Encryption | Hashing |
|----------|------------|----------|
| Reversible | Yes | No |
| Uses Key | Yes | No |
| Output | Cipher Text | Hash |
| Purpose | Confidentiality | Integrity |
| Example | AES | SHA-256 |

---

# Interview Questions

### What is Snowflake Data Sharing?

Snowflake Data Sharing securely shares live data across Snowflake accounts without copying data.

---

### Can a Consumer modify shared data?

No.

Shared databases are read-only.

---

### What is a Reader Account?

A Reader Account is created by the Producer for users who do not already have a Snowflake account.

---

### What is Dynamic Data Masking?

Dynamic Data Masking hides sensitive data depending on the user's role.

---

### Difference between Encryption and Hashing?

Encryption is reversible using a key.

Hashing is one-way and cannot be reversed.

---

### Why use SHA-256?

- Data Integrity
- Fingerprinting
- Password Verification
- Duplicate Detection

---

# Summary

