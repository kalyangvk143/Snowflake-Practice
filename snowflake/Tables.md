# Tables — Description & Types of tables

This file summarizes the common table types in Snowflake and when to use them.

## 1) Permanent tables
- Description: Default table type for persistent data.
- Persistence & recovery: Supports Time Travel (data versioning) and Fail-safe.
- Use cases: Production data, audit/history, any data that must be retained/recoverable.
- Notes: Time Travel retention can be configured; Fail-safe is an additional recovery window.

## 2) Transient tables
- Description: Persistent tables without Fail-safe to reduce storage costs.
- Persistence & recovery: Supports Time Travel (configurable), but NO Fail-safe.
- Use cases: Intermediate or staging data where long-term recovery is not required.
- Notes: Lower cost compared to permanent tables because Fail-safe storage is not applied.

## 3) Temporary (TEMP) tables
- Description: Session-scoped tables that exist only for the duration of the user session.
- Persistence & recovery: No Fail-safe, Time Travel limited (effectively not retained across sessions).
- Use cases: Short-lived transformations, ad-hoc analysis, session-level temporary storage.
- Notes: Automatically dropped at session end or can be explicitly dropped.

## 4) External tables
- Description: Tables that reference data stored externally (e.g., in S3, Azure Blob, or GCS) via stages.
- Persistence & recovery: Data remains in external storage; Snowflake maintains metadata for querying.
- Use cases: Querying large data lakes without loading data into Snowflake, externalized data sharing.
- Notes: Performance depends on external storage format and location; use with appropriate file formats and partitioning.

## 5) Cloned tables (zero-copy clone)
- Description: Logical copy of a table created using CLONE; initially shares data with the source (zero-copy) and diverges on write.
- Persistence & recovery: Inherits Time Travel and Fail-safe behaviour from the source; efficient for environment snapshots.
- Use cases: Creating sandbox/test copies, branching data for development or debugging.

## 6) Materialized views (MV)
- Description: Precomputed results of a query stored physically to accelerate reads. (Technically a separate object, not a base table.)
- Use cases: Performance optimization for frequently-run aggregations/queries.
- Notes: Maintained by Snowflake; consider cost and maintenance overhead.

## Quick selection guide
- Production & recoverable data: Permanent
- Lower-cost persistent staging: Transient
- Short-lived/session data: Temporary
- Data stored outside Snowflake: External tables
- Fast copies/snapshots: Clone
- Precomputed query results: Materialized Views

---

If you want this as a different file type (plain text, .sql, or placed in a different path), or want more detail (examples, DDL for each type, Time Travel retention values), tell me and I will update it.