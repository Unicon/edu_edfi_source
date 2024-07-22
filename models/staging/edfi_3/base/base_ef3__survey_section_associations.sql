with survey_section_associations as (
    {{ source_edfi3('survey_section_associations') }}
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
        v:sectionReference::sectionIdentifier::string as section_id,
        v:sectionReference::sessionName::string as session_name,
        v:sectionReference::schoolId::string as school_id,
        v:sectionReference::schoolYear::string as school_year,
        -- references
        v:sectionReference as sectionReference
        v:surveyReference as surveyReference
    from survey_section_response_education_organization_target_associations
)
select * from renamed
