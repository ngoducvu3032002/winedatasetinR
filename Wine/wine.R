rm(list=ls())
#Doc du lieu va gan vao bien wine
wine <- read.csv("wine/wine.data", sep=",")

#Tao bien chua cac header
variables <-  c('Type', 'Alcohol', 'Malic', 'Ash',
                'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids',
                'Nonflavanoids','Proanthocyanins', 'Color', 'Hue', 
                'Dilution', 'Proline')
#Noi header voi data
colnames(wine) <- variables
#Xuat du lieu ra file csv
write.csv(wine,"wine.csv",row.names = FALSE)
