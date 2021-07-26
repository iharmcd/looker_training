view: products {
  sql_table_name: "PUBLIC"."PRODUCTS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
    drill_fields: [category]
    link: {
      label: "Google"
      url: "https://www.google.com/search?q={{value}}"
      icon_url: "https://img.icons8.com/color/16/000000/google-logo.png"
    }
    link: {
      label: "Facebook"
      url: "https://www.facebook.com/search?query={{value}}"
      icon_url: "https://facebookbrand.com/wp-content/uploads/2019/04/f_logo_RGB-Hex-Blue_512.png?w=16&h=16"
    }
  }

  dimension: brand_urls {
    type: string
    sql: ${TABLE}."BRAND" ;;
    # drill_fields: [category]
    html:

    <p>
    <span style='font-size:16px;'>{{value}}<span>
    <a href = 'https://www.facebook.com/search?query={{value}} target='_blank''>
    <img src ='https://facebookbrand.com/wp-content/uploads/2019/04/f_logo_RGB-Hex-Blue_512.png?w=16&h=16' alt = 'FB' /></a>
    <a href = 'https://www.google.com/search?q={{value}}' target='_blank'>
    <img src ='https://img.icons8.com/color/16/000000/google-logo.png' alt = 'G' />
    </a></p>
    ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}."DEPARTMENT" ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}."RETAIL_PRICE" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}."SKU" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.id, distribution_centers.name, inventory_items.count]
  }
}
