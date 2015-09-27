# Q3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# Load the main tables
NEI <- readRDS("summarySCC_PM25.rds")
SourceCCTable <- readRDS("Source_Classification_Code.rds")

#Subset the NEI for each city using the city given  codes
NEI_Baltimore=NEI[NEI$fips=="24510",]

#Obtain the total emissions  by year

aggregatedResult_Baltimore=aggregate(list(Emissions =NEI_Baltimore$Emissions),by=list(Year=NEI_Baltimore$year,Type=NEI_Baltimore$type),FUN=sum)

# Plot the figure 
library(ggplot2)

#Prepare the png device
png('plot3.png')

plot3=ggplot(data = aggregatedResult_Baltimore,aes(x=Year,y=Emissions,color=Type))+geom_line()+geom_point()+ylab(expression('Total PM'[2.5]*' Emissions'))+ggtitle("Total Emissions for Baltimore by type")
print(plot3)

# Shut down the specified (by default the current) device
dev.off() 
