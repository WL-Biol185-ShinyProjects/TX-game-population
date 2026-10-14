library(tidyverse)
library(janitor)

# Load the CSV file
waterfowl_data <- read_csv("aggregated_waterfowl_harvest_estimates.csv")

# Clean column names (converts to snake_case, removes spaces/special characters)
waterfowl_data <- waterfowl_data %>%
  clean_names()

# Quick look at the structure and first few rows
glimpse(waterfowl_data)
head(waterfowl_data)

View(waterfowl_data)
