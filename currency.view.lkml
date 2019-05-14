view: currency_demo
{
  derived_table:
  {
    sql:
      SELECT 10000.00 as val, 'USD' as currency
      UNION ALL
      SELECT 10000.00 as val, 'EUR' as currency
      UNION ALL
      SELECT 10000.00 as val, 'CHF' as currency
      UNION ALL
      SELECT 10000.00 as val, 'JPY' as currency;;
  }

  dimension: currency
  {
    sql: ${TABLE}.currency;;
  }

  dimension: currency_symbol
  {
    hidden: yes
    sql:
        CASE
          WHEN ${currency} = 'USD' THEN '$'
          WHEN ${currency} = 'EUR' THEN '£'
          WHEN ${currency} = 'JPY' THEN '¥'
          ELSE CONCAT(${currency}, ' ')
        END;;
  }

  dimension: formatted_amount
  {
    type: number
    value_format: "0.##"
    order_by_field: usd_amount
    html:
        {{ currency_symbol._value }}{{ rendered_value }};;
    sql: ${TABLE}.val;;
  }

  dimension: usd_amount
  {
    hidden: yes
    type: number
    value_format: "0.##"
    sql:
        CASE
          WHEN ${currency} = 'USD' THEN 1.0 * ${formatted_amount}
          WHEN ${currency} = 'EUR' THEN 1.09 * ${formatted_amount}
          WHEN ${currency} = 'JPY' THEN 0.008 * ${formatted_amount}
          WHEN ${currency} = 'CHF' THEN 1.02 * ${formatted_amount}
          ELSE NULL
        END;;
  }

  measure: count {
    type: count
    html: {% if currency._value == 'EUR' and value <0 %} -€{{val._rendered_value}}       {% elsif currency._value == 'EUR' %} €{{rendered_value}}       {% elsif currency._value == 'USD' and value <0 %} -${{val._rendered_value}}       {% elsif currency._value == 'USD' %} {% endif %} ;;
  }

}

#testy test
#testy test 2
