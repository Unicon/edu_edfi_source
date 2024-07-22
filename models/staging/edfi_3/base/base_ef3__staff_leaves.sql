with staff_leaves as (
    {{ source_edfi3('staff_leaves') }}
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

        v:id::string                                            as record_guid,
        v:beginDate::date                                       as begin_date,
        v:staffReference:staffUniqueId::string                  as staff_unique_id,
        v:endDate::date                                         as end_date,
        v:reason::string                                        as reason,
        v:substituteAssigned::boolean                           as is_substitute_assigned,
        -- descriptors
        {{ extract_descriptor('v:staffLeaveEventCategoryDescriptor') }} as staff_leave_event_ñategory,
        -- references
        v:staffReference                                        as staff_reference

    from staff_leaves
)
select * from renamed
