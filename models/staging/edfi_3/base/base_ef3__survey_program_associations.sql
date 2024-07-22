with survey_question_responses as (
    {{ source_edfi3('survey_question_responses') }}
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

        v:id::string                                          as record_guid,
        v:programReference:educationOrganizationId::integer   as education_organization_id,
        v:programReference:programName::string                as program_name,
        v:programReference:programTypeDescriptor::string      as program_type_descriptor,
        v:surveyReference:namespace::string                   as namespace,
        v:surveyReference:surveyIdentifier::string            as survey_identifier,
        -- references
        v:programReference   as program_reference,
        v:surveyReference    as survey_reference

    from survey_question_responses
)
select * from renamed
