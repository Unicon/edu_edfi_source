with performance_evaluation_ratings as (
    {{ source_edfi3('performance_evaluation_ratings') }}
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
    from performance_evaluation_ratings
)
select * from renamed
