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

dimension: percent_of_total {
  type: string
  sql:
    CASE WHEN {% parameter Category %} = 'Restaurant' THEN {% parameter Category %}
    when {% parameter Category %} = 'Bars' THEN {% parameter Category %}
    when {% parameter Category %} = 'Art Gallery' THEN {% parameter Category %}
    when {% parameter Category %} = 'Automobile' THEN {% parameter Category %}
    when {% parameter Category %} = 'Pool/Hot Tub Services' THEN {% parameter Category %}
    when {% parameter Category %} = 'Beauty' THEN {% parameter Category %}
    when {% parameter Category %} = 'Lawyers' THEN {% parameter Category %}
    when {% parameter Category %} = 'Nightlife' THEN {% parameter Category %}
    when {% parameter Category %} = 'Cafe' THEN {% parameter Category %}
    when {% parameter Category %} = 'Dispensary' THEN {% parameter Category %}
    when {% parameter Category %} = 'Amusement Parks' THEN {% parameter Category %}
    when {% parameter Category %} = 'Outdoors' THEN {% parameter Category %}
    when {% parameter Category %} = 'Fast Food' THEN {% parameter Category %}
    when {% parameter Category %} = 'Vape Shops' THEN {% parameter Category %}
    when {% parameter Category %} = 'Professional Services' THEN {% parameter Category %}
    when {% parameter Category %} = 'Financial Services' THEN {% parameter Category %}
    when {% parameter Category %} = 'Real Estate' THEN {% parameter Category %}
    when {% parameter Category %} = 'Health' THEN {% parameter Category %}
    when {% parameter Category %} = 'Home Services' THEN {% parameter Category %}
    when {% parameter Category %} = 'Hotels' THEN {% parameter Category %}
    when {% parameter Category %} = 'Jewlery' THEN {% parameter Category %}
    when {% parameter Category %} = 'Spa' THEN {% parameter Category %}

    ELSE "Other"
    end
  ;;
}

parameter: Category {
  type: string
  allowed_value: { value: "Restaurant" }
  allowed_value: { value: "Bars" }
  allowed_value: { value: "Art Gallery" }
  allowed_value: { value: "Automobile" }
  allowed_value: { value: "Pool/Hot Tub Services" }
  allowed_value: { value: "Beauty" }
  allowed_value: { value: "Lawyers" }
  allowed_value: { value: "Nightlife" }
  allowed_value: { value: "Cafe" }
  allowed_value: { value: "Dispensary" }
  allowed_value: { value: "Amusement Parks" }
  allowed_value: { value: "Outdoors" }
  allowed_value: { value: "Fast Food" }
  allowed_value: { value: "Vape Shops" }
  allowed_value: { value: "Professional Services" }
  allowed_value: { value: "Financial Services" }
  allowed_value: { value: "Real Estate" }
  allowed_value: { value: "Health" }
  allowed_value: { value: "Home Services" }
  allowed_value: { value: "Hotels" }
  allowed_value: { value: "Jewlery" }
  allowed_value: { value: "Spa" }
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
