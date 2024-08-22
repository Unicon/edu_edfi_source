with open_staff_positions as (
    {{ source_edfi3('open_staff_positions') }}
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

        v:id::string                                                  as record_guid,
        v:educationOrganizationReference:educationOrganizationId::int as ed_org_id,
        v:positionTitle::string                                       as position_title,
        v:requisitionNumber::string                                   as requisition_number,
        v:datePosted::date                                            as date_posted,
        v:datePostingRemoved::date                                    as date_posting_removed,
        case
            when array_size(v:academicSubjects) > 1
                then False
            else True
        end                                                           as is_single_subject_identifier,
        -- descriptors
        {{ extract_descriptor('v:employmentStatusDescriptor::string') }}    as employment_status,
        {{ extract_descriptor('v:staffClassificationDescriptor::string') }} as staff_classification,
        {{ extract_descriptor('v:programAssignmentDescriptor::string') }}   as program_assignment,
        {{ extract_descriptor('v:postingResultDescriptor::string') }}       as posting_result,
        -- references
        v:educationOrganizationReference as education_organization,
        -- unflattened lists
        v:academicSubjects         as v_academic_subjects,
        v:instructionalGradeLevels as v_instructional_grade_levels
    from open_staff_positions
)
select * from renamed
