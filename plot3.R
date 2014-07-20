# Tyler Byers
# plot3.R
# For Coursera EDA course
# Peer Assessment #2
# 20 July 2014

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Assignment: Of the four types of sources indicated by the type 
#  (point, nonpoint, onroad, nonroad) variable, which of these 
#  four sources have seen decreases in emissions from 1999–2008 
#  for Baltimore City? Which have seen increases in emissions from 
#  1999–2008? Use the ggplot2 plotting system to make a plot answer 
#  this question.

# First I need to subset the NEI data for fips 24510
NEI.baltimore <- subset(NEI, fips == 24510)

# Second I will use the dplyr library to group and sum emissions by year.
library(dplyr)
yeartype <- group_by(NEI.baltimore, year, type)
NEI.baltimore.by_yeartype <- summarise(yeartype, emissions = sum(Emissions), 
                                       n = n())

head(NEI.baltimore.by_yeartype)
# Output of head(NEI.by_year):
#   year     type emissions   n
# 1 1999 NON-ROAD  522.9400  90
# 2 1999 NONPOINT 2107.6250  25
# 3 1999  ON-ROAD  346.8200 192
# 4 1999    POINT  296.7950  13
# 5 2002 NON-ROAD  240.8469 111
# 6 2002 NONPOINT 1509.5000  36

# Make a line plot on ggplot to visualize this
library(ggplot2)
png('plot3.png', height = 480, width = 480)
theme_set(theme_minimal(12)) # ggplot theme
ggplot(aes(x = year, y = emissions, color = type), 
       data = NEI.baltimore.by_yeartype) + geom_line() + 
       xlab('Year') + ylab('Emissions (Tons PM_2.5)') +
    ggtitle('Emissions by Type over Year in Baltimore City, MD') +
    scale_color_discrete('Source Type')
dev.off()
