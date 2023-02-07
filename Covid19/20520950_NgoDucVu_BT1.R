rm(list=ls())
#Đọc file và gán vào biến coronaData
coronaData <- read.csv("dataset/covid_19_data.csv")
#Hien thi so dong, cot
ncol(coronaData)
nrow(coronaData)
#Hien thi 10 dong du lieu
head(coronaData,10)
#In ra ten cac cot
names(coronaData)
#Tao bien cac quoc gia co dich Corona
countryCorona <- unique(coronaData['Country.Region'])
#Liet ke so ca nhiem nhieu nhat da duoc xac nhan
maxConfirmedCases <- max(coronaData['Confirmed'])

#Liệt kê các dữ liệu về covid-19 tại quốc gia Trung Quốc đại lục (Mainland China) và lưu vào biến coronaChina
coronaChina <- coronaData[which(coronaData$Country.Region=="Mainland China"),]
#Quoc gia co so ca nhiem nhieu nhat
maxCountryConfirmedCorona <- coronaData[which(coronaData$Confirmed==maxConfirmedCases),]['Country.Region']

#Tim tinh co so ca nhiem nhieu nhat
maxStateConfirmedCorona <-  coronaData[which(coronaData$Confirmed==maxConfirmedCases),]['Province.State']
#Định dạng lại dữ liệu ngày tháng
coronaData$ObservationDate <-  as.Date(coronaData$ObservationDate, "%m/%d/%Y")
#Lấy dữ liệu trong tháng 1/2020: bắt đầu từ 01/01/2020 đến 31/01/2020. 
data_jan <- coronaData[which(coronaData$ObservationDate>= "2020-01-01" & coronaData$ObservationDate <= "2020-01- 31"), ]


#4.b, Tìm dữ liệu về số ca lây nhiễm tại Vietnam (Country.Region == 'Vietnam') và lưu vào biến coronaVietnam
coronaVietnam<- coronaData[which(coronaData$Country.Region=="Vietnam"),]
#In ra số ca lây nhiễm nhiều nhất tại Việt Nam (Sử dụng lệnh print()  
maxConfirmedVietnam<-max(coronaVietnam$Confirmed)
print(maxConfirmedVietnam)

#Tìm dữ liệu về số ca lây nhiễm tại Việt Nam trong tháng 02
Vietnam_feb<-coronaVietnam[which(coronaVietnam$ObservationDate>= "2020-02-01" & coronaVietnam$ObservationDate <= "2020-02-29"),]

#In ra số dữ liệu về ca lây nhiễm nhiều nhất trong tháng 01 và 02 tại Việt Nam (Lấy năm 2021).
Vietnam_jan_feb<-coronaVietnam[which(coronaVietnam$ObservationDate>= "2021-01-01" & coronaVietnam$ObservationDate <= "2021-02-28"),]
max_vietnam_confirmed_jan_feb<-max(Vietnam_jan_feb$Confirmed)
print(max_vietnam_confirmed_jan_feb)


#Đối với Philippines
coronaPhilippines<-coronaData[which(coronaData$Country.Region=="Philippines"),]
Philippines_jan_feb<-coronaPhilippines[which(coronaPhilippines$ObservationDate>= "2021-01-01" & coronaPhilippines$ObservationDate <= "2021-02-28"),]
max_philippines_confirmed_jan_feb<-max(Philippines_jan_feb$Confirmed)
print(max_philippines_confirmed_jan_feb)
#Đối với Indonesia
coronaIndonesia<-coronaData[which(coronaData$Country.Region=="Indonesia"),]
Indonesia_jan_feb<-coronaIndonesia[which(coronaIndonesia$ObservationDate>= "2021-01-01" & coronaIndonesia$ObservationDate <= "2021-02-28"),]
max_indonesia_confirmed_jan_feb<-max(Indonesia_jan_feb$Confirmed)
print(max_indonesia_confirmed_jan_feb)

#In ra dữ liệu về ca tử vong của Trung Quốc trong khoảng thời gian từ 01/02/2021 cho đến 15/02/2021. In ra màn hình sử dụng lệnh print()
coronaChina$ObservationDate<-as.Date(coronaChina$ObservationDate, "%m/%d/%Y")
coronaChinaDeaths<-coronaChina[which(coronaChina$ObservationDate>= "2021-02-01" & coronaChina$ObservationDate <= "2021-02-15"),]['Deaths']
print(coronaChinaDeaths)

#Đếm số lượng ca ghi nhận theo từng tỉnh của Trung Quốc trong tháng 02/2021.
coronaChina_feb<-coronaChina[which(coronaChina$ObservationDate>= "2021-02-01" & coronaChina$ObservationDate <= "2021-02-15"),]
count=table(coronaChina_feb$Province.State)
list_province<-unique(coronaChina_feb$Province.State)
for(i in 1:length(list_province))
{
  data_new <- coronaChina_feb[which(coronaChina_feb$Province.State==list_province[i]),]
  min_date <- min(data_new$ObservationDate)
  max_date <- max(data_new$ObservationDate)
  case<-data_new[which(data_new$ObservationDate ==max_date),]$Confirmed -  data_new[which(data_new$ObservationDate ==min_date),]$Confirmed
  print(paste(list_province[i]," :",case))
}

#Tìm dữ liệu ca tử vong của Trung Quốc trong khoảng thời gian từ 01/02/2021 cho đến 15/02/2021. In ra màn hình sử dụng lệnh print().
print(coronaChinaDeaths)

#Có nhận xét gì về số ca nhiễm mới tại Việt Nam giữa tháng 05/2020 và tháng 05/2021.
coronaVietnam20_may<-coronaVietnam[which(coronaVietnam$ObservationDate>= "2020-05-01" & coronaVietnam$ObservationDate <= "2020-05-31"),]
coronaVietnam21_may<-coronaVietnam[which(coronaVietnam$ObservationDate>= "2021-05-01" & coronaVietnam$ObservationDate <= "2021-05-31"),]
plot(x=coronaVietnam20_may$ObservationDate, xlab="observation date",
     y=coronaVietnam20_may$Confirmed, ylab="confirmed cases",
      col="red", main="Bieu do ca nhiem covid o Vietnam thang 5 2020 ", type="l")
plot(x=coronaVietnam21_may$ObservationDate, xlab="observation date",
     y=coronaVietnam21_may$Confirmed, ylab="confirmed cases",
     col="red", main="Bieu do ca nhiem covid o Vietnam thang 5 2021 ", type="l")
