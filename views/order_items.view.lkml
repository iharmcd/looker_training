view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }


  dimension_group: delivered {
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
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  dimension: inventory_item_id {
    group_label: "Order Info"
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    group_label: "Order Info"
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}."RETURNED_AT" ;;
  }

  dimension: sale_price {
    hidden: yes
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  dimension_group: shipped {
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
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: status {
    group_label: "Order Info"
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    group_label: "Order Info"
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
    group_label: "Counts"
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      inventory_items.product_name,
      inventory_items.id,
      users.last_name,
      users.id,
      users.first_name
    ]
  }

  dimension_group: shipping_duration  {
    label: "Shipping Days"
    description: "number of days between the order ship date and the order delivered date"
    type: duration
    intervals: [day]
    sql_start: ${created_raw} ;;
    sql_end: ${delivered_raw} ;;
  }

  dimension: is_returned {
    label: "Is Order Returned"
    group_label: "Order Info"
    description: "Calculates whether the order was returned or not."
    type:  yesno
    sql: ${status} = 'Returned' ;;
    #sql: ${returned_date} is not null ;;
  }

  dimension: is_order_status_positive {
    label: "Is Order Success"
    group_label: "Order Info"
    description: "Calculates whether the order was returned or not."
    hidden: yes
    type:  yesno
    sql: ${status} not in ('Returned', 'Cancelled') ;;
    #sql: ${returned_date} is not null ;;
  }

  measure: total_sale_price  {
    label: "Total Sale Price"
    group_label: "Revenue"
    description: "Total sales from items sold"
    type:  sum
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: distinct_orders  {
    label: "Distinct Orders Count"
    group_label: "Counts"
    description: "Count number of orders"
    type:  count_distinct
    sql: ${order_id} ;;
    value_format_name: decimal_0
  }

  measure: average_sale_price  {
    label: "Average Sale Price"
    group_label: "Averages"
    description: "Average sale price of items sold"
    type:  average
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: cumulative_total_sales {
    label: "Cumulative Total Sales"
    group_label: "Revenue"
    description: "Cumulative total sales from items sold (running total)"
    type:  running_total
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: total_gross_revenue {
    label: "Total Gross Revenue"
    group_label: "Revenue"
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    type:  sum
    filters: [is_order_status_positive: "yes"]
    #filters: [status: "-Cancelled, -Returned"]
    sql:  ${sale_price} ;;
    value_format_name: usd
  }

  measure: total_cost {
    label: "Total Cost"
    group_label: "Cost"
    description: "Total cost of items sold from inventory"
    type: sum
    sql: ${inventory_items.cost} ;;
    value_format_name: usd

  }

  measure: average_cost {
    label: "Average Cost"
    group_label: "Averages"
    description: "Average cost of items sold from inventory"
    type: average
    sql: ${inventory_items.cost} ;;
    value_format_name: usd

  }

  measure:  total_gross_margin {
    label: "Total Gross Margin Amount"
    group_label: "Margin (Profit)"
    description: "Total difference between the total revenue from completed sales and the cost of the goods that were sold"
    type: sum
    filters: [is_order_status_positive: "yes"]
    sql: ${sale_price} - ${inventory_items.cost}  ;;
    value_format_name: usd

  }

  measure:  average_gross_margin {
    label: "Average Gross Margin"
    group_label: "Averages"
    description: "Average difference between the total revenue from completed sales and the cost of the goods that were sold"
    type: average
    filters: [is_order_status_positive: "yes"]
    sql: ${sale_price} - ${inventory_items.cost}  ;;
    value_format_name: usd

  }

  measure: gross_margin {
    label: "Gross Margin %"
    group_label: "Margin (Profit)"
    description: "Total Gross Margin Amount / Total Gross Revenue"
    type: number
    sql: 1.0 * ${total_gross_margin} / NULLIF(${total_gross_revenue},0) * 100  ;;
    value_format: "0.00\%" # can be changed to percent_2, but remove * 100

  }

  measure: items_returned_amount {
    label: "Number of Items Returned"
    group_label: "Returned Items"
    description: "Number of items that were returned by dissatisfied customers"
    type: count
    filters: [is_returned: "yes"]
    #sql: ${order_id};;
  }

  measure: item_return_rate {
    label: "Item Return Rate"
    group_label: "Returned Items"
    description: "Number of Items Returned / total number of items sold"
    type: number
    sql: ${items_returned_amount} / NULLIF(${count},0);;
    value_format: "0.####"
  }

  measure: users_returning_items {
    label: "Number of Customers Returning Items"
    group_label: "Returned Items"
    description: "Number of users who have returned an item at some point"
    type: count_distinct
    filters: [is_returned: "yes"]
    sql: ${user_id} ;;
  }

  measure: users_with_returns_rate {
    label: "% of Users with Returns"
    group_label: "Returned Items"
    description: "Number of Customer Returning Items / total number of customers"
    type: number
    sql: ${users_returning_items} / NULLIF(${users.count},0) ;;
    value_format_name: percent_2
  }

  measure: average_user_spend {
    label: "Average Spend per Customer"
    group_label: "Averages"
    description: "Total Sale Price / total number of customers"
    type: number
    sql: ${total_sale_price} / NULLIF(${users.count},0) ;;
    value_format_name: usd
    drill_fields: [user_groups*]
  }

  set: user_groups {
    fields: [users.age_tier_2, users.gender,users.user_term_type]
  }

}
