with rubric_dimensions as (
    {{ source_edfi3('rubric_dimensions') }}
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
        ???
    from rubric_dimensions
)
select * from renamed
