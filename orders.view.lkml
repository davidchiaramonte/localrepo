view: orders {
  sql_table_name: demo_db.orders ;;

  parameter: is_order_new {
    type: yesno
  }

  parameter: new_param {
    type: number
    default_value: "234"
  }

  dimension: param_value {
    type: number
    sql: CAST({{ new_param._parameter_value }} as signed) ;;
  }

  dimension: new_param_dim {
    type: string
    sql: {% if new_param._parameter_value == '800' %}
    ${id}
    {% else %}
    NULL
    {% endif %};;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    group_label: "Test1"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      month_num
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: time_since_created {
    type: duration
    sql_start: ${created_raw} ;;
    sql_end: NOW() ;;
    intervals: [year,month,day,hour,minute]
    group_label: "Test2"
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count_formatted {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
    html: {% if orders.status._value == 'complete' and value > 10 %}
    <font color="green">{{ rendered_value }}</font>
    {% else %}
    <font color="black">{{ rendered_value }}</font>
    {% endif %}
    ;;
  }

  measure: count {
    type: count
  }

  measure: distinct_order_count_month {
   type: count_distinct
   sql: ${id} ;;
    label: "Number of Orders in Last Month"
    filters: {
      field: created_month
      value: "1 month"
    }
  }

  measure: distinct_order_count_sixmo {
    type: count_distinct
    sql: ${id} ;;
    label: "Number of Orders in Last 6 Months"
    filters: {
     field: created_month
     value: "6 Months"
   }
  }

  # date filtered measures require dimension group timeframe too i.e. created_date/_month/_hour
  measure: test_count_filters_45_days {
    type: count
    filters: {
      field: created_date
      value: "45 days"
    }
  }

#   Required fields brings in the specified field in the query, but not in the results set.
#   measure: required_fields_test {
#     type: number
#     sql: ${count}/${user_id} ;;
#     required_fields: [users.id]
#   }

  measure: percent_of_orders {
    type: number
    sql: (${distinct_order_count_month}/${distinct_order_count_sixmo}) *100;;
    value_format: "0.00\%"
  }

  #You can filter with any Looker filter expression, even numbers
  measure: count_of_ids_greater_than_900 {
    type: count
    filters: {
      field: id
      value: ">900"
    }
  }

  #Can't filter a measure of type: list
  measure: list_of_order_ids {
    type: list
    list_field: id
  }
}
