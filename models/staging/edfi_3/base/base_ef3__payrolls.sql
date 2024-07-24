with payrolls as (
    {{ source_edfi3('payrolls') }}
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

        v:id::string                                    as record_guid,
        v:accountReference:educationOrganizationId::int as ed_org_id,
        v:accountReference:accountIdentifier::string    as account_id,
        v:staffReference:staffUniqueId::string          as staff_unique_id,
        v:asOfDate::date                                as as_of_date,
        v:amountToDate::int                             as amount_to_date,
        -- references
        v:accountReference as account,
        v:staffReference   as staff
    from payrolls
)
select * from renamed
