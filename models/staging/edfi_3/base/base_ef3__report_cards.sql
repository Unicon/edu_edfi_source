with report_cards as (
    {{ source_edfi3('report_cards') }}
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
        v:studentReference:studentUniqueId::int                       as student_unique_id,
        v:gpaCumulative::int                                          as gpa_cumulative,
        v:gpaGivenGradingPeriod::int                                  as gpa_given_grading_period,
        v:numberOfDaysAbsent::int                                     as number_of_days_absent,
        v:numberOfDaysInAttendance::int                               as number_of_days_in_attendance,
        v:numberOfDaysTardy::int                                      as number_of_days_tardy,
        -- descriptors
        {{ extract_descriptor('v:postSecondaryEventCategoryDescriptor::string')}} as post_secondary_event_category
        --references
        v:gradingPeriodReference         as grading_period
        v:studentReference               as student
        v:educationOrganizationReference as education_organization_reference
        -- unflattened lists
        v:gradePointAverages          as grade_point_averages,
        v:grades                      as grades,
        v:studentCompetencyObjectives as student_competency_objectives,
        v:studentLearningObjectives   as student_learning_objectives
    from report_cards
)
select * from renamed
