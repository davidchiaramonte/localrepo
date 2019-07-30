view: users {
  sql_table_name: demo_db.users ;;

  parameter: user_info_type {
    type: unquoted
    allowed_value: { label: "State" value: "state" }
    allowed_value: { label: "Age" value: "age" }
    allowed_value: { label: "ID" value: "id" }
    allowed_value: { label: "Last Name" value: "last_name" }
  }

  filter: f_me_up_last_name_test {
    type: string
    sql: {% condition f_me_up_last_name_test %} ${last_name} {% endcondition %} ;;
    suggest_explore: users
    suggest_dimension: last_name
  }

  dimension: user_info {
    type: string
    sql:
    {% if user_info_type._parameter_value == "state" %}
     ${state}
    {% elsif user_info_type._parameter_value == "age" %}
     ${age}
    {% elsif user_info_type._parameter_value == "id" %}
     ${id}
    {% elsif user_info_type._parameter_value == "last_name" %}
     ${last_name}
    {% endif %} ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: id_delete_me_plz {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [15, 25, 35, 45, 55, 65, 75, 85, 95, 105]
    style: integer
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    map_layer_name: us_states
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: most_recent_purchase {
    type: date
    sql: MAX(${orders.created_date}) ;;
    convert_tz: no
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      id2*,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
  set: id2 {
    fields: [
      age,
      email
    ]
  }
}
