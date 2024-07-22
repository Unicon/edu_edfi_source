with student_neglected_or_delinquent_program_associations as (
    {{ source_edfi3('student_neglected_or_delinquent_program_associations') }}
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

        v:id::string                             as record_guid,
        v:beginDate::date                        as begin_date,
        v:endDate::date                          as end_date,
        v:servedOutsideOfRegularSession::boolean as is_served_outside_of_regular_session,

        v:educationOrganizationReference:educationOrganizationId::integer as ed_org_id,

        v:studentReference:studentUniqueId::string as student_unique_id,

        v:programReference:educationOrganizationId::integer as education_organization_id,
        v:programReference:programName::string              as program_name,
        v:programReference:programTypeDescriptor::string    as program_type_descriptor,

        v:participationStatus:participationStatusDescriptor::string as participation_status_descriptor,
        v:participationStatus:designatedBy::string                  as designated_by,
        v:participationStatus:statusBeginDate::date                 as status_begin_date,
        v:participationStatus:statusEndDate::date                   as status_end_date,
        -- descriptors
        {{ extract_descriptor('v:elaProgressLevelDescriptor::string') }}             as mathematics_progress_level,
        {{ extract_descriptor('v:mathematicsProgressLevelDescriptor::string') }}     as mathematics_progress_level,
        {{ extract_descriptor('v:neglectedOrDelinquentProgramDescriptor::string') }} as neglected_or_delinquent_program,
        {{ extract_descriptor('v:reasonExitedDescriptor::string') }}                 as reason_exited,
        -- references
        v:educationOrganizationReference                         as parent_reference,
        v:programReference                                       as programReference,
        v:parentReference                                        as parent_reference,
        v:studentReference                                       as student_reference,
        -- list
        v:neglectedOrDelinquentProgramServices  as v_neglected_or_delinquent_program_services,
        v:programParticipationStatuses          as v_program_participation_statuses,

        -- edfi extensions
        v:_ext as v_ext
    from student_neglected_or_delinquent_program_associations
)
select * from renamed
