library(reshape2)

sgtfr <- read.csv('./data/sgtfr.csv')
sgtfrmelt <- melt(sgtfr, id=c('Year','Total'), measure.vars=c('Chinese','Malays','Indians'))
names(sgtfrmelt) <- c('year','tottfr', 'ethnic', 'ethtfr')


sgedu <- read.csv('./data/sgedu.csv')
sgedumelt <- melt(sgedu, id=c('Year','Total'), measure.vars=c('Chinese','Malays','Indians'))
names(sgedumelt) <- c('year','tot5olvl', 'ethnic', 'eth5olvl')


sgpop <- read.csv('./data/sgpop.csv')
sgpop$Total <- as.numeric(sub(',','',levels(sgpop$Total),fixed=TRUE))[sgpop$Total]
sgpop$Chinese <- as.numeric(sub(',','',levels(sgpop$Chinese),fixed=TRUE))[sgpop$Chinese]
sgpop$Malays <- as.numeric(sub(',','',levels(sgpop$Malays),fixed=TRUE))[sgpop$Malays]
sgpop$Indians <- as.numeric(sub(',','',levels(sgpop$Indians),fixed=TRUE))[sgpop$Indians]
sgedumelt <- melt(sgpop, id=c('Year','Total'), measure.vars=c('Chinese','Malays','Indians'))
names(sgpopmelt) <- c('year','totnatincr', 'ethnic', 'ethnatincr')


sgedutfr <- merge(sgedumelt, sgtfrmelt, by=c('year','ethnic'))
sgedutfr <- merge(sgedutfr, sgpopmelt, by=c('year','ethnic'))

write.csv(file='./data/sgedutfr.csv', x=sgedutfr, row.names=FALSE)
