with base_survey_course_associations as (
    select * from {{ ref('base_ef3__survey_course_associations') }}
    where not is_deleted
),
keyed as (
    select
        {{ gen_skey('k_survey') }},
        {{ gen_skey('k_course') }},
        {{ dbt_utils.surrogate_key(
            [
                'tenant_code',
                'lower(education_organization_id)',
                'lower(event_date)'
            ]
        ) }} as k_survey_course_associations,
        base_survey_course_associations.*
        {{ extract_extension(model_name=this.name, flatten=True) }}
    from base_survey_course_associations
),
deduped as (
    {{
        dbt_utils.deduplicate(
            relation='keyed',
            partition_by='k_survey, k_course, entry_date, k_survey_course_associations',
            order_by='pull_timestamp desc'
        )
    }}
)
select * from deduped
