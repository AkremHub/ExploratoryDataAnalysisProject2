# Q6. Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

# Load the main tables
NEI <- readRDS("summarySCC_PM25.rds")
SourceCCTable <- readRDS("Source_Classification_Code.rds")

#Subset the NEI for each city using the city given  codes
NEI_Baltimore=NEI[NEI$fips=="24510",]
NEI_LosAngeles=NEI[NEI$fips=="06037",]

# Extract data relate to the Vehicle Motor Sources (VMS)
#The assumption is that the  EI.Sector classifies the  Vehicle Motor related Sources
VMS <- grep("Vehicle",SourceCCTable$EI.Sector,value=T,ignore.case=T)

# From the source Classification code table get the corresponding codes (SCC)
code<- subset(SourceCCTable, SourceCCTable$EI.Sector %in% VMS, select=SCC)

#Subset the NEI for each city using the corresponding code
subNEI_Baltimore <- subset(NEI_Baltimore, NEI_Baltimore$SCC %in%  code$SCC)
subNEI_LosAngeles <- subset(NEI_LosAngeles, NEI_LosAngeles$SCC %in%  code$SCC)

#Obtain the total emissions for each city by year
aggregatedResult_Baltimore=aggregate( list(Emissions =subNEI_Baltimore$Emissions),by=list(Year=subNEI_Baltimore$year),FUN=sum)
aggregatedResult_LosAngeles=aggregate( list(Emissions =subNEI_LosAngeles$Emissions),by=list(Year=subNEI_LosAngeles$year),FUN=sum)

# Add a column with the city name to each result to simplify the plotting 
aggregatedResult_Baltimore$City="Baltimore City"
aggregatedResult_LosAngeles$City="Los Angeles County"

# Combin both results so that we can use one data fram to plot
bothData=rbind(aggregatedResult_Baltimore,aggregatedResult_LosAngeles)

# Plot the figure 
library(ggplot2)

#Prepare the png device
png('plot6.png')

plot6=ggplot(data = bothData,aes(x=Year,y=Emissions,color=City))+geom_line()+geom_point()+ylab(expression('Total PM'[2.5]*' Emissions'))+ggtitle("Total Emissions from motor vehicle (Baltimore vs LosAngeles)")
print(plot6)

# Shut down the specified (by default the current) device
dev.off() 

