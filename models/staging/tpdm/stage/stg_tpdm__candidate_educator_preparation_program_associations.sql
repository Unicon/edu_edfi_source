with base_candidate_educator_preparation_program_associations as (
    select * from {{ ref('base_tpdm__candidate_educator_preparation_program_associations') }}
    where not is_deleted
),
keyed as (
    select
        {{ dbt_utils.surrogate_key(
            [
                'tenant_code',
                'api_year',
                'begin_date',
                'lower(candidate_id)',
                'ed_org_id',
                'lower(program_name)',
                'lower(program_type)'
            ]
        ) }} as k_candidate_educator_preparation_program_association,
        {{ gen_skey('k_candidate') }},
        {{ gen_skey('k_educator_prep_program') }},
        base_performance_evaluations.*
        {{ extract_extension(model_name=this.name, flatten=True) }}
    from base_candidate_educator_preparation_program_associations
),
deduped as (
    {{
        dbt_utils.deduplicate(
            relation='keyed',
            partition_by='k_candidate_educator_preparation_program_association',
            order_by='pull_timestamp desc'
        )
    }}
)
select * from deduped
