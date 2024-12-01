knitr::opts_chunk$set(echo = TRUE)

here::i_am("Code/Analysis_2/detect_prop_15d_analysis.R")
# Load required libraries
#install.packages("magick")
#install.packages("webshot2")

library(dplyr)
library(readr)
library(knitr)
library(kableExtra)
library(webshot2)
library(magick)



# Set the data path
#data_path <- "C:/Users/grezh/Desktop/wastewater_2024-10-28.csv"
# Load the dataset
#wastewater_data <- read_csv(data_path)


path_to_data <- here::here("raw_data", "wastewater_2024-10-28_subset.csv")
wastewater_data <- read.csv(path_to_data, header = TRUE)


# Preview the data
head(wastewater_data)

# Check for missing values and clean data
cleaned_data <- wastewater_data %>%
  filter(!is.na(detect_prop_15d)) %>%
  group_by(wwtp_jurisdiction) %>%
  summarise(avg_detect_prop = mean(detect_prop_15d, na.rm = TRUE)) %>%
  arrange(desc(avg_detect_prop))

# Preview the cleaned data
head(cleaned_data)

# Extract the top 20 jurisdictions
top_20 <- cleaned_data %>%
  slice_head(n = 20)

# Display the top 20 jurisdictions as a table
top_20_table <- kable(top_20, caption = "Top 20 Jurisdictions with Highest Average Detection Proportions") 

top_20_table

saveRDS(
  top_20_table,
  file = here::here("Output/Analysis_2/table.rds")
)

#%>%   save_kable(here::here("output/Analysis 2/test.png"))

#html_file <- "top_20_table.html"
#save_kable(top_20_table, file = html_file)

#webshot(html_file, here::here("output/Analysis 2/test.png"))

# Save the results to a CSV file
#write_csv(top_20, "C:/Users/grezh/Desktop/top_20_detect_prop.csv")




