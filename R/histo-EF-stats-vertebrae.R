setwd("/media/alessandro/Seagate Expansion Drive/vertebra-study-small-step/")
library(ggplot2)
library(dplyr)
library(kSamples)

histo.vertebrae <- read.csv("/media/alessandro/Seagate Expansion Drive/vertebra-study-small-step/clean-histo-parameters-vertebra-small-step-images-EF.csv", stringsAsFactors = FALSE)
histo.vertebrae$age <- c(92,88,86,24,84,84,84,86,69,32)

ids<-strsplit(histo.vertebrae[,1],"-")
for(i in 1:length(ids)){
  ids[i] <- as.numeric(as.character(unlist(ids[i])[3]))
}
ids <- unlist(ids)
histo.vertebrae$ids <- ids

modes <- c()
bin.centres <- seq(-1,0.96,length=50)+0.02
#par(mfrow=c(2,5))
for (sampleNumber in 1:length(histo.vertebrae$age)) {
  png(filename=paste0("histogram-vertebra-",histo.vertebrae$ids[sampleNumber],".png"))
  normalisation.factor <- 1.0/sum(histo.vertebrae[sampleNumber,2:51])
  barplot(cex.main = 2.5, cex.axis = 1.5, cex.names = 1.5, cex.lab = 2, unlist(histo.vertebrae[sampleNumber,2:51])*normalisation.factor, las=2, xlab="EF", main=paste0("sample ", histo.vertebrae$ids[sampleNumber]), ylim=c(0,0.06), xaxt="n")
  axis.label <- seq(-1,1,length.out=11)
  axis(side=1,las=2,at=seq(0.1,60.5,6), label=axis.label, cex.axis=1.5)
  dev.off()
  modes <- c(modes,bin.centres[which.max(unlist(histo.vertebrae[sampleNumber,2:51]))])
}

vertebra.data <- t(read.csv("/media/alessandro/Seagate Expansion Drive/vertebra-study-small-step/logfile-2019-10-09 11:33:00.txt-table", header=FALSE, comment.char="#"))
id.map <- read.csv("/media/alessandro/Seagate Expansion Drive/vertebra-study-small-step/id-map.csv", comment.char="#")
setwd("/media/alessandro/Seagate Expansion Drive/vertebra-study-small-step/plots/")

colnames(vertebra.data)<-vertebra.data[1,]
vertebra.data <- vertebra.data[2:11,]
ids<-strsplit(vertebra.data[,1],"-")
for(i in 1:length(ids)){
  ids[i] <- as.numeric(as.character(unlist(ids[i])[3]))
}
ids <- unlist(ids)

standard.parameters <- read.csv("/media/alessandro/Seagate Expansion Drive/vertebra-study-small-step/standard-parameters.csv")
colnames(standard.parameters)[4] <- "SMI+"
colnames(standard.parameters)[5] <- "SMI-"

v <-as.data.frame(vertebra.data)
v$age <- c(92,88,86,24,84,84,84,86,69,32)
v$BVTV <- standard.parameters$BV.TV
v$thickness <- standard.parameters$Tb.Th.Mean..mm.
v$thicknessMax <- standard.parameters$Tb.Th.Max..mm.
v$SMI <- standard.parameters$SMI
v$SMIp <- standard.parameters$`SMI+`
v$SMIm <- standard.parameters$`SMI-`
v$modes <- modes

png(filename = "bvtv-convergence.png", width = 1480, height = 480)
par(mfrow=c(1,3),mar=c(7,7,5,5))
plot(v$BVTV,as.numeric(as.character(v$`filling percentage`)), pch=19,cex.lab=2.5,cex.axis=2,cex.main=2.5,cex=3, xlab = "bone volume fraction", ylab = "Filling", main = "Convergence (Filling percentage)")
plot(v$BVTV,as.numeric(as.character(v$`maximum change 5`)), pch=19,cex.lab=2.5,cex.axis=2,cex.main=2.5,cex=3, xlab = "bone volume fraction", ylab = "maximum change in EF between final two runs", main = "Convergence (Maximum)")
plot(v$BVTV,as.numeric(as.character(v$`median change 5`)), pch=19,cex.lab=2.5,cex.axis=2,cex.main=2.5,cex=3, xlab = "bone volume fraction", ylab = "median change in EF between final two runs", main = "Convergence (Median)")
dev.off()

