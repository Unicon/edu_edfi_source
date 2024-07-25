with school_year_types as (
    select * from {{ ref('base_ef3__school_year_types') }}
    where not is_deleted
),
keyed as (
    select
        {{ dbt_utils.surrogate_key(
            [
                'tenant_code',
                'api_year',
                'lower(school_year)',
                'lower(current_school_year)'
            ]
        )}} as k_school_year_types,
        api_year as school_year,
        school_year_types.*
        {{ extract_extension(model_name=this.name, flatten=True) }}
    from school_year_types
),
deduped as (
    {{
        dbt_utils.deduplicate(
            relation='keyed',
            partition_by='k_school_year_types',
            order_by='pull_timestamp desc'
        )
    }}
)
