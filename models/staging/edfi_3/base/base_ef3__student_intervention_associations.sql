with source_stu_programs as (
    {{ source_edfi3('student_homeless_program_associations') }}
),

renamed as (
    select
        -- generic columns
        tenant_code,
        api_year,
        pull_timestamp,
        last_modified_timestamp,
        file_row_number,
        filename,
        is_deleted,

        v:id::string                   as record_guid,
        v:diagnosticStatement::string  as diagnostic_statement,
        v:dosage::integer              as dosage,

        v:studentReference:studentUniqueId::string as student_unique_id,

        v:interventionReference:educationOrganizationId::integer       as education_organization_id,
        v:interventionReference:interventionIdentificationCode::string as intervention_identification_code,

        v:cohortReference:cohortIdentifier::string         as ed_org_id,
        v:cohortReference:educationOrganizationId::integer as intervention_identification_code,

        v:participationStatus:designatedBy::string                  as designated_by,
        v:participationStatus:statusBeginDate::date                 as status_begin_date,
        v:participationStatus:statusEndDate::date                   as status_end_date,

        -- references
        v:interventionReference as intervention_reference,
        v:cohortReference       as cohort_reference,
        v:studentReference      as student_reference,

        -- lists
        v:interventionEffectivenesses as v_intervention_effectivenesses,

        -- edfi extensions
        v:_ext as v_ext

    from source_stu_programs
)

select * from renamed
