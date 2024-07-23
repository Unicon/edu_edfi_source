with evaluations as (
    {{ source_edfi3('evaluations') }}
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
        v:performanceEvaluationReference:educationOrganizationId::int as ed_org_id,
        v:evaluationTitle::string                                     as evaluation_title,
        v:evaluationDescription::string                               as evaluation_description,
        v:minRating::float                                            as min_rating,
        v:maxRating::float                                            as max_rating,
        v:interRaterReliabilityScore::integer                         as inter_rater_reliability_score,
        -- descriptors
        {{ extract_descriptor('v:evaluationTypeDescriptor::string') }} as evaluation_type,
        -- unflattened lists
        v:ratingLevels as v_rating_levels,
        -- references
        v:performanceEvaluationReference as performance_evaluation_reference
    from evaluations
)
select * from renamed