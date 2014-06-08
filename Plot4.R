
#===============================================================================================

# DS4,A1,Plot4

#===============================================================================================

# Create a temp location folder
temp<-tempfile()

# Save the file url & Download the zip file
urlFile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(urlFile,destfile = temp, method = "curl")
http://127.0.0.1:31423/rstudio/clear.cache.gif
# Unzip and read the file into R
pow<-read.table(unz(temp,"household_power_consumption.txt"),header=T,sep=";",na.strings="?")

# Subset the data
pow$Date<-as.Date(pow$Date,"%d/%m/%Y")
power<-pow[pow$Date>="2007-02-01" & pow$Date<="2007-02-02",]

# Use M3 packages to make date time variable
install.packages("M3")
library('M3')
power$D1<-combine.date.and.time(power$Date,power$Time)

# Create the plot with png output
png(filename="plot4.png", width=480,height=480,units="px")
par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))
plot(power$D1,power$Global_active_power,xlab="",ylab="Global Active Power",type="l")
plot(power$D1,power$Voltage,xlab="datetime",ylab="Voltage",type="l")
cols=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
plot(power$D1,power$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(power$D1,power$Sub_metering_2,type="l",col="red")
lines(power$D1,power$Sub_metering_3,type="l",col="blue")
legend("topright",lty=1,lwd=1,col=c("black","blue","red"),legend=cols,bty="n")
plot(power$D1,power$Global_reactive_power,xlab="datetime",ylab="Global_reative_power",type="l")
dev.off()

