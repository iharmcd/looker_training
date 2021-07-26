view: users {
  label: "Customers"
  sql_table_name: "PUBLIC"."USERS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    group_label: "General Info"
    # hidden: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: age {
    group_label: "Ages"
    type: number
    sql: ${TABLE}."AGE" ;;
    drill_fields: [user_groups*, geography*]
  }

  dimension: city {
    group_label: "Geography"
    type: string
    sql: ${TABLE}."CITY" ;;
    drill_fields: [user_groups*, geography*]
  }

  dimension: country {
    group_label: "Geography"
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
    drill_fields: [user_groups*, geography*]
  }

  dimension_group: created {
    type: time
    group_label: "General Info"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: email {
    group_label: "General Info"
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: first_name {
    group_label: "General Info"
    type: string
    sql: ${TABLE}."FIRST_NAME" ;;
  }

  dimension: last_name {
    group_label: "General Info"
    type: string
    sql: ${TABLE}."LAST_NAME" ;;
  }

  dimension: full_name {
    label: "Full Name"
    group_label: "General Info"
    type: string
    sql: ${first_name} || ' ' || ${last_name}  ;;
  }

  dimension: gender {
    group_label: "General Info"
    type: string
    sql: ${TABLE}."GENDER" ;;
    drill_fields: [full_name, user_groups*, geography*]
  }

  dimension: latitude {
    group_label: "Geography"
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: longitude {
    group_label: "Geography"
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: state {
    group_label: "Geography"
    type: string
    map_layer_name: us_states
    sql: ${TABLE}."STATE" ;;
    drill_fields: [city, user_groups*]
  }

  dimension: traffic_source {
    group_label: "General Info"
    type: string
    sql: ${TABLE}."TRAFFIC_SOURCE" ;;
    drill_fields: [user_groups*, geography*]
  }

  dimension: zip {
    group_label: "Geography"
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  dimension: age_tier {
    label: "User Age Bins"
    group_label: "Ages"
    description: "Groups individual ages into age groups."
    type:  tier
    tiers: [18, 25, 35, 45, 55, 65, 75, 90]
    style: integer
    sql: ${age} ;;

  }

  dimension: age_tier_2 {
    label: "User Age Bins 2nd"
    group_label: "Ages"
    description: "Groups individual ages into age groups."
    type:  tier
    tiers: [15, 26, 36, 51, 66]
    style: integer
    sql: ${age} ;;

  }

  dimension: user_term_type {
    group_label: "General Info"
    label: "Customer: New or Long-Term"
    description: "If user was registered within last 90 days. then new"
    type:  string
    sql:
    case when datediff(day, ${created_date}, getdate()) < 90
    then 'New Customer'
    else 'Long-Term Customer'
    end;;
    drill_fields: [user_groups*, geography*]

  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }

  set: user_groups {
    fields: [users.age_tier, users.age_tier_2, users.gender,users.user_term_type, users.full_name, users.age]
  }

  set: geography {
    fields: [country, state, city, zip]
  }
}
