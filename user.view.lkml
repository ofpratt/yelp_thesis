view: user {
  sql_table_name: yelp_data.User ;;

  dimension: user_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: average_stars {
    description: "Average star rating on reviews"
    type: number
    sql: ${TABLE}.average_stars ;;
  }

  dimension: compliment_cool {
    description: "number of cool compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_cool ;;
  }

  dimension: compliment_cute {
    description: "number of cute compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_cute ;;
  }

  dimension: compliment_funny {
    description: "number of funny compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_funny ;;
  }

  dimension: compliment_hot {
    description: "number of hot compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_hot ;;
  }

  dimension: compliment_list {
    description: "number of list compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_list ;;
  }

  dimension: compliment_more {
    description: "number of more compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_more ;;
  }

  dimension: compliment_note {
    description: "number of note compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_note ;;
  }

  dimension: compliment_photos {
    description: "number of photo compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_photos ;;
  }

  dimension: compliment_plain {
    description: "number of plain compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_plain ;;
  }

  dimension: compliment_profile {
    description: "number of profile compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_profile ;;
  }

  dimension: compliment_writer {
    description: "number of writer compliments received by the user"
    type: number
    sql: ${TABLE}.compliment_writer ;;
  }

  dimension: cool {
    description: "number of cool votes sent by the user"
    type: number
    sql: ${TABLE}.cool ;;
  }

  dimension: elite {
    description: "Years the user was elite"
    type: number
    sql: ${TABLE}.elite ;;
  }

  dimension: fans {
    description: "Number of fans the user has"
    type: number
    sql: ${TABLE}.fans ;;
  }

  dimension: friends {
    type: string
    sql: ${TABLE}.friends ;;
  }

  dimension: funny {
    description: "number of funny votes sent by the user"
    type: number
    sql: ${TABLE}.funny ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: review_count {
    type: number
    sql: ${TABLE}.review_count ;;
  }

  dimension: useful {
    description: "number of useful votes sent by the user"
    type: number
    sql: ${TABLE}.useful ;;
  }

  dimension_group: yelping_since {
    description: "Date they joined Yelp"
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
    sql: ${TABLE}.yelping_since ;;
  }

  measure: count {
    type: count
    drill_fields: [user_id, name, tip.count, review.count]
  }
}
