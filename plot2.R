# Q2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Load the main table
NEI <- readRDS("summarySCC_PM25.rds")

#Subset the NEI for Baltimore city using the given city codes
NEI_Baltimore=NEI[NEI$fips=="24510",]

#Obtain the total emissions  by year
aggregatedResult_Baltimore=aggregate(list(Emissions =NEI_Baltimore$Emissions),by=list(Year=NEI_Baltimore$year),FUN=sum)

# Plot the figure 
#Prepare the png device
png('plot2.png')

# Create the plot
plot(aggregatedResult_Baltimore,type="l",main=expression('Total PM'[2.5]*' Emissions in  Baltimore City'),xlab="Year",ylab=expression('Total PM'[2.5]*' Emissions'))

#Add grid to the plot
grid()

# Shut down the specified (by default the current) device
dev.off() 

