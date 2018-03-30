library(rjson)
library(RJSONIO)
json_file <- "https://raw.githubusercontent.com/erfan1981/JSON/master/Sample_Arsenic_GW_Datav1.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))
library(reshape)
mdata <- melt(json_data)
StatID <- as.character(mdata[seq(7,length(mdata$value),6),1])
SampID <- as.character(mdata[seq(8,length(mdata$value),6),1])
Analyte <- as.character(mdata[seq(9,length(mdata$value),6),1])
Result <-  as.numeric(as.character(mdata[seq(10,length(mdata$value),6),1]))
Time <- mdata[seq(11,length(mdata$value),6),1]
Time <- as.Date(Time, format = "%m/%d/%Y") 
#Time <-  as.POSIXct(as.character(Time), format= "%m/%d/%Y")
$plot(timeStamp, Result)
library(sqldf)
df <- data.frame(Time, Result, StatID)
for (i in 1:length(df$Result)) {if (df$Result[i] < 0) {df$Result[i] = -df$Result[i]/2} else {df$Result[i] = df$Result[i]}}
library(ggplot2)
a <- ggplot(df, aes(Time, Result)) +geom_point(aes(colour = factor(StatID)))+ theme(axis.text.x = element_text(angle = 90, hjust = 1))
a
GW27 <- sqldf("select * from df where StatID == 'GW-27'")
GW29 <- sqldf("select * from df where StatID == 'GW-29'")
GW27SW <- shapiro.test(GW27$Result)
GW29SW <- shapiro.test(GW29$Result)
if (GW27SW$p.value < 0.02) {print("The null hypothesis that the data is normally distributed is rejected")} else {print("Cannot reject the null hypothesis that the data is normally distributed")}
