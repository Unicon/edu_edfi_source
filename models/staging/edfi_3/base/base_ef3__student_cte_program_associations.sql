with student_cte_program_associations as (
    {{ source_edfi3('student_cte_program_associations') }}
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

        v:beginDate::date as begin_date,
        v:endDate::date   as end_date,
        v:nonTraditionalGenderStatus::boolean    as is_non_traditional_gender_status,
        v:privateCTEProgram::boolean             as is_private_c_t_e_program,
        v:servedOutsideOfRegularSession::boolean as served_outside_of_regular_session,
        v:participationStatus:participationStatusDescriptor::string as participation_status_descriptor,
        v:participationStatus:designatedBy::string                  as designated_by
        v:participationStatus:statusBeginDate::date                 as status_begin_date
        v:participationStatus:statusEndDate::date                   as status_end_date,
        v:studentReference:studentUniqueId::string                  as student_unique_id,
        v:educationOrganizationReference:educationOrganizationId::integer as education_organization_id,
        v:programReference:educationOrganizationId::integer               as education_organization_id
        v:programReference:programName::integer                           as program_name
        v:programReference:programTypeDescriptor::integer                 as program_type_descriptor
        -- descriptor
        {{ extract_descriptor('v:reasonExitedDescriptor::string') }}              as reason_exited,
        {{ extract_descriptor('v:technicalSkillsAssessmentDescriptor::string') }} as technical_skills_assessment,
        -- references
        v:studentReference       as student_reference,
        v:gradingPeriodReference as grading_period_reference,
        -- lists
        v:ctePrograms                  as v_cte_programs,
        v:cteProgramServices           as v_cte_program_services,
        v:studentSectionAssociations   as v_student_section_associations,
        v:programParticipationStatuses as v_programParticipationStatuses
        v:services                     as v_services,

        -- edfi extensions ????
        v:_ext as v_ext

    from student_cte_program_associations
)
select * from renamed
