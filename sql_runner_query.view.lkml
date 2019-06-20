view: sql_runner_query {
  derived_table: {
    sql: SELECT
        user.user_id  AS user_user_id,
        b.business_id  AS b_business_id
      FROM yelp_data.User  AS user
      LEFT JOIN yelp_data.Review  AS review ON user.user_id = review.user_id
      LEFT JOIN yelp_data.b  AS b ON review.business_id = b.business_id

      WHERE b.is_open = 1
      GROUP BY 1,2
      ORDER BY 1
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_user_id {
    type: string
    sql: ${TABLE}.user_user_id ;;
  }

  dimension: b_business_id {
    type: string
    sql: ${TABLE}.b_business_id ;;
  }

  set: detail {
    fields: [user_user_id, b_business_id]
  }
}
