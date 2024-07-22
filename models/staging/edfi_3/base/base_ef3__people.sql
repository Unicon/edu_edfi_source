with post_secondary_events as (
    {{ source_edfi3('post_secondary_events') }}
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

        v:id::string                                                        as record_guid,
        v:postSecondaryInstitutionReference:postSecondaryInstitutionId::int as post_secondary_institution_id,
        v:studentReference:studentUniqueId::int                             as student_unique_id,
        v:eventDate::date                                                   as event_date,
        -- descriptors
        {{ extract_descriptor('v:sourceSystemDescriptor::string') }} as source_system,
        --references
        v:postSecondaryInstitutionReference as post_secondary_institution,
        v:studentReference   as student
    from post_secondary_events
)
select * from renamed