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

        v:id::string                                as record_guid,
        v:surveySectionResponseReference::surveyIdentifier::string as survey_id,
        v:surveySectionResponseReference::surveySectionTitle::string as survey_section_title,
        -- references
        v:staffReference as staff_reference
    from survey_section_aggregate_responses
)
select * from renamed
