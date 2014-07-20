# Tyler Byers
# plot6.R
# For Coursera EDA course
# Peer Assessment #2
# 20 July 2014

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Assignment: Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California 
# (fips == 06037). Which city has seen greater changes over time in motor 
# vehicle emissions?

# First I need to subset the NEI data for fips 24510 and 06037
NEI.balt_la <- subset(NEI, fips == '24510' | fips == '06037')

 # Next I find the vehicle-related SCC's
SCC.veh <- SCC[grep('Vehicle', SCC$EI.Sector),]

# Then subset NEI.balt_la based on the vehicle SCCs
NEI.balt_la.veh <- subset(NEI.balt_la, SCC %in% SCC.veh$SCC)

# Next I will use the dplyr library to group and sum emissions by year.
library(dplyr)
years <- group_by(NEI.balt_la.veh, year, fips)
NEI.balt_la.veh.by_year <- 
    summarise(years, emissions = sum(Emissions), n = n())

head(NEI.balt_la.veh.by_year)
# Output of head(NEI.by_year):
#   year  fips emissions   n
# 1 1999 06037 3931.1200 144
# 2 1999 24510  346.8200 192
# 3 2002 06037 4274.0302 398
# 4 2002 24510  134.3088 321
# 5 2005 06037 4601.4149 396
# 6 2005 24510  130.4304 324

# I will compare these using a ggplot line plot..
png('plot6.png', height = 480, width = 480)
theme_set(theme_minimal(14))
ggplot(aes(x = year, y = emissions, color = fips), 
       data = NEI.balt_la.veh.by_year) + geom_line() + geom_point() +
    facet_wrap(~fips, scales = 'free') + scale_color_discrete('Location') +
    xlab('Year') + ylab('Emissions (Tons PM2.5)') + 
    ggtitle('Vehicle Emissions in LA (06037) and Baltimore (24510)')
dev.off()
