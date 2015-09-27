# Q4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Load the main tables
NEI <- readRDS("summarySCC_PM25.rds")
SourceCCTable <- readRDS("Source_Classification_Code.rds")

# Extract data relate to the coal combustion-related sourcess (CCS)
#The assumption is that the  EI.Sector classifies the coal combustion-related sourcess
CCS <- grep("coal",SourceCCTable$EI.Sector,value=T,ignore.case=T)

# From the source Classification code table get the corresponding codes (SCC)
code<- subset(SourceCCTable, SourceCCTable$EI.Sector %in% CCS, select=SCC)

#Subset the NEI using the corresponding code
subNEI<- subset(NEI, NEI$SCC %in%  code$SCC)


#Obtain the total emissions  by year
aggregatedResult_USA=aggregate( list(Emissions =subNEI$Emissions),by=list(Year=subNEI$year),FUN=sum)


# Plot the figure 
library(ggplot2)

#Prepare the png device
png('plot4.png')

plot4=ggplot(data = aggregatedResult_USA,aes(x=Year,y=Emissions))+geom_line()+geom_point()+ylab(expression('Total PM'[2.5]*' Emissions'))+ggtitle("Total Emissions from coal combustion sourcess in USA")

print(plot4)

# Shut down the specified (by default the current) device
dev.off() 

