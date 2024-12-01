here::i_am("Code/Analysis_1/00_clean_data.R")
path_to_data <- here::here("Raw_data", "wastewater_2024-10-28_subset.csv")
wastewater_data <- read.csv(path_to_data, header = TRUE)

library(tidyverse)

# Remove rows with missing values in ptc_15d
wastewater_data <- wastewater_data %>%
  filter(!is.na(ptc_15d))

# Convert date columns to Date type
wastewater_data$date_start <- as.Date(wastewater_data$date_start, format = "%m/%d/%Y")
wastewater_data$date_end <- as.Date(wastewater_data$date_end,  format = "%m/%d/%Y")

# Check quantiles of ptc_15d to understand the distribution
ptc_15d_quantiles <- quantile(wastewater_data$ptc_15d, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE)
# print(ptc_15d_quantiles)

# Identify and filter out outliers in ptc_15d using the IQR method
ptc_15d_iqr <- IQR(wastewater_data$ptc_15d, na.rm = TRUE)
ptc_15d_q1 <- ptc_15d_quantiles[2]
ptc_15d_q3 <- ptc_15d_quantiles[4]

lower_bound <- ptc_15d_q1 - 1.5 * ptc_15d_iqr
upper_bound <- ptc_15d_q3 + 1.5 * ptc_15d_iqr

wastewater_data_filtered <- wastewater_data %>%
  filter(ptc_15d >= lower_bound & ptc_15d <= upper_bound)

saveRDS(
  wastewater_data_filtered, 
  file = here::here("Output/Analysis_1/data_clean.rds")
)
