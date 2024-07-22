with survey_response_education_organization_target_associations as (
    {{ source_edfi3('survey_response_education_organization_target_associations') }}
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

        v:id::string                                                  as record_guid,
        v:educationOrganizationId:educationOrganizationId::string     as education_organization_id,
        v:surveyResponseReference:surveyIdentifier::string            as survey_id,
        v:surveyResponseReference:surveyResponseIdentifier::string    as survey_response_id,
        -- references
        v:educationOrganizationReference    as educationOrganizationReference,
        v:surveyResponseReference    as surveyResponseReference,

    from survey_response_education_organization_target_associations
)
select * from renamed
