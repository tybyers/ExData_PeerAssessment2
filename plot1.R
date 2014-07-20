# Tyler Byers
# plot4.R
# For Coursera EDA course
# Peer Assessment #2
# 20 July 2014

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Assignment: Have total emissions from PM2.5 decreased in the United States 
#  from 1999 to 2008? Using the base plotting system, make a plot showing 
#  the total PM2.5 emission from all sources for each of the years 1999, 2002,
#  2005, and 2008.

# First I will use the dplyr library to group and sum emissions by year.
library(dplyr)
years <- group_by(NEI, year)
NEI.by_year <- summarise(years, emissions = sum(Emissions), n = n())

head(NEI.by_year)
# Output of head(NEI.by_year):
#   year emissions       n
# 1 1999   7332967 1108469
# 2 2002   5635780 1698677
# 3 2005   5454703 1713850
# 4 2008   3464206 1976655

# I prefer to make a barplot to visualize this. This is still
#  in the base plotting system.
png('plot1.png', height = 480, width = 480)
barplot(NEI.by_year$emissions, xlab = 'Year', 
        ylab = 'Total Emissions (Tons PM2.5)',
        names.arg = NEI.by_year$year, 
        main = 'Plot 1: Total Emissions Per Year')
dev.off()
