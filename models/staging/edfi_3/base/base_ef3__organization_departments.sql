with organization_departments as (
    {{ source_edfi3('organization_departments') }}
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
        v:parentEducationOrganizationReference:educationOrganizationId::int as ed_org_id,
        v:organizationDepartmentId::int                                     as ed_org_department_id,
        v:nameOfInstitution::int                                            as name_of_institution,
        v:shortNameOfInstitution::int                                       as short_name_of_institution,
        v:webSite::int                                                      as web_site,
        -- descriptors
        {{ extract_descriptor('v:academicSubjectDescriptor::string') }}   as academic_subject,
        {{ extract_descriptor('v:operationalStatusDescriptor::string') }} as operational_status,
        --references
        v:parentEducationOrganizationReference as education_organization,
        -- unflattened lists
        v:categories             as v_categories,
        v:addresses              as v_addresses,
        v:identificationCodes    as v_identification_codes,
        v:indicators             as v_indicators,
        v:institutionTelephones  as v_institution_telephones,
        v:internationalAddresses as v_international_addresses
    from organization_departments
)
select * from renamed
