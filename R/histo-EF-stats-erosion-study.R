setwd("/media/alessandro/Seagate Expansion Drive/erosion-study/")
library(ggplot2)
library(dplyr)
library(kSamples)

histo.raw.data <- read.csv("/media/alessandro/Seagate Expansion Drive/erosion-study/clean-histo-parameters-erosion-study-images-EF.csv", stringsAsFactors = FALSE)
histo.raw.data$erosion.steps <- c(1,2,3,4,5,0)
histo.raw.data$filling <- c(71.7765856408,47.1807692322,37.138316429,38.8373284466,49.2400051092,94.4141350421)
  
#par(mfrow=c(2,5))
for (sampleNumber in 1:6) {
  png(filename=paste0("histogram-erosion-",histo.raw.data$erosion.steps[sampleNumber],".png"))
  normalisation.factor <- 1.0/sum(histo.raw.data[sampleNumber,2:51])
  barplot(unlist(histo.raw.data[sampleNumber,2:51])*normalisation.factor, las=2, xlab=paste0("EF, filling ",histo.raw.data$filling[sampleNumber]," %"), main=paste0(histo.raw.data$erosion.steps[sampleNumber], " erosion steps"), ylim=c(0,0.11), xaxt="n")
  axis.label <- seq(-1,1,length.out=11)
  axis(side=1,las=2,at=seq(0.1,60.5,6), label=axis.label)
  dev.off()
}
dev.off()