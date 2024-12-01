#Makefile for generating report

#Final report
report.html: report.Rmd code/render_report.R make_table_1 make_table_2 make_plot_3 make_plot_4
	Rscript code/render_report.R

#Analysis 1
make_table_1: clean_data
	Rscript code/Analysis_1/01_make_table.R

clean_data:
	Rscript code/Analysis_1/00_clean_data.R

#Analysis 2

make_table_2: 
	Rscript code/Analysis_2/detect_prop_15d_analysis.R

#Analysis 3

make_plot_3:
	Rscript code/Analysis_3/01_make_plot.R

#Analysis 4

make_plot_4:
	Rscript code/Analysis_4/midterm_code.R

.PHONY: clean
clean:
	rm -f Output/Analysis_1/*.Rds Output/Analysis_2/*.Rds Output/Analysis_3/*.png Output/Analysis_4/*.png  rm -f report.html

#Restoring package library
.PHONY: install
install:
Rscript -e "renv::restore(prompt = FALSE)"