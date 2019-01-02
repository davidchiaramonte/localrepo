view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    # value_format_name added
    value_format_name: usd
    sql: ${TABLE}.cost ;;
  }

  # case statement added
  dimension: item_cost_type {
    case: {
      when: {
        sql: ${cost} > 250 ;;
        label: "Expensive"
      }
      when: {
        sql: ${cost} > 100 ;;
        label: "Moderate"
      }
      else: "Cheap"
    }
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      hour_of_day,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  # yesno dimension added
  dimension: is_product_expensive {
    type: yesno
    sql: ${cost} >= 100 ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
  }
}
