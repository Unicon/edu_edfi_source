with staff_education_organization_contact_associations as (
    {{ source_edfi3('staff_education_organization_contact_associations') }}
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

        v:id::string                     as record_guid,
        v:contactTitle::string           as contact_title,
        v:contactTypeDescriptor::string  as contact_type_descriptor,
        v:electronicMailAddress::string  as electronic_mail_address,

        v:address:addressTypeDescriptor::string         as address_type_descriptor,
        v:address:localeDescriptor::string              as address_locale_descriptor,
        v:address:stateAbbreviationDescriptor::string   as address_state_abbreviation_descriptor,
        v:address:apartmentRoomSuiteNumber::string      as address_apartment_room_suite_number,
        v:address:buildingSiteNumber::string            as address_building_site_number,
        v:address:city::string                          as address_city,
        v:address:congressionalDistrict::string         as address_congressional_district,
        v:address:countyFIPSCode::string                as address_county_fips_code,
        v:address:doNotPublishIndicator::boolean        as is_address_do_not_publish_indicator,
        v:address:latitude::string                      as address_latitude,
        v:address:longitude::string                     as address_longitude,
        v:address:nameOfCounty::string                  as address_name_of_county,
        v:address:postalCode::string                    as address_postal_code,
        v:address:streetNumberName::string              as address_street_number_name,

        v:educationOrganizationReference:educationOrganizationId::integer as ed_org_id,
        v:staffReference:staffUniqueId::integer                           as staff_unique_id,
        -- lists
        v:telephones      as v_telephones,
        v:address:periods as v_address_periods,

        -- references
        v:educationOrganizationReference as educationOrganizationReference,
        v:staffReference as staff_reference

    from sessions
)
select * from renamed



    "address": {
      "addressTypeDescriptor": "string",
      "localeDescriptor": "string",
      "": "string",
      "": "string",
      "": "string",
      "": "string",
      "": "string",
      "": "string",
      "": true,
      "": "string",
      "": "string",
      "": "string",
      "": "string",
      "": "string",
      "periods": [
        {
          "beginDate": "2024-07-23",
          "endDate": "2024-07-23"
        }
      ]
    },