png(filename = "bvtv-EF.png", width = 480, height = 480)
par(mfrow=c(1,1))
plot(v$BVTV,as.numeric(as.character(v$`Median EF`)), pch=21, bg=rgb(237,73,1,maxColorValue = 255),cex=2, xlab="bone volume fraction", ylab = "EF",ylim=c(-1,1))
points(v$BVTV,as.numeric(as.character(v$`Max EF`)), pch=21, bg=rgb(1,0.988,0.29,maxColorValue = 1),cex=2)
points(v$BVTV,as.numeric(as.character(v$`Min EF`)), pch=21, bg=rgb(0.21,0,0.67,maxColorValue = 1), cex=2)
points(v$BVTV, v$modes, pch=21,cex=2)
legend(0.15,0.7,c("median","maximum","minimum","mode"), pch=c(21,21,21,21),pt.bg=c(rgb(237,73,1,maxColorValue = 255),rgb(1,0.988,0.29,maxColorValue = 1),rgb(0.21,0,0.67,maxColorValue = 1),"white"))
dev.off()

png(filename = "bvtv-age.png", width = 1920, height = 480)
par(mfrow=c(1,4),mar=c(7,7,5,5))
#bg=rgb(222,222,222,maxColorValue = 255), #grey background

test <- cor.test(v$age,v$BVTV, method="spearman")
plot(v$BVTV,v$age, pch=19, cex.lab=2.5,cex.axis=2,cex=3,cex.main=2.5, xlab="bone volume fraction", ylab = "age [years]", main = substitute(paste("Spearman's ",rho," = ",nn,", p = ",n2), list(nn=round(test$estimate,2),n2=round(test$p.value,5))))

test <- cor.test(v$BVTV,v$SMI, method="spearman")

plot(v$BVTV,v$SMI, cex.lab=2.5,cex.axis=2,cex.main=2.5,cex=3, xlab="bone volume fraction", ylab = "SMI", main = substitute(paste("Spearman's ",rho," = ",nn,", p = ",n2), list(nn=round(test$estimate,2),n2=round(test$p.value,5))),ylim=c(-1,4))
points(v$BVTV,v$SMIp, pch=3, bg=rgb(255,255,255,maxColorValue = 255),cex=3)
points(v$BVTV,v$SMIm, pch='-', bg=rgb(255,255,255,maxColorValue = 255),cex=3)
legend(0.16,4,c("SMI","SMI+","SMI-"),pch=c('o','+','-'), cex=2)

test <- cor.test(v$BVTV,v$thickness, method="spearman")
plot(v$BVTV,v$thickness, pch=19, cex.lab=2.5,cex.axis=2,cex=3,cex.main=2.5,xlab="bone volume fraction", ylab = "Mean trabecular thickness [mm]", main = substitute(paste("Spearman's ",rho," = ",nn,", p = ",n2), list(nn=round(test$estimate,2),n2=round(test$p.value,5))))

test <- cor.test(v$BVTV,v$thicknessMax, method="spearman")
plot(v$BVTV,v$thicknessMax, pch=19, cex.lab=2.5,cex.axis=2,cex=3,cex.main=2.5,xlab="bone volume fraction", ylab = "Maximum trabecular thickness [mm]", main = substitute(paste("Spearman's ",rho," = ",nn,", p = ",n2), list(nn=round(test$estimate,2),n2=round(test$p.value,5))))

dev.off()