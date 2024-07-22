with student_gradebook_entries as (
    {{ source_edfi3('student_gradebook_entries') }}
),

renamed as (
    select
        -- generic columns
        tenant_code,
        api_year,
        pull_timestamp,
        last_modified_timestamp,
        file_row_number,
        filename,
        is_deleted,

        v:id::string                                                      as record_guid,

        v:dateFulfilled::date as date_fulfilled,
        v:diagnosticStatement::string as diagnostic_statement,
        v:letterGradeEarned::string as letter_grade_earned,
        v:numericGradeEarned::integer as numeric_grade_earned,
        v:studentReference:studentUniqueId::string as student_unique_id,

        v:gradebookEntryReference:dateAssigned::date as date_assigned,
        v:gradebookEntryReference:gradebookEntryTitle::string as gradebook_entry_title,
        v:gradebookEntryReference:localCourseCode: string as local_course_code,
        v:gradebookEntryReference:schoolId::integer as school_id,
        v:gradebookEntryReference:schoolYear::integer as school_year,
        v:gradebookEntryReference:sectionIdentifier::string as section_identifier,
        v:gradebookEntryReference:sessionName::string as session_name,

        v:studentSectionAssociationReference:sessionName::string as session_name,
        v:studentSectionAssociationReference:beginDate::date as begin_date,
        v:studentSectionAssociationReference:localCourseCode::string as local_course_code,
        v:studentSectionAssociationReference:schoolId::integer as school_id,
        v:studentSectionAssociationReference:schoolYear::integer as school_year,
        v:studentSectionAssociationReference:sectionIdentifier::string as section_identifier,
        v:studentSectionAssociationReference:sessionName::string as session_name,
        v:studentSectionAssociationReference:studentUniqueId::string as student_unique_id,

        -- descriptors
        {{ extract_descriptor('v:competencyLevelDescriptor::string') }} as competency_level,

        -- references
        v:educationOrganizationReference as education_organization_reference,
        v:studentReference               as student_reference,

        -- edfi extensions
        v:_ext as v_ext

    from source_stu_responsibility
)

select * from renamed
