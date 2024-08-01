with staff_program_associations as (
    {{ source_edfi3('staff_program_associations') }}
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
        v:endDate::date                                         as end_date,
        v:staffReference:staffUniqueId::string                  as staff_unique_id,
        v:programReference:educationOrganizationId::integer     as education_organization_id,
        v:programReference:programName::string                  as program_name,
        v:programReference:programTypeDescriptor::string        as program_type_descriptor,
        v:studentRecordAccess::boolean                          as is_studen_record_access,
        -- references
        v:programReference                                      as program_reference,
        v:staffReference                                        as staff_reference

    from staff_program_associations
)
select * from renamed
