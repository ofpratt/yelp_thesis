view: review {
  sql_table_name: yelp_data.Review ;;

  dimension: review_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.review_id ;;
  }

  dimension: business_id {
    type: string
    sql: ${TABLE}.business_id ;;
  }

  dimension: cool {
    description: "Number of 'Cool' votes on review"
    type: number
    sql: ${TABLE}.cool ;;
  }

  measure: star_avg{
    type: average
    sql: ${stars};;
    value_format: "0.##"
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }

  dimension: funny {
    description: "Number of 'Funny' votes on review"
    type: number
    sql: ${TABLE}.funny ;;
  }

  dimension: stars {
    type: number
    sql: ${TABLE}.stars ;;
  }

  dimension: text {
    description: "The review itself"
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: useful {
    description: "Number of 'Useful' votes on review"
    type: number
    sql: ${TABLE}.useful ;;
  }

  dimension: user_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [review_id, user.user_id, user.name]
  }
}
