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
        v:courseReference:courseCode::string                  as course_code,
        v:courseReference:educationOrganizationId::integer    as education_organization_id,
        v:surveyReference:namespace::string                   as namespace,
        v:surveyReference:surveyIdentifier::string            as survey_identifier,
        -- references
        v:courseReference as program_reference,
        v:surveyReference as survey_reference

    from survey_question_responses
)
select * from renamed
