with restraint_events as (
    {{ source_edfi3('restraint_events') }}
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

        v:id::string                               as record_guid,
        v:restraintEventIdentifier::string         as record_guid,
        v:schoolReference:schoolId::int            as school_id,
        v:studentReference:studentUniqueId::string as student_unique_id,
        v:eventDate::date                          as event_date,
        -- descriptors
        {{ extract_descriptor('v:educationalEnvironmentDescriptor::string')}} as educational_environment,
        -- references
        v:schoolReference  as school
        v:studentReference as student
        -- unflattened lists
        v:programs as v_programs
        v:reasons  as v_reasons
    from restraint_events
)
select * from renamed
