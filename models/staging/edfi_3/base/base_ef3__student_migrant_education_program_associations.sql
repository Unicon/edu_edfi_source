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

        v:eligibilityExpirationDate::date        as eligibility_expiration_date,
        v:lastQualifyingMove::date               as last_qualifying_move,
        v:priorityForServices::boolean           as is_priority_for_services,
        v:qualifyingArrivalDate::date            as qualifying_arrival_date,
        v:servedOutsideOfRegularSession::boolean as is_served_outside_of_regular_session
        v:stateResidencyDate::date               as state_residency_date
        v:usInitialEntry::date                   as us_initial_entry
        v:usInitialSchoolEntry:date              as us_initial_school_entry
        v:usMostRecentEntry::date                as us_most_recent_entry

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
        {{ extract_descriptor('v:continuationOfServicesReasonDescriptor::string') }} as continuation_of_services_reason_descriptor,
        {{ extract_descriptor('v:reasonExitedDescriptor::string') }} as reason_exited,
        -- references
        v:educationOrganizationReference                         as parent_reference,
        v:programReference                                       as programReference,
        v:parentReference                                        as parent_reference,
        v:studentReference                                       as student_reference,
        -- list
        v:migrantEducationProgramServices  as v_migrantEducationProgramServices,

        -- edfi extensions
        v:_ext as v_ext
    from student_neglected_or_delinquent_program_associations
)
select * from renamed
