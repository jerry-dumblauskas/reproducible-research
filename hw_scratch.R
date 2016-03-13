dta<-read.csv("repdata-data-StormData.csv.bz2")
  #y<-c('EVTYPE','FATALITIES', 'INJURIES', 'PROPDMG', 'PROPDMGEXP', 'CROPDMG', 'CROPDMGEXP')
  #unique(dta$PROPDMGEXP)
  #dta[dta$PROPDMGEXP=='-',]



danger_to_human_life<-subset(dta,select = c('EVTYPE', 'FATALITIES', 'INJURIES'))
aggdata_hl<-aggregate(danger_to_human_life[,2:3], by=list(danger_to_human_life$EVTYPE), FUN = sum, na.rm=TRUE)
aggdata_hl$totals<-rowSums(aggdata_hl[,2:3])
sorted_hl<-aggdata_hl[order(-aggdata_hl$totals), ]
plot_data_hl<-head(sorted_hl,20)
plot_data_hl$totals<-plot_data_hl$totals/1000
barplot(plot_data_hl$totals, names.arg=plot_data_hl$Group.1, ylim=c(0, 100),las=2, ylab = "Number of incidents (in Thousands)", main = "Highest 20 events that have the most harmful effects on human life ")


economic_damage<-subset(dta,select = c('EVTYPE', 'PROPDMG', 'PROPDMGEXP', 'CROPDMG', 'CROPDMGEXP'))

economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='']<-1
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='-']<-0
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='?']<-0
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='+']<-0
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='0']<-1
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='1']<-1
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='2']<-10
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='3']<-100
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='4']<-1000
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='5']<-10000
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='6']<-100000
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='7']<-1000000
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='8']<-10000000
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='B']<-1000000000
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='h']<-100
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='H']<-100
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='K']<-1000
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='m']<-1000000
economic_damage$PROPDMGNUM[economic_damage$PROPDMGEXP=='M']<-1000000

economic_damage$PROPDMGTOTAL<-economic_damage$PROPDMGNUM * economic_damage$PROPDMG
  
economic_damage$CROPDMGNUM[economic_damage$CROPDMGEXP=='']<-1
economic_damage$CROPDMGNUM[economic_damage$CROPDMGEXP=='?']<-0
economic_damage$CROPDMGNUM[economic_damage$CROPDMGEXP=='0']<-1
economic_damage$CROPDMGNUM[economic_damage$CROPDMGEXP=='2']<-10
economic_damage$CROPDMGNUM[economic_damage$CROPDMGEXP=='B']<-1000000000
economic_damage$CROPDMGNUM[economic_damage$CROPDMGEXP=='k']<-1000
economic_damage$CROPDMGNUM[economic_damage$CROPDMGEXP=='K']<-1000
economic_damage$CROPDMGNUM[economic_damage$CROPDMGEXP=='m']<-1000000
economic_damage$CROPDMGNUM[economic_damage$CROPDMGEXP=='M']<-1000000

economic_damage$CROPDMGTOTAL<-economic_damage$CROPDMGNUM * economic_damage$CROPDMG

# upper this
economic_damage$EVTYPE<-toupper(economic_damage$EVTYPE)
# sort and combine the data into a totals collumn
aggdata_econ_consequences<-aggregate(economic_damage[,c(7,9)], by=list(economic_damage$EVTYPE), FUN = sum, na.rm=TRUE)
aggdata_econ_consequences$totals<-rowSums(aggdata_econ_consequences[,2:3])
sorted_ec<-aggdata_econ_consequences[order(-aggdata_econ_consequences$totals), ]
#set to billions
sorted_ec$totals<-sorted_ec$totals/1000000000
plot_data_ec<-head(sorted_ec,20)
barplot(plot_data_ec$totals, names.arg=plot_data_ec$Group.1, ylim=c(0, 200),las=2, ylab = "Dollar Damage (in Billions of Dollars)", main = "Highest 20 events that have the most harmful effects on the economy ")
