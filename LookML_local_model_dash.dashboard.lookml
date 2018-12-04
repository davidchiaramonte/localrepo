- dashboard: lookml_local_model_dash
  title: Lookml Local Model Dash
  layout: newspaper
  elements:
  - title: Users by Zipcode
    name: Users by Zipcode
    model: building_a_local_model
    explore: users
    type: looker_map
    fields:
    - users.count
    - users.zip
    sorts:
    - users.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_latitude: 38.53429085143028
    map_longitude: -99.0439233183861
    map_zoom: 5
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    listen: {}
    row: 0
    col: 0
    width: 10
    height: 9
  - title: Average Dollars per Order
    name: Average Dollars per Order
    model: building_a_local_model
    explore: order_items
    type: single_value
    fields:
    - order_items.average_order_value
    limit: 500
    query_timezone: America/Los_Angeles
    listen: {}
    row: 0
    col: 10
    width: 4
    height: 5
  - title: Largest Single Order
    name: Largest Single Order
    model: building_a_local_model
    explore: order_items
    type: looker_single_record
    fields:
    - order_items.largest_orders
    - users.first_name
    - users.last_name
    - orders.id
    sorts:
    - order_items.largest_orders desc
    limit: 1
    column_limit: 50
    listen: {}
    row: 5
    col: 10
    width: 4
    height: 4
  - title: Orders Created by Month
    name: Orders Created by Month
    model: building_a_local_model
    explore: order_items
    type: looker_area
    fields:
    - orders.count
    - orders.created_month
    fill_fields:
    - orders.created_month
    sorts:
    - orders.created_month desc
    limit: 500
    column_limit: 50
    listen: {}
    row: 0
    col: 14
    width: 10
    height: 9
  - title: Customer % Gender by Age
    name: Customer % Gender by Age
    model: building_a_local_model
    explore: order_items
    type: looker_donut_multiples
    fields:
    - users.age_tier
    - users.count
    - users.gender
    pivots:
    - users.gender
    filters:
      users.count: NOT NULL
    sorts:
    - users.age_tier
    - users.gender
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 9
    col: 14
    width: 10
    height: 12
  - title: Users Created in Past 30 Days
    name: Users Created in Past 30 Days
    model: building_a_local_model
    explore: order_items
    type: looker_bar
    fields:
    - users.count
    - users.created_date
    fill_fields:
    - users.created_date
    filters:
      users.created_date: 30 days
    sorts:
    - users.created_date desc
    limit: 500
    column_limit: 50
    series_types: {}
    listen: {}
    row: 9
    col: 0
    width: 10
    height: 6
  - title: Total Revenue by Gender
    name: Total Revenue by Gender
    model: building_a_local_model
    explore: order_items
    type: looker_pie
    fields:
    - order_items.total_revenue
    - users.gender
    filters:
      orders.created_date: 14 days
    sorts:
    - users.gender
    limit: 500
    column_limit: 50
    series_types: {}
    listen: {}
    row: 9
    col: 10
    width: 4
    height: 6
  - title: Brand Performance
    name: Brand Performance
    model: building_a_local_model
    explore: order_items
    type: looker_column
    fields:
    - products.brand
    - order_items.total_revenue
    sorts:
    - order_items.total_revenue desc
    limit: 500
    column_limit: 50
    series_types: {}
    listen: {}
    row: 21
    col: 0
    width: 24
    height: 7
  - title: Average Dollars per Order by Month
    name: Average Dollars per Order by Month
    model: building_a_local_model
    explore: order_items
    type: looker_line
    fields:
    - order_items.average_dollars_per_sale
    - orders.created_month
    fill_fields:
    - orders.created_month
    sorts:
    - orders.created_month desc
    limit: 500
    column_limit: 50
    series_types: {}
    listen: {}
    row: 15
    col: 0
    width: 14
    height: 6
  - title: Revenue by Total Orders
    name: Revenue by Total Orders
    model: building_a_local_model
    explore: order_items
    type: looker_scatter
    fields:
    - order_items.total_revenue
    - orders.created_date
    - orders.count
    filters:
      orders.created_date: 90 days
      order_items.total_revenue: NOT NULL
    sorts:
    - orders.created_date desc
    limit: 500
    query_timezone: America/Los_Angeles
    hidden_fields:
    - orders.created_date
    series_types: {}
    row: 28
    col: 0
    width: 8
    height: 6
  - title: Percent of Orders by Brand
    name: Percent of Orders by Brand
    model: building_a_local_model
    explore: order_items
    type: looker_timeline
    fields:
    - products.brand
    - orders.distinct_order_count_month
    - orders.distinct_order_count_sixmo
    - orders.percent_of_orders
    filters:
      orders.percent_of_orders: NOT NULL
    sorts:
    - products.brand
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    row: 28
    col: 8
    width: 8
    height: 6
  - title: Funnel Chart
    name: Funnel Chart
    model: building_a_local_model
    explore: order_items
    type: looker_funnel
    fields:
    - users.age_tier
    - users.count
    fill_fields:
    - users.age_tier
    sorts:
    - users.count desc
    limit: 500
    column_limit: 50
    series_types: {}
    row: 28
    col: 16
    width: 8
    height: 6
  - title: "% Orders This Month to Last 6 Mo"
    name: "% Orders This Month to Last 6 Mo"
    model: building_a_local_model
    explore: order_items
    type: liquid_fill_gauge
    fields:
    - orders.distinct_order_count_month
    - orders.distinct_order_count_sixmo
    limit: 500
    dynamic_fields:
    - table_calculation: calculation_1
      label: Calculation 1
      expression: "${orders.distinct_order_count_month}/${orders.distinct_order_count_sixmo}\
        \ *100"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    hidden_fields:
    - orders.distinct_order_count_sixmo
    - orders.distinct_order_count_month
    series_types: {}
    listen: {}
    note_state: collapsed
    note_display: below
    note_text: 1 single percent measure or table calc
    row: 41
    col: 20
    width: 4
    height: 7
  - title: Order Status by Date (2W)
    name: Order Status by Date (2W)
    model: building_a_local_model
    explore: order_items
    type: sankey_diagram
    fields:
    - orders.created_date
    - orders.status
    - orders.count
    filters:
      orders.created_date: 14 days
    sorts:
    - orders.created_date desc
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    row: 34
    col: 0
    width: 12
    height: 7
  - title: Count of Users by Location
    name: Count of Users by Location
    model: building_a_local_model
    explore: order_items
    type: subtotal
    fields:
    - users.country
    - users.state
    - users.city
    - orders.count
    sorts:
    - orders.count desc
    limit: 500
    column_limit: 50
    series_types: {}
    row: 34
    col: 12
    width: 12
    height: 7
  - title: Users Zip by City by State
    name: Users Zip by City by State
    model: building_a_local_model
    explore: order_items
    type: collapsible_tree
    fields:
    - users.state
    - users.city
    - users.zip
    sorts:
    - users.state
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    row: 41
    col: 0
    width: 20
    height: 7
