library(raster)
library(dplyr)

print(getwd()) #Mostrar directorio de trabajo

DirTrababajo = setwd("D:/DOCS/PATIA/") #Establecer directorio de trabajo

# Selecciona el conjunto de archivos que desea analizar
# 1: /IMGENES/TCI
# 2: /IMGENES/VCI
# 3: /IMGENES/VHI
# 4: /IMGENES/TCI_Raw
# 5: /IMGENES/VCI_Raw
# 6: /IMGENES/VHI_Raw

Opcion = 4

ImgCol = switch(Opcion,"/IMGENES/TCI","/IMGENES/VCI","/IMGENES/VHI","/IMGENES/TCI_Raw","/IMGENES/VCI_Raw","/IMGENES/VHI_Raw")

PathImgCol = paste(DirTrababajo,ImgCol, sep="")

ListaImagenes = list.files(PathImgCol, pattern = "\\.tif$", full.names=TRUE)

# Selecciona el directorio en e cual deseas guardar los archivos de texto convertidos
# 1: /ARCHIVOS/TCI
# 2: /ARCHIVOS/VCI
# 3: /ARCHIVOS/VHI
# 4: /ARCHIVOS/TCI_Raw
# 5: /ARCHIVOS/VCI_Raw
# 6: /ARCHIVOS/VHI_Raw

SaveFiles = switch(Opcion,"/ARCHIVOS/TCI","/ARCHIVOS/VCI","/ARCHIVOS/VHI","/ARCHIVOS/TCI_Raw","/ARCHIVOS/VCI_Raw","/ARCHIVOS/VHI_Raw")
PathFileCol = paste(DirTrababajo,SaveFiles, sep="")

#Definir rango de fechas de las imagenes

Fechas = seq.Date(as.Date("2001-01-01"),as.Date("2021-12-31"),by = "month")

# Subir mascara

Mask = rgdal::readOGR("Sph.AltoPatia/AltoPatia.shp")
plot(Mask)

#Función de conversión de datos a texto

Raster2DF = function(PathiCDCol){
  for(i in 1:length(PathiCDCol)){
    ArchivoRaster = raster(PathiCDCol[i])
    ArchivoRaster = raster::crop(ArchivoRaster,Mask)
    df = as.data.frame(ArchivoRaster, xy=TRUE)
    df = na.omit(df) 
    write.csv(df, paste(PathFileCol, '/' ,Fechas[i],'.csv',sep=''), row.names = FALSE)
  }
}

Raster2DF(ListaImagenes) #Exportar datos de imagenes a .csv

#Unificar lista de archivos

DF_CD = list()

JoinDF2List = function(PathListaCSV){
  for(i in 1:length(PathListaCSV)){
    Archivos = read.csv(PathListaCSV[i])
    colnames(Archivos)[3]= 'VALOR'
    Archivos = cbind(Archivos,rep(Fechas[i],nrow(Archivos)))
    colnames(Archivos)[4]= 'Fecha'
    DF_CD[[i]] = list(Archivos)
  }
  return(DF_CD) 
}

ListaArchivos = list.files(PathFileCol, pattern = "\\.csv$", full.names=TRUE)

ListaFiles = JoinDF2List(ListaArchivos)

ArchivosUnificados = bind_rows(ListaFiles)

write.csv(ArchivosUnificados,paste(PathFileCol,"/UNIFICADO.csv",sep=""))
