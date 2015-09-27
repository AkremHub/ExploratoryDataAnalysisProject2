# Q5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Load the main tables
NEI <- readRDS("summarySCC_PM25.rds")
SourceCCTable <- readRDS("Source_Classification_Code.rds")

#Subset the NEI for each city using the city given  codes
NEI_Baltimore=NEI[NEI$fips=="24510",]


# Extract data relate to the Vehicle Motor Sources (VMS)
#The assumption is that the  EI.Sector classifies the  Vehicle Motor related Sources
VMS <- grep("Vehicle",SourceCCTable$EI.Sector,value=T,ignore.case=T)

# From the source Classification code table get the corresponding codes (SCC)
code<- subset(SourceCCTable, SourceCCTable$EI.Sector %in% VMS, select=SCC)

#Subset the NEI for each city using the corresponding code
subNEI_Baltimore <- subset(NEI_Baltimore, NEI_Baltimore$SCC %in%  code$SCC)


#Obtain the total emissions  by year
aggregatedResult_Baltimore=aggregate( list(Emissions =subNEI_Baltimore$Emissions),by=list(Year=subNEI_Baltimore$year),FUN=sum)


# Plot the figure 
library(ggplot2)

#Prepare the png device
png('plot5.png')

plot5=ggplot(data = aggregatedResult_Baltimore,aes(x=Year,y=Emissions))+geom_line()+geom_point()+ylab(expression('Total PM'[2.5]*' Emissions'))+ggtitle("Total Emissions from motor vehicle sources in Baltimore")

print(plot5)

# Shut down the specified (by default the current) device
dev.off() 
