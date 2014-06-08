
#===============================================================================================

# DS4,A1,Plot3

#===============================================================================================

# Create a temp location folder
temp<-tempfile()

# Save the file url & Download the zip file
urlFile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(urlFile,destfile = temp, method = "curl")

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
png(filename="plot3.png", width=480,height=480,units="px")
cols = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(power$D1,power$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(power$D1,power$Sub_metering_2,type="l",col="red")
lines(power$D1,power$Sub_metering_3,type="l",col="blue")
legend("topright",lty=1,lwd=1,col=c("black","blue","red"),legend=cols)
dev.off()
