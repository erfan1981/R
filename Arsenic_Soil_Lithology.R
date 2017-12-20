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