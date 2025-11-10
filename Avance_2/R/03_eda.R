# EDA

library(dplyr)
library(ggplot2)
library(yaml)
config <- yaml::read_yaml("config.yml")
plot_dir <- config$paths$plots


run_eda <- function(df) {
  
  # ✅ Top 10 products by units sold
  top_sku_units <- df %>%
    group_by(stock_code, description) %>%
    summarise(units_sold = sum(quantity), .groups = "drop") %>%
    arrange(desc(units_sold)) %>%
    slice_head(n = 10)
  
  print(top_sku_units)
  
  # Plot
  p1 <- ggplot(top_sku_units, aes(x = reorder(description, units_sold), y = units_sold)) +
    geom_col() +
    coord_flip() +
    labs(title = "Top 10 SKUs by Units Sold", x = "Product", y = "Units Sold")
  
  print(p1)
  
  
  # ✅ Top 10 countries by revenue
  top_countries <- df %>%
    group_by(country) %>%
    summarise(total_revenue = sum(total_revenue), .groups = "drop") %>%
    arrange(desc(total_revenue)) %>%
    slice_head(n = 10)
  
  print(top_countries)
  
  p2 <- ggplot(top_countries, aes(x = reorder(country, total_revenue), y = total_revenue)) +
    geom_col() +
    coord_flip() +
    labs(title = "Top 10 Countries by Revenue", x = "Country", y = "Revenue")
  
  print(p2)
  
  
  # ✅ Monthly revenue trend
  monthly_sales <- df %>%
    group_by(invoice_month) %>%
    summarise(monthly_revenue = sum(total_revenue), .groups = "drop")
  
  print(monthly_sales)
  
  p3 <- ggplot(monthly_sales, aes(x = invoice_month, y = monthly_revenue)) +
    geom_line() +
    geom_point() +
    labs(title = "Monthly Sales Trend", x = "Month", y = "Revenue")
  
  print(p3)
  
  
  # Save plots ----
  dir.create(plot_dir, recursive = TRUE, showWarnings = FALSE)
  
  ggsave(file.path(plot_dir, "top_skus_units.png"), p1, width = 10, height = 6, dpi = 150)
  ggsave(file.path(plot_dir, "top_countries_rev.png"), p2, width = 10, height = 6, dpi = 150)
  ggsave(file.path(plot_dir, "monthly_trend.png"), p3, width = 10, height = 6, dpi = 150)
  
  # Return to main.R or Rmd
  return(list(
    top_sku_units = top_sku_units,
    top_countries = top_countries,
    monthly_sales = monthly_sales
  ))
  
}
