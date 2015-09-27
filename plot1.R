# Q1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system,
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008

# Load the main table
NEI <- readRDS("summarySCC_PM25.rds")

#Obtain the total emissions  by year
aggregatedResult_USA=aggregate(list(Emissions =NEI$Emissions),by=list(Year=NEI$year),FUN=sum)

# Plot the figure 
#Prepare the png device
png('plot1.png')

# Create the plot
plot(aggregatedResult_USA,type="l",main=expression('Total PM'[2.5]*' Emissions in USA'),xlab="Year",ylab=expression('Total PM'[2.5]*' Emissions'))

#Add grid to the plot
grid()

# Shut down the specified (by default the current) device
dev.off() 
