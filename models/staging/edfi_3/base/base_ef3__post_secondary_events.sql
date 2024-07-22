with post_secondary_institutions as (
    {{ source_edfi3('post_secondary_institutions') }}
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

        v:id::string                      as record_guid,
        v:postSecondaryInstitutionId::int as post_secondary_institution_id,
        v:nameOfInstitution::string       as name_of_institution,
        v:shortNameOfInstitution::string  as short_name_of_institution,
        v:webSite::string                 as web_site,
        -- descriptors
        {{ extract_descriptor('v:postSecondaryEventCategoryDescriptor::string')}} as post_secondary_event_category
    from post_secondary_institutions
)
select * from renamed
