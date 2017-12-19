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
Time <-  as.POSIXct(as.character(Time), format= "%m/%d/%Y %H:%M")
$plot(timeStamp, Result)
library(sqldf)
df <- data.frame(Time, Result, StatID)
for (i in 1:length(df$Result)) {if (df$Result[i] < 0) {df$Result[i] = -df$Result[i]/2} else {df$Result[i] = df$Result[i]}}
df1 <- sqldf("select * from df where StatID like '%MW%' and StatID <> 'MW-1' and StatID <> 'MW-3' and StatID <> 'MW-4' and StatID <> 'MW-10' and StatID <> 'MW-2' and Result > 0")
library(ggplot2)
a <- ggplot(df1, aes(Time, Result)) +geom_point(aes(colour = factor(StatID)))+ theme(axis.text.x = element_text(angle = 90, hjust = 1))
a
MW27 <- sqldf("select * from df where StatID == 'MW-27'")
MW29 <- sqldf("select * from df where StatID == 'MW-29'")
MW27SW <- shapiro.test(MW27$Result)
MW29SW <- shapiro.test(MW29$Result)
if (MW27SW$p.value < 0.02) {print("Data is normal distributed")} else {print("Data is not normal distributed")}
