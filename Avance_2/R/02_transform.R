# Transform data / Massage

library(dplyr)
library(lubridate)

transform_data <- function(df) {
  
  # === RULE 1: Remove cancelled transactions (InvoiceNo starts with "C") ===
  df <- df %>%
    filter(!grepl("^C", invoice_no))
  
  # === RULE 2: Remove negative quantities (returns/refunds) ===
  df <- df %>%
    filter(quantity > 0)
  
  # === RULE 3: Remove duplicates ===
  df <- df %>%
    distinct()
  
  # === RULE 4: Handle missing values for customer_id ===
  # Keep rows without customer only for global totals, but flag them
  df <- df %>%
    mutate(
      customer_id = ifelse(is.na(customer_id), "UNKNOWN", as.character(customer_id))
    )
  
  # === RULE 5: Create derived variables ===
  df <- df %>%
    mutate(
      unit_price = as.numeric(unit_price),
      total_revenue = quantity * unit_price,
      invoice_month = floor_date(invoice_date, "month"),
      invoice_quarter = paste0("Q", quarter(invoice_date), " ", year(invoice_date))
    )
  
  glimpse(df)
  return(df)
}
