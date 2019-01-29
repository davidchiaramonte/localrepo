- dashboard: i_looker_performance_dashboard_original
  title: i_looker_performance_dashboard_original
  layout: newspaper
  elements:
  - title: dashboard with refresh interval
    name: dashboard with refresh interval
    model: i__looker
    explore: history
    type: table
    fields:
    - dashboard.title
    - history.real_dash_id
    - dashboard.refresh_interval
    filters:
      dashboard.refresh_interval: "-NULL"
    sorts:
    - dashboard.refresh_interval desc
    limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    row: 12
    col: 3
    width: 11
    height: 5
  - title: Unlimited Downloads
    name: Unlimited Downloads
    model: i__looker
    explore: history
    type: table
    fields:
    - history.created_time
    - query.link
    - user.id
    - user.name
    filters:
      query.limit: "-1"
    sorts:
    - history.created_time desc
    limit: 500
    column_limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    listen: {}
    row: 12
    col: 14
    width: 10
    height: 5
  - title: Long Building PDTs
    name: Long Building PDTs
    model: i__looker
    explore: history
    type: table
    fields:
    - history.message
    - history.created_time
    - history.runtime
    - history.total_runtime
    filters:
      history.created_date: 24 hours
      history.message: Building derived table%
      history.source: Other
      user.is_looker: 'No'
    sorts:
    - history.created_time
    limit: 500
    column_limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    row: 17
    col: 3
    width: 11
    height: 6
  - title: Failed PDT builds
    name: Failed PDT builds
    model: i__looker
    explore: history
    type: table
    fields:
    - history.message
    - history.query_run_count
    filters:
      history.created_date: 24 hours
      history.source: Other
      user.is_looker: 'No'
    sorts:
    - history.message
    limit: 500
    filter_expression: "contains(${history.message}, \"derived_table\")\nAND \ncontains(${history.message},\
      \ \"failed\")"
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
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
    row: 17
    col: 14
    width: 10
    height: 6
  - name: '0'
    type: text
    title_text: ''
    body_text: <font size="6" color="navy">Queries<br>Per<br>Source</font>
    row: 0
    col: 0
    width: 3
    height: 6
  - name: "1"
    type: text
    body_text: <font size="6" color="navy">Queries<br>Per<br>User</font>
    row: 6
    col: 0
    width: 3
    height: 6
  - name: "2"
    type: text
    body_text: <font size="5" color="navy">Dashboard<br>Refresh<br>and<br>Downloads</font>
    row: 12
    col: 0
    width: 3
    height: 5
  - name: "3"
    type: text
    body_text: <font size="6" color="navy">PDTS<br>Details</font>
    row: 17
    col: 0
    width: 3
    height: 6
  - title: query per source -hourly today
    name: query per source -hourly today
    model: i__looker
    explore: history
    type: table
    fields:
    - history.query_run_count
    - history.source
    - history.created_hour_of_day
    pivots:
    - history.source
    filters:
      history.created_date: 1 days
    sorts:
    - history.source 0
    - history.created_hour_of_day
    limit: 500
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
      - history.query_run_count
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    row: 0
    col: 14
    width: 10
    height: 6
  - title: query per user -daily last 7days
    name: query per user -daily last 7days
    model: i__looker
    explore: history
    type: table
    fields:
    - history.query_run_count
    - user.name
    - history.created_day_of_week
    pivots:
    - user.name
    filters:
      history.created_date: 7 days
    sorts:
    - user.name 0
    - history.created_day_of_week
    limit: 500
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    row: 6
    col: 3
    width: 11
    height: 6
  - title: query per source -daily last 7days
    name: query per source -daily last 7days
    model: i__looker
    explore: history
    type: table
    fields:
    - history.query_run_count
    - history.source
    - history.created_day_of_week
    pivots:
    - history.source
    fill_fields:
    - history.created_day_of_week
    filters:
      history.created_date: 7 days
    sorts:
    - history.source 0
    - history.created_day_of_week
    limit: 500
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    row: 0
    col: 3
    width: 11
    height: 6
  - title: query per user -hourly today
    name: query per user -hourly today
    model: i__looker
    explore: history
    type: table
    fields:
    - history.query_run_count
    - user.name
    - history.created_hour_of_day
    pivots:
    - user.name
    filters:
      history.created_date: 1 days
    sorts:
    - user.name 0
    - history.created_hour_of_day
    limit: 500
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
      - history.query_run_count
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    row: 6
    col: 14
    width: 10
    height: 6
