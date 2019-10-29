#getting climate data for all sites
merged_data <- read.csv('/Volumes/GoogleDrive/My Drive/Other projects/NEON/Neon Practice/soil_canopy_nitrogen_project/all.csv')
head(merged_data)

library(raster)
library(sp)
library(dplyr)
library(sf)
library(rgdal)
library(broom)
test <- st_read(
  "/Volumes/GoogleDrive/My Drive/Other projects/NEON/Neon Practice/soil_canopy_nitrogen_project/NEONFieldSites-v16/NEON_Field_Sites.shp")
plot(test)
my_df <- as.data.frame(test)
summary(my_df)
head(my_df)
my_df_2 <- my_df %>% select(SiteID,Latitude,Longitude)
head(my_df_2)

r <- getData("worldclim",var="bio",res=10)

r <- r[[c(1,12)]]
names(r) <- c("Temp","Prec")

lats <- c(9.093028 , 9.396111, 9.161417)
lons <- c(-11.7235, -11.72975, -11.709417)

lats <- c(my_df_2$Latitude)
lons <- c(my_df_2$Longitude) 

coords <- data.frame(x=lons,y=lats)
head(coords)
head(my_df_2)
points <- SpatialPoints(coords, proj4string = r@crs)

values <- extract(r,points)

df <- cbind.data.frame(coordinates(points),values)
df$Temp.2<-df$Temp/10
df$Prec.2<-df$Prec/10
head(df)
df.final<-df[c(1,2,5,6)]
head(df.final)

#rename original columns names to x y so you can merge with the worlclim dataset
colnames(my_df_2) <- c("SiteID", "y","x")
head(my_df_2)

merged_df<-merge(my_df_2,df.final,by=c('x','y'))
head(merged_df)
colnames(merged_df) <-c('x','y','SiteID','MAT','MAP')
write.csv(merged_df,file='MAT_MAP_Allsites.csv')
