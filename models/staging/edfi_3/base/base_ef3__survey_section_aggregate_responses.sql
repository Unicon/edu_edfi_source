with survey_section_aggregate_responses as (
    {{ source_edfi3('survey_section_aggregate_responses') }}
),
renamed as (
    select
        tenant_code,
        api_year,
        pull_timestamp,
        last_modified_timestamp,
        file_row_number,
        filename,
        is_deleted,
        ??
    from survey_section_aggregate_responses
)
select * from renamed
