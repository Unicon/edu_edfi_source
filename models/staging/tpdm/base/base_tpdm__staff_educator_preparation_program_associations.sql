with
    staff_educator_preparation_program_associations as (
        {{ source_edfi3('staff_educator_preparation_program_associations') }}
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

            v:id::string as record_guid,
            v:begindate::date as begin_date,
            v:enddate::date as end_date,
            -- course offering key
            v:candidatereference:candidateidentifier::integer as candidate_identifier,
            -- location key
            v:educatorpreparationprogramreference:educationorganizationid::integer as classroom_identification_code,
            v:educatorpreparationprogramreference:programname::string as classroom_location_school_id,
            v:educatorpreparationprogramreference:programtypedescriptor::string as classroom_location_school_id,
            -- descriptors
            {{ extract_descriptor('v:eppProgramPathwayDescriptor::string') }} as epp_program_pathway_descriptor,
            {{ extract_descriptor('v:reasonExitedDescriptor::string') }} as reason_exited_descriptor,
            -- references
            v:candidatereference as candidate_reference,
            v:educatorpreparationprogramreference as educator_preparation_program_reference,
            -- lists
            v:cohortyears as v_cohort_years,
            v:degreespecializations as v_degree_specializations

        from staff_educator_preparation_program_associations
    )
select * from renamed
