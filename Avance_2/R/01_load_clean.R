# 1) Cargar el archivo CSV y limpiar nombres

# Cargar paquetes
#library(tidyverse)
#library(rstatix)
#library(ggpubr)
#library(readxl)
#library(janitor)
#library(dplyr)
#library(nortest)

load_and_clean <- function(file_path, sheet) {
  
  
  # Validate sheet exists (nice safeguard)
  sheets <- readxl::excel_sheets(file_path)
  if (!(sheet %in% sheets)) {
    stop(sprintf("Sheet '%s' not found in %s. Available sheets: %s",
                 sheet, file_path, paste(sheets, collapse = ", ")))
  }
  
  # Load data (adjust sheet if needed)
  df <- readxl::read_excel(file_path, sheet = sheet) %>%
    clean_names()
  
  # Basic cleaning
  df <- df %>%
    mutate(across(where(is.character), trimws))
  
  glimpse(df)
  return(df)
}
