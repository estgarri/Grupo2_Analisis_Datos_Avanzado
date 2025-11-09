# EDA

library(dplyr)
library(ggplot2)

run_eda <- function(df) {
  
  # ✅ Top 10 products by units sold
  top_sku_units <- df %>%
    group_by(stock_code, description) %>%
    summarise(units_sold = sum(quantity), .groups = "drop") %>%
    arrange(desc(units_sold)) %>%
    slice_head(n = 10)
  
  print(top_sku_units)
  
  # Plot
  ggplot(top_sku_units, aes(x = reorder(description, units_sold), y = units_sold)) +
    geom_col() +
    coord_flip() +
    labs(title = "Top 10 SKUs by Units Sold", x = "Product", y = "Units Sold")
  
  
  # ✅ Top 10 countries by revenue
  top_countries <- df %>%
    group_by(country) %>%
    summarise(total_revenue = sum(total_revenue), .groups = "drop") %>%
    arrange(desc(total_revenue)) %>%
    slice_head(n = 10)
  
  print(top_countries)
  
  ggplot(top_countries, aes(x = reorder(country, total_revenue), y = total_revenue)) +
    geom_col() +
    coord_flip() +
    labs(title = "Top 10 Countries by Revenue", x = "Country", y = "Revenue")
  
  
  # ✅ Monthly revenue trend
  monthly_sales <- df %>%
    group_by(invoice_month) %>%
    summarise(monthly_revenue = sum(total_revenue), .groups = "drop")
  
  print(monthly_sales)
  
  ggplot(monthly_sales, aes(x = invoice_month, y = monthly_revenue)) +
    geom_line() +
    geom_point() +
    labs(title = "Monthly Sales Trend", x = "Month", y = "Revenue")
  
}
