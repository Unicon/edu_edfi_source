with stage_stu_programs as (
    select * from {{ ref('stg_ef3__student_title_i_part_a_program_associations') }}
),

flattened as (
    select
        tenant_code,
        api_year,
        k_student,
        k_student_xyear,
        k_program,
        k_lea,
        k_school,

        {{ extract_descriptor('value:titleIPartAProgramServiceDescriptor::string') }} as title_i_part_a_program_service,
        value:primaryIndicator::boolean as primary_indicator,
        value:serviceBeginDate::date    as service_begin_date,
        value:serviceEndDate::date      as service_end_date,

        -- edfi extensions
        value:_ext as v_ext

    from stage_stu_programs,
        lateral flatten(input => v_title_i_part_a_program_services)
)

select * from flattened