
options(repos = c(CRAN = "https://cloud.r-project.org/"))
here::i_am("Code/Analysis_4/midterm_code.R")

path_to_data <- here::here("Raw_data", "wastewater_2024-10-28_subset.csv")
wastewater_data <- read.csv(path_to_data, header = TRUE)

options(repos = c(CRAN = "https://cloud.r-project.org/"))

install.packages("pacman")
library(pacman)
p_load("tidyverse")
#p_load("lubridate")

# Convert date_end to Date type
wastewater_data$date_end <- as.Date(wastewater_data$date_end)

#creating a new variable for seasons by the end date using months
season_data <- wastewater_data %>%
  mutate(season = case_when(
    month(date_end) %in% c(12, 1, 2) ~ "Winter",
    month(date_end) %in% c(3, 4, 5) ~ "Spring",
    month(date_end) %in% c(6, 7, 8) ~ "Summer",
    month(date_end) %in% c(9, 10, 11) ~ "Fall"
  ))

#Grouping data by seasons
seasonal_data <- season_data %>%
  group_by(season) %>%
  summarise(avg_detect_prop_15d = mean(detect_prop_15d, na.rm = TRUE))


# Plot for each season with consistent y-axis limits
p<- ggplot(seasonal_data, aes(x = season, y = avg_detect_prop_15d)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  theme_minimal() +
  labs(title = "Average detect_prop_15d by Season",
       x = "Season",
       y = "Average detect_prop_15d") +
  ylim(0, 100)

output_path <- here::here("Output/Analysis_4", "plot.png")
ggsave(output_path, plot = p, width = 8, height = 5)
