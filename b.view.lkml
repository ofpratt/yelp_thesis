view: b {
  sql_table_name: yelp_data.b ;;

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: attributes {
    hidden: yes
    sql: ${TABLE}.attributes ;;
  }

  dimension: business_id {
    primary_key:  yes
    type: string
    sql: ${TABLE}.business_id ;;
  }


  dimension: categories {
    type: string
    sql: ${TABLE}.categories ;;
  }

  dimension: category_groups {
    type: string
    sql: case
    when ${categories} like "%Auto Repair%" then "Automobile"
    when ${categories} like "%Food%" then "Restaurant"
    when ${categories} like "%Pool%" then "Pool/Hot Tub Services"
    when ${categories} like "%Massage%" then "Spa"
    when ${categories} like "%Beauty%" then "Beauty"
    when ${categories} like "%Bars%" then "Bars"
    when ${categories} like "%Clothing%Fashion%Shopping%" then "Shopping"
    when ${categories} like "%Lawyers%" then "Lawyers"
    when ${categories} like "%Party%" then "Nightlife"
    when ${categories} like "%Cafe%" then "Cafe"
    when ${categories} like "%Cannabis%" then "Dispensary"
    when ${categories} like "%Amusement Parks%" then "Amusement Parks"
    when ${categories} like "%Active Life%" then "Outdoors"
    when ${categories} like "%Fast Food%" then "Fast Food"
    when ${categories} like "%Vape Shops%" then "Vape Shops"
    when ${categories} like "%Prof%" then "Professional Services"
    when ${categories} like "%Art%" then "Art Gallery"
    when ${categories} like "%Accountants%" then "Financial Services"
    when ${categories} like "%Real Estate%" then "Real Estate"
    when ${categories} like "%Health%" then "Health"
    when ${categories} like "%Home Services%" then "Home Services"
    when ${categories} like "%Hotels%" then "Hotels"
    when ${categories} like "%Accessories%" then "Jewlery"


    else "Other" end;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    drill_fields: [category_groups]
  }

dimension: states_map_layer{
  map_layer_name: us_states
  sql: ${state} ;;
}

  dimension: hours {
    hidden: yes
    sql: ${TABLE}.hours ;;
  }

  dimension: is_open {
    type: number
    sql: ${TABLE}.is_open ;;
  }

  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    hidden:  yes
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: business_location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

measure: avg_lat {
  type: average
  sql: ${latitude} ;;
}

measure: avg_long {
  type: average
  sql: ${longitude} ;;
}

  dimension: postal_code {
    type: number
    sql: ${TABLE}.postal_code ;;
  }

  measure: count_unique_business {
    type: count_distinct
    sql: ${name} ;;
    drill_fields: [name,address,category_groups,stars]
  }

  dimension: postal_map_test {
    type: zipcode
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${postal_code} ;;
  }

dimension: zipcode_tier {
  type: tier
  tiers: [10000,20000,30000,40000,50000,60000,70000,80000,90000,99999]
  style: integer
  sql: safe_cast(${postal_code} as float64) ;;
}

  dimension: review_count {
    type: number
    sql: ${TABLE}.review_count ;;
  }

  measure: review_average {
    type: average
    sql: ${review_count} ;;
    value_format_name: decimal_0
  }

# dimension: us_regions {
#   type: string
#   sql: case
#   when ${zipcode_tier} = 'Below 10000' then 'North Eastern'
#   else 'no';;
# }

  dimension: stars {
    type: number
    sql: ${TABLE}.stars ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: business_count {
    type: count
    drill_fields: [name]
  }
}

view: b__hours {
  dimension: friday {
    type: string
    sql: ${TABLE}.Friday ;;
  }

  dimension: monday {
    type: string
    sql: ${TABLE}.Monday ;;
  }

  dimension: saturday {
    type: string
    sql: ${TABLE}.Saturday ;;
  }

  dimension: sunday {
    type: string
    sql: ${TABLE}.Sunday ;;
  }

  dimension: thursday {
    type: string
    sql: ${TABLE}.Thursday ;;
  }

  dimension: tuesday {
    type: string
    sql: ${TABLE}.Tuesday ;;
  }

  dimension: wednesday {
    type: string
    sql: ${TABLE}.Wednesday ;;
  }
}

view: b__attributes {
  dimension: accepts_insurance {
    type: yesno
    sql: ${TABLE}.AcceptsInsurance ;;
  }

  dimension: ages_allowed {
    type: string
    sql: ${TABLE}.AgesAllowed ;;
  }

  dimension: alcohol {
    type: string
    sql: ${TABLE}.Alcohol ;;
  }

  dimension: ambience {
    type: string
    sql: ${TABLE}.Ambience ;;
  }

  dimension: best_nights {
    type: string
    sql: ${TABLE}.BestNights ;;
  }

  dimension: bike_parking {
    type: string
    sql: ${TABLE}.BikeParking ;;
  }

  dimension: business_accepts_bitcoin {
    type: yesno
    sql: ${TABLE}.BusinessAcceptsBitcoin ;;
  }

  dimension: business_accepts_credit_cards {
    type: string
    sql: ${TABLE}.BusinessAcceptsCreditCards ;;
  }

  dimension: business_parking {
    type: string
    sql: ${TABLE}.BusinessParking ;;
  }

  dimension: by_appointment_only {
    type: string
    sql: ${TABLE}.ByAppointmentOnly ;;
  }

  dimension: byob {
    type: yesno
    sql: ${TABLE}.BYOB ;;
  }

  dimension: byobcorkage {
    type: string
    sql: ${TABLE}.BYOBCorkage ;;
  }

  dimension: caters {
    type: yesno
    sql: ${TABLE}.Caters ;;
  }

  dimension: coat_check {
    type: yesno
    sql: ${TABLE}.CoatCheck ;;
  }

  dimension: corkage {
    type: yesno
    sql: ${TABLE}.Corkage ;;
  }

  dimension: dogs_allowed {
    type: yesno
    sql: ${TABLE}.DogsAllowed ;;
  }

  dimension: drive_thru {
    type: yesno
    sql: ${TABLE}.DriveThru ;;
  }

  dimension: good_for_dancing {
    type: yesno
    sql: ${TABLE}.GoodForDancing ;;
  }

  dimension: good_for_kids {
    type: yesno
    sql: ${TABLE}.GoodForKids ;;
  }

  dimension: good_for_meal {
    type: string
    sql: ${TABLE}.GoodForMeal ;;
  }

  dimension: hair_specializes_in {
    type: string
    sql: ${TABLE}.HairSpecializesIn ;;
  }

  dimension: happy_hour {
    type: yesno
    sql: ${TABLE}.HappyHour ;;
  }

  dimension: has_tv {
    type: yesno
    sql: ${TABLE}.HasTV ;;
  }

  dimension: music {
    type: string
    sql: ${TABLE}.Music ;;
  }

  dimension: noise_level {
    type: string
    sql: ${TABLE}.NoiseLevel ;;
  }

  dimension: outdoor_seating {
    type: yesno
    sql: ${TABLE}.OutdoorSeating ;;
  }

  dimension: restaurants_attire {
    type: string
    sql: ${TABLE}.RestaurantsAttire ;;
  }

  dimension: restaurants_delivery {
    type: yesno
    sql: ${TABLE}.RestaurantsDelivery ;;
  }

  dimension: restaurants_good_for_groups {
    type: yesno
    sql: ${TABLE}.RestaurantsGoodForGroups ;;
  }

  dimension: restaurants_price_range2 {
    type: number
    sql: ${TABLE}.RestaurantsPriceRange2 ;;
  }

  dimension: restaurants_reservations {
    type: yesno
    sql: ${TABLE}.RestaurantsReservations ;;
  }

  dimension: restaurants_table_service {
    type: yesno
    sql: ${TABLE}.RestaurantsTableService ;;
  }

  dimension: restaurants_take_out {
    type: yesno
    sql: ${TABLE}.RestaurantsTakeOut ;;
  }

  dimension: smoking {
    type: string
    sql: ${TABLE}.Smoking ;;
  }

  dimension: wheelchair_accessible {
    type: yesno
    sql: ${TABLE}.WheelchairAccessible ;;
  }

  dimension: wi_fi {
    type: string
    sql: ${TABLE}.WiFi ;;
  }
}
