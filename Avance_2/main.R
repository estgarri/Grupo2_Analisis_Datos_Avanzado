# =====================================================
# main.R — Start
# =====================================================


# Load required packages ----
library(tidyverse)   # includes ggplot2, dplyr, readr, etc.
library(readxl)
library(lubridate)
library(janitor)
library(rstatix)
library(ggpubr)
library(nortest)

# Load config defaults ------
config <- yaml::read_yaml("config.yml")

file_path <- config$default$file_path
sheet     <- config$default$sheet


# 2.Scripts ----
source("R/01_load_clean.R")     
source("R/02_transform.R")      
source("R/03_eda.R")          

# 3. Execute pipeline ----

df_raw <- load_and_clean(file_path = file_path, sheet = sheet)

df <- transform_data(df_raw)

run_eda(df)

cat("\n✅ Pipeline completed successfully.\n")
