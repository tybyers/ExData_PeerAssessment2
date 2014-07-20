# Tyler Byers
# plot5.R
# For Coursera EDA course
# Peer Assessment #2
# 20 July 2014

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Assignment: How have emissions from motor vehicle sources changed
#  from 1999–2008 in Baltimore City?

# First I need to subset the NEI data for fips 24510
NEI.baltimore <- subset(NEI, fips == 24510)

# Next I find the vehicle-related SCC's
SCC.veh <- SCC[grep('Vehicle', SCC$EI.Sector),]

# Then subset NEI.baltimore based on the vehicle SCCs
NEI.baltimore.veh <- subset(NEI.baltimore, SCC %in% SCC.veh$SCC)

# Nes I will use the dplyr library to group and sum emissions by year.
library(dplyr)
years <- group_by(NEI.baltimore.veh, year)
NEI.baltimore.veh.by_year <- 
    summarise(years, emissions = sum(Emissions), n = n())

head(NEI.baltimore.veh.by_year)
# Output of head(NEI.by_year):
# year emissions   n
# 1 1999 346.82000 192
# 2 2002 134.30882 321
# 3 2005 130.43038 324
# 4 2008  88.27546 282

# I prefer to make a barplot to visualize this. This is still
#  in the base plotting system.
png('plot5.png', height = 480, width = 480)
barplot(NEI.baltimore.veh.by_year$emissions, xlab = 'Year', 
        ylab = 'Total Emissions (Tons PM2.5)',
        names.arg = NEI.by_year$year, 
        main = 'Plot 5: Vehicle Emissions in Baltimore City Per Year')
dev.off()
