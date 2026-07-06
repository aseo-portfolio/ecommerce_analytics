ecommerce_analytics

An analytics engineering project built on Google's public thelook_ecommerce dataset (bigquery-public-data.thelook_ecommerce).
[Placeholder for business question]

dbt Core, BigQuery, GitHub

### Project Architecture

- staging
- intermediate
- marts
- snapshot


### Technical Concepts

#### dbt
- Layered project architecture
- Source definitions with freshness checks
- Schema tests and column-level yml documentation
- Incremental materialization with merge strategy and date partitioning
- Custom Jinja macro with dynamic parameters and looping
- dbt_utils package - surrogate key generate and date spine

#### SQL
- Window Functions
- Running totals and cumulative aggregations
- Date spine joins for cohort-style analysis
- Star schema design