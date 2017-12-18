library(rjson)
library(RJSONIO)
json_file <- "https://tidesandcurrents.noaa.gov/api/datagetter?product=predictions&application=NOS.COOPS.TAC.WL&begin_date=20171109&end_date=20171129&datum=MLLW&station=9415020&time_zone=GMT&units=english&interval=&format=json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))
library(reshape)
mdata <- melt(json_data)
t <- mdata[seq(1,length(mdata$value),2),1]
lev <- mdata[seq(2,length(mdata$value),2),1]
lev1 <- as.numeric(as.character(lev))
timeStamp <-  strftime(t,"%Y-%m-%d %H:%M:%S")
timeStamp <-  strptime(timeStamp,"%Y-%m-%d %H:%M:%S")
ti <- timeStamp-timeStamp[1]
z <- lev1- ave(lev1)
#plot(ti, z)+ lines(ti, z)
i <- (0:(length(ti)-1))
maxti <- as.numeric(as.character(max(ti)))
x <- i/maxti
yfreq <- 2/(length(ti)-1)*Mod(fft(z))
df <- data.frame(x, yfreq, "a")
library(ggplot2)
#plot(x, yfreq, xlim=c(0, 0.0001))+ lines(x, yfreq)
