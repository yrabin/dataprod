library(reshape2)


# sgtfr contains TFR yearly by ethnic group
sgtfr <- read.csv('./data/sgtfr.csv')
sgtfrmelt <- melt(sgtfr, id=c('Year','Total'), measure.vars=c('Chinese','Malays','Indians'))
names(sgtfrmelt) <- c('year','tottfr', 'ethnic', 'ethtfr')


# sgedu contains rate of 5 or more GCE O Level passes yearly by ethnic group
sgedu <- read.csv('./data/sgedu.csv')
sgedumelt <- melt(sgedu, id=c('Year','Total'), measure.vars=c('Chinese','Malays','Indians'))
names(sgedumelt) <- c('year','tot5olvl', 'ethnic', 'eth5olvl')


# sgpop contains natural increament of resident yearly by ethnic group
sgpop <- read.csv('./data/sgpop.csv')
sgpop$Total <- as.numeric(sub(',','',levels(sgpop$Total),fixed=TRUE))[sgpop$Total]
sgpop$Chinese <- as.numeric(sub(',','',levels(sgpop$Chinese),fixed=TRUE))[sgpop$Chinese]
sgpop$Malays <- as.numeric(sub(',','',levels(sgpop$Malays),fixed=TRUE))[sgpop$Malays]
sgpop$Indians <- as.numeric(sub(',','',levels(sgpop$Indians),fixed=TRUE))[sgpop$Indians]
sgpopmelt <- melt(sgpop, id=c('Year','Total'), measure.vars=c('Chinese','Malays','Indians'))
names(sgpopmelt) <- c('year','totnatincr', 'ethnic', 'ethnatincr')


# combine all three datasets above into single data frame
sgedutfr <- merge(sgedumelt, sgtfrmelt, by=c('year','ethnic'))
data <- merge(sgedutfr, sgpopmelt, by=c('year','ethnic'))
data$year <- as.numeric(data$year)
data$name <- paste(data$ethnic, data$year, sep='_')
