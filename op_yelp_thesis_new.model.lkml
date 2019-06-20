connection: "op_yelp_thesis"

# include all the views
include: "*.view"

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



explore: user {
  sql_always_where: ${b.is_open} = 1 ;;
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
