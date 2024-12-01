here::i_am("Code/Analysis_1/01_make_table.R")
options(repos = c(CRAN = "https://cloud.r-project.org/"))
wastewater_data_filtered <- readRDS(
  file = here::here("output/Analysis_1/data_clean.rds")
)
install.packages("dplyr")

library(dplyr)

# Group by state and calculate the average change in "ptc_15d" per state
avg_change_per_state <- wastewater_data_filtered %>%
  group_by(wwtp_jurisdiction) %>%
  summarise(avg_change_ptc_15d = mean(ptc_15d, na.rm = TRUE))

# Rename columns for clarity
colnames(avg_change_per_state) <- c("State", "Average_Change_in_ptc_15d")

saveRDS(
  avg_change_per_state,
  file = here::here("Output/Analysis_1/table.rds")
)
