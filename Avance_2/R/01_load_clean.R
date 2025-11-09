# 1) Cargar el archivo CSV y limpiar nombres

# Cargar paquetes
library(tidyverse)
library(rstatix)
library(ggpubr)
library(readxl)
library(janitor)
library(dplyr)
library(nortest)

load_and_clean <- function(sheet = "data") {
  
  
  # Validate sheet exists (nice safeguard)
  sheets <- readxl::excel_sheets("Data/dataProyecto-1.xlsx")
  if (!(sheet %in% sheets)) {
    stop(sprintf("Sheet '%s' not found. Available: %s",
                 sheet, paste(sheets, collapse = ", ")))
  }
  
  # Load data (adjust sheet if needed)
  df <- read_excel("Data/dataProyecto-1.xlsx", sheet = sheet) %>%
    clean_names()
  
  # Basic cleaning
  df <- df %>%
    mutate(across(where(is.character), trimws))
  
  glimpse(df)
  return(df)
}
