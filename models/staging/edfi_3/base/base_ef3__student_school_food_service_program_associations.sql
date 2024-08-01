with student_school_food_service_program_associations as (
    {{ source_edfi3('student_school_food_service_program_associations') }}
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

        v:id::string                               as record_guid,
        v:beginDate::date                          as begin_date,
        v:endDate::date                            as end_date,
        v:directCertification::boolean             as is_direct_certification,
        v:servedOutsideOfRegularSession::boolean   as is_served_outside_of_regular_session,

        v:educationOrganizationReference:education_organization_id::integer as education_organization_id,
        v:programReference:educationOrganizationId:integer              as education_organization_id,
        v:programReference:programName::string     as program_name,
        v:programReference:programTypeDescriptor::string     as program_type_descriptor,
        v:studentReference:studentUniqueId::string as student_unique_id,

        v:participationStatus:participationStatusDescriptor::string as participation_status_descriptor,
        v:participationStatus:designatedBy::string as designated_by,
        v:participationStatus:statusBeginDate::date as status_begin_date,
        v:participationStatus:statusEndDate::date as status_end_date,

        -- descriptors
        {{ extract_descriptor('v:reasonExitedDescriptor::string') }} as reason_exited_descriptor,
        -- references
        v:educationOrganizationReference  as education_organization_reference,
        v:programReference as program_reference,
        v:studentReference as student_reference
        -- nested lists
        v:programParticipationStatuses         as v_programParticipationStatuses,
        v:schoolFoodServiceProgramServices     as v_schoolFoodServiceProgramServices

    from student_school_food_service_program_associations
)
select * from renamed
