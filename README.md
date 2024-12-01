# DATA 550 Midterm project

------------------------------------------------------------------------

# Code description

# Makefile
  - Running "make report.html" will compile the report using the data and code

# Analysis 1
`Code/Analysis_1/00_clean_data.R` 
  - This script cleans the wastewater dataset for Analysis 1

`Code/Analysis_1/01_make_table.R`
  - This script uses the cleaned data makes a table showing for each state what the average change of the “ptc_15d” variable over the reporting periods included in the dataset is.

# Analysis 2

`Code/Analysis_2/detect_prop_15d_analysis.R`
  - This script makes a table with the top 20 jurisdictions that had the highest average SARS-CoV-2 viral detection proportions (detect_prop_15d) in the dataset.

# Analysis 3

`Code/Analysis_3/01_make_plot.R`
  - This script makes a scatterplot with the X axis being population levels of each wastewater treatment plant, and the Y axis will be the average of the detect_prop_15d values recorded for each population size. 

# Analysis 4
`Code/Analysis_3/midterm_code.R`
  - This script creates a bar chart summarizing "avg_detect_prop_15d" by season.

