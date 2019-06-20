view: location_derived_table {
  derived_table: {
    sql: SELECT
        b.city  AS b_city,
        AVG(b.latitude ) AS b_avg_lat,
        AVG(b.longitude ) AS b_avg_long
      FROM yelp_data.b  AS b

      GROUP BY 1
      ORDER BY 1 DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: b_city {
    type: string
    sql: ${TABLE}.b_city ;;
  }

  dimension: b_avg_lat {
    type: number
    sql: ${TABLE}.b_avg_lat ;;
  }

  dimension: b_avg_long {
    type: number
    sql: ${TABLE}.b_avg_long ;;
  }

  dimension: location_data {
    type: location
    sql_latitude: ${b_avg_lat} ;;
    sql_longitude: ${b_avg_long} ;;
  }

  set: detail {
    fields: [b_city, b_avg_lat, b_avg_long]
  }
}
