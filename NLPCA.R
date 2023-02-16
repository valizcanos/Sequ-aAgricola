library(pcaMethods)
library(dplyr)
library(reshape2)
library(mice) 

setwd("D:/DOCS/PATIA/ARCHIVOS/VHI_Raw")
list.files()

Datos = read.csv("UNIFICADO.csv")
Datos = Datos[,-c(1)]
Datos$Fecha = as.Date(Datos$Fecha)

Tiempo = seq(as.Date("2001-01-01"),as.Date("2021-12-31"), by="month")
Tiempo2 = rep(Tiempo, 32185)
Tiempo2 = sort(Tiempo2)
Tiempo2 = as.data.frame(Tiempo2)

lon = unique(Datos$x)
lon = rep(lon, 51660)
lon = sort(lon)
lat = unique(Datos$y)
lat = rep(lat, 39564)

DatosVHI = cbind(lon,lat, Tiempo2)
colnames(DatosVHI) = c("x","y","Fecha")

DatosVHI = left_join(DatosVHI,Datos, by = c("x","y","Fecha"))

DatosVHI$mes <- format(as.Date(DatosVHI$Fecha, format="%Y-%m-%d"),"%m")
DatosVHI$anio <- format(as.Date(DatosVHI$Fecha, format="%Y-%m-%d"),"%Y")

Nid = rep(1:386220, 21)

DatosVHI$ID = Nid
###################################################################################################

DatosAdj = Datos
DatosAdj$mes = format(as.Date(Datos$Fecha, format="%Y-%m-%d"),"%m")
DatosAdj$anio = format(as.Date(Datos$Fecha, format="%Y-%m-%d"),"%Y")

for(i in 2001:2021){
  NumD = nrow(DatosAdj[DatosAdj$anio == i,])
  cat("N. Datos ", i, " ", NumD, "\n")
}

N2001 =DatosAdj[DatosAdj$anio == 2001,] 
DSqr= as.data.frame(N2001[1:148706,3])
colnames(DSqr)[1]= c("N2001")

for(i in 2002:2021){
  NumD = DatosAdj[DatosAdj$anio == i,]
  NumD = as.data.frame(NumD[1:148706,3])
  DSqr[paste("N",i,sep="")] = cbind(NumD)
}

###################################################################################################

NlPca <- pca(DSqr, center=FALSE, nPcs=5, maxSteps=300)

plot(NlPca@scores[,1], NlPca@scores[,2])
fittedData <- fitted(NlPca, DSqr)

#Varianza explicada

Varianza = (NlPca@sDev)^2
VarExp = (Varianza/sum(Varianza))

barplot(VarExp)

