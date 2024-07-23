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
        v:educationOrganizationReference:educationOrganizationId::int as ed_org_id,
        v:rubricRating::int as rubric_rating,
        --references
        v:educationOrganizationReference as education_organization_reference
        -- unflattened lists
        v:programs as v_programs
        v:reasons  as v_reasons
    from restraint_events
)
select * from renamed
