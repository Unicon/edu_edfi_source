with section_attendance_taken_events as (
    {{ source_edfi3('section_attendance_taken_events') }}
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

        v:id::string as record_guid,
        -- fields
        v:eventDate::string as event_date,
        -- calendar date key
        v:calendarDateReference:calendarCode::string   as calendar_date_local_course_code,
        v:calendarDateReference:date::date             as calendar_date_date,
        v:calendarDateReference:schoolId::int          as calendar_date_school_id,
        v:calendarDateReference:schoolYear::int        as calendar_date_school_year,
        -- section key
        v:sectionReference:localCourseCode::string     as local_course_code,
        v:sectionReference:schoolId::int               as school_id,
        v:sectionReference:schoolYear::int             as school_year,
        v:sectionReference:sectionIdentifier::string   as section_id,
        v:sectionReference:sessionName::string         as session_name,
        -- staff key
        v:staffReference:staffUniqueId::string         as staff_unique_id,
        -- references
        v:calendarDateReference as calendar_date_reference,
        v:sectionReference      as section_reference,
        v:staffReference        as staff_reference

    from section_attendance_taken_events
)
select * from renamed
