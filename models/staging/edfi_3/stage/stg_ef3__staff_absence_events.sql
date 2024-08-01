with staff_absence_events as (
    select * from {{ ref('base_ef3__staff_absence_events') }}
),
keyed as (
    select
        {{ dbt_utils.surrogate_key(
            [
                'tenant_code',
                'lower(absence_event_category)',
                'lower(survey_identifier)',
                'lower(namespace)',
                'lower(course_code)'
            ]
        ) }} as k_staff_absence_events,
        staff_absence_events.*
        {{ extract_extension(model_name=this.name, flatten=True) }}
    from staff_absence_events
),
deduped as (
    {{
        dbt_utils.deduplicate(
            relation='keyed',
            partition_by='k_staff_absence_events',
            order_by='api_year desc, pull_timestamp desc'
        )
    }}
)
select * from deduped
