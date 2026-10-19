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
waterfowl_data_2 <- read_csv ("flyway_species_long.csv.gz")



library(tidyverse)

# Load and tidy your dataset
tidy_waterfowl_data <- read_csv("flyway_species_long.csv.gz") %>%
  # Standardize column names (lowercase, snake_case)
  janitor::clean_names() %>%
  
  # Remove completely empty rows or columns
  remove_empty(c("rows", "cols")) %>%
  
  # Convert species to factor and assign 'period' directly to 'year'
  mutate(
    species = as.factor(species),
    year = period # Since period is already a numeric year
  ) %>%
  
  # Group by state, flyway, species, and year
  group_by(state, flyway, species, year) %>%
  
  # Calculate the total value for each category and year combination
  summarise(
    amount = sum(value, na.rm = TRUE),
    .groups = "drop"
  )
#Save the result as a csv
write_csv(tidy_waterfowl_data, "tidy_waterfowl_data.csv")



#code gives correct table, we need to eliminate Data Book which we think is Canada numbers, under the state column is where this issue is