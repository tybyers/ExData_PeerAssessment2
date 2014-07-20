# Tyler Byers
# plot4.R
# For Coursera EDA course
# Peer Assessment #2
# 20 July 2014

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Assignment: Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

# Subset SCC by the EI.Sector variable; those rows that include "Coal" --
#  all coal emissions are coal combustion
SCC.coal <- SCC[grep('Coal', SCC$EI.Sector),]

# Now subset NEI data by these SCC numbers
NEI.coal <- subset(NEI, SCC %in% SCC.coal$SCC)

# Here I use the dplyr library to group these emissions from coal by year.
library(dplyr)
year <- group_by(NEI.coal, year)
NEI.coal.by_year <- summarise(year, emissions = sum(Emissions), 
                                       n = n())

head(NEI.coal.by_year)
#   year emissions    n
# 1 1999  572126.5 5570
# 2 2002  546789.2 8683
# 3 2005  552881.5 8646
# 4 2008  343432.2 5581

# Make a barplot as in plots #1 and #2 to visualize this change
png('plot4.png', height = 480, width = 480)
barplot(NEI.coal.by_year$emissions, xlab = 'Year', 
        ylab = 'Total Emissions (Tons PM2.5)',
        names.arg = NEI.by_year$year, 
        main = 'Plot 4: Total Emissions from Coal Combustion Per Year')
dev.off()
