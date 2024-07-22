with staff_discipline_incident_associations as (
    {{ source_edfi3('staff_discipline_incident_associations') }}
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

        v:id::string                                                                                 as record_guid,
        v:disciplineIncidentParticipationCodes:disciplineIncidentParticipationCodeDescriptor::string as discipline_incident_participation_code_descriptor,
        v:staffReference:staffUniqueId::integer                                                      as staff_unique_id,
        v:disciplineIncidentReference:incidentIdentifier::string                                     as incident_identifier,
        v:disciplineIncidentReference:schoolId::integer                                              as school_id,
        -- references
        v:disciplineIncidentReference as discipline_incident_reference,
        v:staffReference              as staff_reference

    from staff_discipline_incident_associations
)
select * from renamed
