- dashboard: task_4_dashboard
  title: task_4_dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - name: look_ml_1
    title: look_ml_1
    model: looker_intensive2_ihar_makayed
    explore: order_items
    type: single_value
    fields: [users.count, order_items.created_date]
    fill_fields: [order_items.created_date]
    sorts: [order_items.created_date desc]
    limit: 500
    dynamic_fields: [{_kind_hint: measure, table_calculation: progress_to_prev_day,
        _type_hint: number, category: table_calculation, expression: "${users.count}\
          \ - offset(${users.count}, 1)", label: progress_to_prev_day, value_format: !!null '',
        value_format_name: !!null ''}]
    filter_expression: "${users.created_date} > add_days(-3, trunc_days(now())) \n\
      AND ${users.created_date} < trunc_days(now())"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    single_value_title: Total Number of New Users Yesterday
    comparison_label: Growth to day before
    conditional_formatting: [{type: less than, value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    row: 0
    col: 0
    width: 8
    height: 6
  - name: look_ml_2
    title: look_ml_2
    model: looker_intensive2_ihar_makayed
    explore: order_items
    type: looker_column
    fields: [order_items.total_gross_revenue, order_items.total_gross_margin, order_items.created_month]
    fill_fields: [order_items.created_month]
    filters:
      order_items.created_date: 12 months
    sorts: [order_items.created_month]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.total_gross_revenue,
            id: order_items.total_gross_revenue, name: Total Gross Revenue}, {axisId: order_items.total_gross_margin,
            id: order_items.total_gross_margin, name: Total Gross Margin Amount}],
        showLabels: true, showValues: true, valueFormat: '0, \K\', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: ''
    hide_legend: false
    label_value_format: "$ 0, \\K\\"
    series_types: {}
    series_colors:
      order_items.total_sale_price: "#72D16D"
      order_items.total_gross_margin: "#592EC2"
      order_items.total_gross_revenue: "#72D16D"
    label_color: [black]
    reference_lines: []
    trend_lines: []
    show_dropoff: true
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Average Spend per Customer over the Past 30 Days
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    row: 0
    col: 8
    width: 16
    height: 6
  - name: look_ml_3
    title: look_ml_3
    model: looker_intensive2_ihar_makayed
    explore: order_items
    type: looker_donut_multiples
    fields: [order_items.total_gross_revenue, users.age_tier_2, users.gender]
    pivots: [users.age_tier_2]
    fill_fields: [users.age_tier_2]
    sorts: [order_items.total_gross_revenue desc 0, users.age_tier_2]
    dynamic_fields: [{_kind_hint: measure, table_calculation: prev_month_users_month_to_date,
        _type_hint: number, category: table_calculation, expression: 'offset(${curr_month_users_month_to_date},-diff_days(${users.created_date},
          add_months(-1, ${users.created_date})))', label: 'Prev Month Users Month-to-date ',
        value_format: !!null '', value_format_name: !!null '', is_disabled: true},
      {_kind_hint: measure, table_calculation: curr_month_users_month_to_date, _type_hint: number,
        category: table_calculation, expression: "sum(offset_list(${users.count},\
          \ 0,\n    diff_days( \n      date(extract_years(${users.created_date}),\n\
          \        extract_months(${users.created_date}),1)\n      ,${users.created_date})+1\n\
          \    )\n  )", label: 'Curr Month Users Month-to-date ', value_format: !!null '',
        value_format_name: !!null '', is_disabled: true}]
    show_value_labels: true
    font_size: '16'
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: Users Amount, orientation: left, series: [{axisId: users.count,
            id: users.count, name: Users}, {axisId: count_users_prior_month, id: count_users_prior_month,
            name: Count users prior month}], showLabels: true, showValues: true, valueFormat: '',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    x_axis_label: ''
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '31'
    hide_legend: false
    legend_position: center
    label_value_format: ".00\\%"
    series_types: {}
    point_style: none
    series_colors:
      order_items.total_sale_price: "#72D16D"
      order_items.total_gross_margin: "#72D16D"
      month_to_date_users_curr_month: "#72D16D"
      curr_month_users_month_to_date: "#72D16D"
    label_density: 25
    label_color: [white]
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    trend_lines: []
    ordering: none
    show_null_labels: false
    column_group_spacing_ratio: 0.5
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Average Spend per Customer over the Past 30 Days
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    hidden_fields: []
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    value_labels: legend
    label_type: labPer
    row: 6
    col: 0
    width: 8
    height: 6
  - name: look_ml_4
    title: look_ml_4
    model: looker_intensive2_ihar_makayed
    explore: order_items
    type: looker_line
    fields: [order_items.total_gross_revenue, order_items.created_year, order_items.created_month_num,
      order_items.created_month_name]
    pivots: [order_items.created_year]
    fill_fields: [order_items.created_year]
    sorts: [order_items.created_year, order_items.created_month_num]
    limit: 500
    filter_expression: trunc_years(${order_items.created_date}) > add_years(-4,trunc_years(now()))
      AND (extract_months(now())) > ${order_items.created_month_num}
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: right
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: Revenue, orientation: left, series: [{axisId: order_items.total_gross_revenue,
            id: 2018 - order_items.total_gross_revenue, name: '2018'}, {axisId: order_items.total_gross_revenue,
            id: 2019 - order_items.total_gross_revenue, name: '2019'}, {axisId: order_items.total_gross_revenue,
            id: 2020 - order_items.total_gross_revenue, name: '2020'}, {axisId: order_items.total_gross_revenue,
            id: 2021 - order_items.total_gross_revenue, name: '2021'}], showLabels: true,
        showValues: true, maxValue: 500000, minValue: 100000, valueFormat: "$ 0, \\\
          K", unpinAxis: true, tickDensity: custom, tickDensityCustom: 21, type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '5'
    font_size: ''
    defaults_version: 1
    hidden_fields: [order_items.created_month_num]
    row: 6
    col: 8
    width: 16
    height: 6
