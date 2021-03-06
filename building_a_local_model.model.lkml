connection: "thelook"

# include all the views
include: "*.view"
include: "my.explore.lkml"
include: "*.dashboard"

datagroup: building_a_local_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: building_a_local_model_default_datagroup

#Adding a Model Label can group explores into one, single list
#label: "Test 1"

explore: my_awesome_explore1 {
  extends: [my_awesome_explore]
}

explore: events {
  fields: [-orders.id]
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
#   Adding a -view_name.field_name doesn't affect joins
#   fields: [ALL_FIELDS*,-orders.id]
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
# Adding a view label with a space has it appear first in the field picker
#view_label: " Users"
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
