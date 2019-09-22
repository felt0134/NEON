#canopy water

#canopy_dynamics
canopy_folder<-"G:/My Drive/NEON/Neon Practice/Canopy"

#canopy water
byFileAOP(dpID="DP3.30019.001", site="KONZ", 
              year='2017',check.size = T,
              savepath=canopy_folder)
?byTileAOP
to_download_stacked_canopy <-"G:/My Drive/NEON/Neon Practice/Canopy/DP3.30019.001/2017/FullSite/D06/2017_KONZ_2/L3/Spectrometer/WaterIndices"

to_download_stacked_canopy_test <-"G:/My Drive/NEON/Neon Practice/Canopy/DP3.30019.001/2017/FullSite"

stackByTable(filepath=to_download_stacked_canopy_test, 
             folder=T)
?byFileAOP

test<-"G:/My Drive/NEON/Neon Practice/Canopy/DP3.30019.001/2017/FullSite/D06/2017_KONZ_2/L3/Spectrometer/WaterIndices"


test_raster<-unzip("G:/My Drive/NEON/Neon Practice/Canopy/DP3.30019.001/2017/FullSite/D06/2017_KONZ_2/L3/Spectrometer/WaterIndices/NEON_D06_KONZ_DP3_702000_4325000_WaterIndices.zip")
stackByTable(filepath=test, 
             folder=T)

stacked<-stack(test_raster)
plot(stacked)
test_df<-rasterToPoints(stacked)
View(test_df)
head(test_df)
test_df$ratio<-test_df$NEON_D06_KONZ_DP3_702000_4325000_MSI/test_df$ratio

#can you isolate canopy and soil water contetnf rom these?