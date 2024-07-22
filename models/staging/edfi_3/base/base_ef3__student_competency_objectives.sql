with student_competency_objectives as (
    {{ source_edfi3('student_competency_objectives') }}
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
        v:id::string                                              as record_guid,
        v:diagnosticStatement::string                             as diagnostic_statement,
        v:studentReference:studentUniqueId::string                as student_unique_id,
        v:gradingPeriodReference:gradingPeriodDescriptor::integer as grading_period_descriptor,
        v:gradingPeriodReference:periodSequence::integer          as period_sequence,
        v:gradingPeriodReference:schoolId::integer                as school_id,
        v:gradingPeriodReference:schoolYear::integer              as school_year,

        v:objectiveCompetencyObjectiveReference:educationOrganizationId::integer         as education_organization_id,
        v:objectiveCompetencyObjectiveReference:objective::string                        as objective,
        v:objectiveCompetencyObjectiveReference:objectiveGradeLevelDescriptor::string    as objective_grade_level_descriptor,
        -- descriptors
        {{ extract_descriptor('v:competencyLevelDescriptor::string') }} as competency_level,
        -- references
        v:studentReference        as student_reference,
        v:gradingPeriodReference  as grading_periodR_rference,
        -- lists
        v:generalStudentProgramAssociations as v_general_student_program_associations,
        v:studentSectionAssociations        as v_student_section_associations,

        -- edfi extensions ????
        v:_ext as v_ext

    from student_competency_objectives
)
select * from renamed
