with rubric_dimensions as (
    {{ source_edfi3('rubric_dimensions') }}
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

        v:id::string                               as record_guid,
        v:evaluationElementReference:educationOrganizationId::int as ed_org_id,
        v:rubricRating::int         as rubric_rating,
        v:dimensionOrder::int         as dimension_order,
        v:criterionDescription::string         as criterion_description,
        v:rubricRatingLevelDescriptor::string         as rubricRating_level_descriptor,
        --references
        v:evaluationElementReference  as v_evaluation_element
    from rubric_dimensions
)
select * from renamed
