with staff_cohort_associations as (
    {{ source_edfi3('staff_cohort_associations') }}
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

        v:id::string                                         as record_guid,
        v:beginDate::date                                    as begin_date,
        v:endDate::date                                      as end_date,
        v:studentRecordAccess::boolean                       as student_record_access,
        v:staffReference:staffUniqueId::integer              as staff_unique_id,
        v:cohortReference:cohortIdentifier::string           as cohort_dentifier,
        v:cohortReference:educationOrganizationId::integer   as education_organization_id,
        -- references
        v:cohortReference as cohort_reference,
        v:staffReference as staff_reference

    from staff_cohort_associations
)
select * from renamed
