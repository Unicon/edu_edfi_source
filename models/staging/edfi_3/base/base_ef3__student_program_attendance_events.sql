with student_program_attendance_events as (
    {{ source_edfi3('student_program_attendance_events') }}
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

        v:id::string                                                      as record_guid,
        v:eventDate::date                                                 as event_date
        v:educationOrganizationReference:educationOrganizationId::integer as ed_org_id,
        v:educationOrganizationReference:link:rel::string                 as ed_org_type,
        v:programReference:educationOrganizationId::integer               as program_ed_org_id,
        v:programReference:programName::string                            as program_name,
        v:studentReference:studentUniqueId::string                        as student_id,
        v:attendanceEventReason::string                                   as attendance_event_reason,
        v:eventDuration::integer                                          as event_duration,
        v:programAttendanceDuration::integer                              as program_attendance_duration,

        -- descriptors
        {{ extract_descriptor('v:attendanceEventCategoryDescriptor::string') }} as attendance_event_category,
        {{ extract_descriptor('v:educationalEnvironmentDescriptor::string') }} as educational_environment,

        -- references
        v:educationOrganizationReference as education_organization_reference,
        v:programReference               as program_reference,
        v:studentReference               as student_reference

    from source_stu_programs
)
select * from renamed
