x<-read.csv("repdata-data-StormData.csv.bz2")
y<-c('EVTYPE','FATALITIES', 'INJURIES', 'PROPDMG', 'PROPDMGEXP', 'CROPDMG', 'CROPDMGEXP')
zz<-subset(x,select=y)
unique(zz$PROPDMGEXP)
zz[zz$PROPDMGEXP=='-',]
unique(zz$CROPDMGEXP)
