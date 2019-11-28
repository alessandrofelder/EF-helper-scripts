setwd("/media/alessandro/Seagate Expansion Drive/filter-contact-step-study/")
library(ggplot2)
library(dplyr)
library(kSamples)

histo.raw.data <- read.csv("/media/alessandro/Seagate Expansion Drive/filter-contact-step-study/clean-histo-parameters-filter-contact-step-EF.csv", stringsAsFactors = FALSE)
histo.raw.data$filling <- c(61.811768579,62.389406659,58.2271099023,74.5642762149,73.7532104794,70.7335439251,59.9817103919,60.1238990309,58.1894855656,74.0881193319,73.0514643444,70.9830141797,57.1653197677,55.4748896745,46.1293702365,72.053322046,69.4420885687,63.1431997931,51.8734045583,48.5068102662,38.2917506029,68.2034640518,63.9952342507,56.010827448)

  
#par(mfrow=c(2,5))
for (sampleNumber in 1:24) {
  png(filename=paste0("histogram-filter-",histo.raw.data$filter[sampleNumber],"-contact-",histo.raw.data$contact[sampleNumber],"-step-",histo.raw.data$step[sampleNumber],".png"))
  normalisation.factor <- 1.0/sum(histo.raw.data[sampleNumber,2:51])
  barplot(unlist(histo.raw.data[sampleNumber,2:51])*normalisation.factor, las=2, xlab="EF", main=paste0("filling ",round(histo.raw.data$filling[sampleNumber],3), "%"), ylim=c(0,0.11), xaxt="n")
  axis.label <- seq(-1,1,length.out=11)
  axis(side=1,las=2,at=seq(0.1,60.5,6), label=axis.label)
  dev.off()
}
dev.off()