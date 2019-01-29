connection: "thelook"

# include all the views
include: "*.view"

include: "*.dashboard"

datagroup: building_a_local_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: building_a_local_model_default_datagroup

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: orders {
    type: left_outer
    sql_on: ${users.id} = ${orders.user_id} ;;
    relationship: one_to_many
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: orders {
    type: left_outer
    sql_on: ${users.id} = ${orders.user_id} ;;
    relationship: one_to_many
  }
}

explore: users {
  join: orders {
    type: left_outer
    sql_on: ${users.id} = ${orders.user_id} ;;
    relationship: one_to_many
  }
}

explore: users_nn {
  view_label: "What even is this? users_nn"
}

explore: recent_users {
  from: users
  sql_always_where: ${created_year} =  year(current_date);;
  join: orders {
    type: left_outer
    sql_on: ${recent_users.id} = ${orders.user_id} ;;
    relationship: one_to_many
  }
}

explore: recent_orders {
  from:  orders
  always_filter: {
    filters: {
      field: created_date
      value: "1 year"
    }
  }
}

explore: currency_demo {}
