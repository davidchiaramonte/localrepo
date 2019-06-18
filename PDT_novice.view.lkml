view: PDT_novice {
  derived_table: {
    sql: SELECT
        users.id AS "user_id",
        users.email AS "user_email",
        users.first_name AS "user_first",
        users.last_name AS "user_last",
        users.gender AS "gender",
        users.created_at AS "user_created_at",
        users.zip AS "zipcode",
        users.country AS "user_country",
        users.state AS "user_state",
        users.city AS "user_city",
        users.age AS "user_age",
        orders.id AS "order_id",
        orders.created_at AS "orders_created_at",
        orders.user_id AS "orders_user_id",
        orders.status AS "orders_status",
        order_items.id AS "order_items_id",
        order_items.inventory_item_id AS "inventory_item_id",
        order_items.sale_price AS "sale_price"
      FROM users
      LEFT JOIN orders ON orders.user_id = users.id
      LEFT JOIN order_items ON order_items.order_id = orders.id
       ;;
  }

  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${order_id},${order_items_id},${user_id}) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_email {
    type: string
    sql: ${TABLE}.user_email ;;
  }

  dimension: user_first {
    type: string
    sql: ${TABLE}.user_first ;;
  }

  dimension: user_last {
    type: string
    sql: ${TABLE}.user_last ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension_group: user_created_at {
    type: time
    sql: ${TABLE}.user_created_at ;;
  }

  dimension: zipcode {
    type: number
    sql: ${TABLE}.zipcode ;;
  }

  dimension: user_country {
    type: string
    sql: ${TABLE}.user_country ;;
  }

  dimension: user_state {
    type: string
    sql: ${TABLE}.user_state ;;
  }

  dimension: user_city {
    type: string
    sql: ${TABLE}.user_city ;;
  }

  dimension: user_age {
    type: number
    sql: ${TABLE}.user_age ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: orders_created_at {
    type: time
    sql: ${TABLE}.orders_created_at ;;
  }

  dimension: orders_user_id {
    type: number
    sql: ${TABLE}.orders_user_id ;;
  }

  dimension: orders_status {
    type: string
    sql: ${TABLE}.orders_status ;;
  }

  dimension: order_items_id {
    type: number
    sql: ${TABLE}.order_items_id ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  set: detail {
    fields: [
      user_id,
      user_email,
      user_first,
      user_last,
      gender,
      user_created_at_time,
      zipcode,
      user_country,
      user_state,
      user_city,
      user_age,
      order_id,
      orders_created_at_time,
      orders_user_id,
      orders_status,
      order_items_id,
      inventory_item_id,
      sale_price
    ]
  }
}
