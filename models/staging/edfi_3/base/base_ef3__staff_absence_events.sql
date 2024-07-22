with staff_absence_events as (
    {{ source_edfi3('staff_absence_events') }}
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

        v:id::string                                  as record_guid,
        v:eventDate::date                             as event_date,
        v:absenceEventReason::string                  as absence_event_reason,
        v:hoursAbsent::integer                        as hours_absent,
        v:staffReference:staffUniqueId::integer       as staff_unique_id,
        -- descriptors
        {{ extract_descriptor('v:absenceEventCategoryDescriptor::string') }} as absence_event_category,
        -- references
        v:staffReference as school_reference

    from staff_absence_events
)
select * from renamed
