with performance_evaluations as (
    {{ source_edfi3('performance_evaluations') }}
),
renamed as (
    select
        tenant_code,
        api_year,
        pull_timestamp,
        last_modified_timestamp,
        filename,
        file_row_number,
        is_deleted,
        ??
    from performance_evaluations
)
select * from renamed
