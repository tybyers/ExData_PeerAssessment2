# Tyler Byers
# plot2.R
# For Coursera EDA course
# Peer Assessment #2
# 20 July 2014

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Assignment: Have total emissions from PM2.5 decreased in the Baltimore City,
#  Maryland (fips == 24510) from 1999 to 2008? Use the base plotting system 
#  to make a plot answering this question.

# First I need to subset the NEI data for fips 24510
NEI.baltimore <- subset(NEI, fips == 24510)

# Second I will use the dplyr library to group and sum emissions by year.
library(dplyr)
years <- group_by(NEI.baltimore, year)
NEI.baltimore.by_year <- summarise(years, emissions = sum(Emissions), n = n())

head(NEI.baltimore.by_year)
# Output of head(NEI.by_year):
#   year emissions       n
# 1 1999  3274.180 320
# 2 2002  2453.916 535
# 3 2005  3091.354 542
# 4 2008  1862.282 699

# I prefer to make a barplot to visualize this. This is still
#  in the base plotting system.
png('plot2.png', height = 480, width = 480)
barplot(NEI.baltimore.by_year$emissions, xlab = 'Year', 
        ylab = 'Total Emissions (Tons PM2.5)',
        names.arg = NEI.by_year$year, 
        main = 'Plot 2: Total Emissions in Baltimore City Per Year')
dev.off()
