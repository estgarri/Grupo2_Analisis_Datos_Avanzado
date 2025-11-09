# =====================================================
# main.R — Start
# =====================================================


# 1. Load packages ----
library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(ggplot2)

# 2.Scripts ----
source("R/01_load_clean.R")     
source("R/02_transform.R")      
source("R/03_eda.R")          

# 3. Execute pipeline ----

df_raw <- load_and_clean()

df <- transform_data(df_raw)

run_eda(df)

cat("\n✅ Pipeline completed successfully.\n")
