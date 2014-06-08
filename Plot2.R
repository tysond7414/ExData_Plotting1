
#===============================================================================================

# DS4,A1,Plot2

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
png(filename="plot2.png", width=480,height=480,units="px")
plot(power$D1,power$Global_active_power,type="l",xlab="",ylab="Global Active Power (Kilowatts)")
dev.off()