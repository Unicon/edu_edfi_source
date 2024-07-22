with persons as (
    {{ source_edfi3('persons') }}
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
    from persons
)
select * from renamed
