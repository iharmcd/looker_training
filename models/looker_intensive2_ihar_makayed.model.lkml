connection: "snowlooker"

# include all the views
include: "/views/**/*.view"

datagroup: looker_intensive2_ihar_makayed_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: looker_intensive2_ihar_makayed_default_datagroup

# explore: distribution_centers {}

# explore: etl_jobs {}

# explore: events {
#   join: users {
#     type: left_outer
#     sql_on: ${events.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: inventory_items {
#   join: products {
#     type: left_outer
#     sql_on: ${inventory_items.product_id} = ${products.id} ;;
#     relationship: many_to_one
#   }

#   join: distribution_centers {
#     type: left_outer
#     sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#     relationship: many_to_one
#   }
# }

explore: order_items {
  label: "Order Items"
  description: "Detailed order information"
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

# explore: products {
#   join: distribution_centers {
#     type: left_outer
#     sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#     relationship: many_to_one
#   }
# }

explore: users {
  label: "Customers"
  description: "Users behavior and attributes."

  join: events {
    type: left_outer
    sql: ${users.id} = ${events.user_id} ;;
    relationship: one_to_many
  }

  join: order_items {
    type: left_outer
    sql: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    type: left_outer
    sql: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

}
