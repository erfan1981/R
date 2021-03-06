library(rjson)
library(RJSONIO)
json_file <- "https://raw.githubusercontent.com/erfan1981/JSON/master/Soil%20Arsenic%20Soil%20Litho%20Type.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))
library(reshape)
mdata <- melt(json_data)
StatID <- as.character(mdata[seq(8,length(mdata$value),7),1])
SampID <- as.character(mdata[seq(9,length(mdata$value),7),1])
Time <- as.character(mdata[seq(10,length(mdata$value),7),1])
Result <-  as.numeric(as.character(mdata[seq(12,length(mdata$value),7),1]))
Litho <- as.character(mdata[seq(14,length(mdata$value),7),1])
Time <-  as.POSIXct(as.character(Time), format= "%m/%d/%Y %H:%M")
df <- data.frame(Time, Result, StatID, Litho)
for (i in 1:length(df$Result)) {if (df$Result[i] < 0) {df$Result[i] = -df$Result[i]/2} else {df$Result[i] = df$Result[i]}}
library(ggplot2)
a <- ggplot(df, aes(Litho, Result)) +geom_point(aes(colour = factor(Litho)))#+ theme(axis.text.x = element_text(angle = 90, hjust = 1))
a
library(sqldf)
BM <- sqldf("select * from df where Litho == 'Bay Mud'")
Fill <- sqldf("select * from df where Litho == 'Fill'")
BR <- sqldf("select * from df where Litho == 'Bedrock'")
FillSW <- shapiro.test(Fill$Result) # Shapiro-Wilk Normality Test for Sample Size < 50
BMSW <- shapiro.test(BM$Result)
BRSW <- shapiro.test(BR$Result)
library(nortest)
FillSF <- sf.test(Fill$Result) # Shapiro-Francia Normality Test for Sample Size > 50
if (FillSF$p.value < 0.05) {print("The null hypothesis that the data is normally distributed is rejected")} else {print("Cannot reject the null hypothesis that the data is normally distributed")}
hist(Fill$Result, breaks=500, xlim = c(0,50))
qqnorm (Fill$Result)
BMSF <- sf.test(BM$Result)
BRSF <- sf.test(BR$Result)
ttest <- t.test(Fill$Result,BM$Result)
