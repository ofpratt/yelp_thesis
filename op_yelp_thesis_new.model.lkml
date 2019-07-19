connection: "op_yelp_thesis"

# include all the views
include: "*.view"
include: "//demographic_data/*.view"

datagroup: op_yelp_thesis_new_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: op_yelp_thesis_new_default_datagroup

explore: b {
  sql_always_where: ${category_groups} <> "Other" ;;
  label: "Business Info"
  view_label: "Business Info"
  join: b__hours {
    view_label: "Business Hours"
    sql: LEFT JOIN UNNEST([${b.hours}]) as b__hours ;;
    relationship: one_to_one
  }

  join: b__attributes {
    view_label: "Business Attributes"
    sql: LEFT JOIN UNNEST([${b.attributes}]) as b__attributes ;;
    relationship: one_to_one
  }
}

explore: check_in {}

explore: photo {}

explore: review {
  join: user {
    type: left_outer
    sql_on: ${review.user_id} = ${user.user_id} ;;
    relationship: many_to_one
  }
}

explore: tip {
  join: user {
    type: left_outer
    sql_on: ${tip.user_id} = ${user.user_id} ;;
    relationship: many_to_one
  }
}

explore: sql_runner_query {
  join: self_join {
    from: sql_runner_query
    type: left_outer
    sql_on: ${sql_runner_query.b_business_id} = ${self_join.b_business_id} ;;
    relationship: one_to_one
  }
}

# explore: bq_block_group_facts {}
# explore: bq_logrecno_bg_map {}
# explore: bq_tract_zcta_map {}
# explore: bq_zcta_distances {}

explore: fast_facts {
  from: bq_logrecno_bg_map

  join: block_group_facts {
    from: bq_block_group_facts
    view_label: "Fast Facts"
    sql_on: ${fast_facts.block_group} = ${block_group_facts.logrecno_bg_map_block_group};;
    relationship: one_to_one
  }

  join: tract_zcta_map {
    from: bq_tract_zcta_map
    sql_on: ${fast_facts.geoid11} = ${tract_zcta_map.geoid11};;
    relationship: many_to_one
  }

  join: zcta_distances {
    from: bq_zcta_distances
    sql_on: ${tract_zcta_map.ZCTA5} = ${zcta_distances.zip2} ;;
    relationship: one_to_one
    required_joins: [tract_zcta_map]
  }
}

explore: user {
  sql_always_where: ${b.is_open} = 1 AND ${b.category_groups} <> "Other";;
  join: review {
    type: left_outer
    sql_on: ${user.user_id} = ${review.user_id};;
    relationship: one_to_many
  }
  join: b {
    view_label: "Business Info"
    type: left_outer
    sql_on:  ${review.business_id} = ${b.business_id} ;;
    relationship: many_to_one
  }
  join: location_derived_table {
    type: left_outer
    sql_on: ${b.city} = ${location_derived_table.b_city};;
    relationship: many_to_one
  }
  join: tip {
    type: left_outer
    sql_on: ${user.user_id} = ${tip.user_id} ;;
    relationship: one_to_many
  }

}
