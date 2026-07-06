# ecommerce_analytics

An analytics engineering project built on Google's public thelook_ecommerce dataset.

Stack: dbt Core, BigQuery, GitHub

[dbt docs](https://aseo-portfolio.github.io/ecommerce_analytics/#!/overview)

### Table of Contents

- [Data Architecture](#data-architecture)
- [Technical Concepts](#technical-concepts)

### Data Architecture

| Model | Description |
| --- | --- |
| source | bigquery-public-data.thelook_ecommerce |
| staging | One model per source table with minimal cleaning/renaming |
| intermediate | Implements business logic, joins, window functions |
| marts | Star schema with fact and dimension tables for BI analytics consumption |
| snapshots | Snapshots of changes including user attribute |


### Technical Concepts

#### dbt
- Layered project architecture
- Source definitions with freshness checks
- Schema tests and column-level yml documentation
- Incremental materialization with merge strategy and date partitioning
- Custom Jinja macro with dynamic parameters and looping
- dbt_utils package - surrogate key generate and date spine
- Seed and Snapshot

#### SQL
- Window Functions
- Running totals and cumulative aggregations
- Date spine joins for cohort-style analysis
- Star schema design
- Qualify Function