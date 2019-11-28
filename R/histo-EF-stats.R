setwd("/media/alessandro/Seagate Expansion Drive/disuse-study-final-with-topo/")
library(ggplot2)
library(dplyr)
library(kSamples)

#set upt
show.filling<-FALSE
nBins <- 50
smoothing.factors <- c(1)#,2,4,8,20)
kuerzels <- c("EF")#c("EF","BC","AB","A","B","C")

for(smoothing.factor in smoothing.factors){
  getInfoFromName <- function(namestring){
    #file names are {timepoint}.{mouseid}{"R"/""}
    split.string <- strsplit(namestring,"\\.")
    timepoint <- as.numeric(unlist(split.string)[1])
    mouseID <- as.numeric(substr(unlist(split.string)[2],1,1))
    if(mouseID==6){
      mouseID <- 2 # clean one dirty data label
    }
    # neurectomy made to right limb
    is.disuse <- grepl("R",namestring)
    c(timepoint, mouseID, is.disuse)
  }
  
  getSpecificData <- function(large.data.frame, timepoint, variable, is.disuse)
  {
    test.data <- large.data.frame
    test.data <- test.data[test.data$timepoint==timepoint & test.data$is.disuse==is.disuse & test.data$variable==variable,]
    final.data <- cbind(bind_rows(replicate(nBins, test.data[,1:5], simplify = FALSE)),sort(rep(1:(nBins/smoothing.factor),1)))
    colnames(final.data)[6] <- "bin.number"
    bin.density <- as.vector(as.matrix(test.data[,6:(6+nBins/smoothing.factor-1)]))
    final.data <- cbind(final.data,bin.density)
    return(final.data)
  }
  
  #dummy values - will catch bugs
  bins <- seq(0,0.98,length.out = 3)
  top.range <- -2
  bottom.range <- -2
  
  overall.overall.data <- as.data.frame(matrix(nrow=24,ncol=0))
  
  for(kuerzel in kuerzels)
  {
    if(kuerzel=="A") {bins <- seq(0, 10, length=nBins/smoothing.factor); bottom.range <- 0; top.range <-  10}
    if(kuerzel=="B") {bins <- seq(0, 25, length=nBins/smoothing.factor); bottom.range <- 0; top.range <-  25}
    if(kuerzel=="C") {bins <- seq(0, 100, length=nBins/smoothing.factor); bottom.range <- 0; top.range <- 100}
    
    if(kuerzel=="AB") {bins <- seq(0, 1, length=nBins/smoothing.factor); bottom.range <- 0; top.range <- 1; histo.disuse <- histo.disuse[,c(1,26:51)];}
    if(kuerzel=="BC") {bins <- seq(0, 1, length=nBins/smoothing.factor); bottom.range <- 0; top.range <- 1; histo.disuse <- histo.disuse[,c(1,26:51)];}
    if(kuerzel=="EF") {bins <- seq(-1,1,length.out = nBins/smoothing.factor); bottom.range <- -1; top.range <- 1}
    
    #histo.disuse <- read.csv(paste0("clean-histogram-data-rep-dev-",kuerzel,".csv"), stringsAsFactors=FALSE)
    
    histo.disuse <- read.csv("/media/alessandro/Seagate Expansion Drive/disuse-study-final-with-topo/histo-parameters-disuse-study-with-topo-EF.csv", stringsAsFactors = FALSE)
    #histo.disuse <- read.csv(paste0(kuerzel,"-histo-parameters-disuse-averaged-clean",".csv"), stringsAsFactors=FALSE)
    histo.disuse <- histo.disuse[order(histo.disuse$name),]
    histo.disuse <- histo.disuse[histo.disuse$name!="name",]
    k<-c()
    if(nchar(kuerzel)==2){
      k <- kuerzel
    } else {
      k<-paste0(kuerzel,"-")
    }
    #histo.disuse <- histo.disuse[grepl(paste0(k,"6"),histo.disuse$name),]
    #bv.tv <- read.csv("bv-tv-tmp-sam.csv", stringsAsFactors=FALSE)
    filling <- read.csv("filling.csv", stringsAsFactors = FALSE)
    #histo.disuse <- as.data.frame(histo.disuse)
    #smi.data <- read.csv("smi-bvtv-65days-med3thr85.csv", stringsAsFactors=FALSE)
    colors <- c('blue','red')       
    states <- c('control leg','disuse leg')
    normalise <- TRUE
    ylimit <- 90000
    norm.string <- ""
    
    overall.data <- as.data.frame(matrix(nrow = nrow(histo.disuse),ncol = 5+nBins/smoothing.factor))
    colnames(overall.data) <- c("name","variable","timepoint","mouseID","is.disuse",unlist(1:(nBins/smoothing.factor)))
    for(timepoint in c(1,2,3)){
      day <- as.numeric( sub("\\D*(\\d+).*", "\\1", histo.disuse[8*(timepoint-1)+1,1]) )
      pdf(paste0("histograms/",kuerzel,day,"-avg6-nbins-",nBins/smoothing.factor,".pdf"),paper="a4",width=8.27, height=11.69)
      par(mfrow=c(4,3), oma=c(0,0,10,0))
      day.label <- paste0(day," days after neurectomy to the right limb")
    
      newbins <- rep("",length(bins))
      for(i in 1:10) {
        newbins[3+(i-1)*5] <- round(bins[3+(i-1)*5],digits=2)
      }
      for(sampleID in 8*(timepoint-1)+1:8){
        #hist.data <- as.numeric(gsub("L","",histo.disuse[sampleID,-1]))
        step <- smoothing.factor
        temp.hist.data <- matrix(NA,1,nBins/smoothing.factor)
        for(j in 1:(nBins/smoothing.factor)){
          temp.hist.data[1,j] <- sum(histo.disuse[sampleID,(2+step*(j-1)):(2+step*j-1)])
        }
        hist.data <- temp.hist.data
        
        index <- (sampleID-1)%%2+1
        sample.label <- paste0("mouse ",ceiling(sampleID/2),", ")
        if(show.filling) {
          ef.label <- paste0(kuerzel," (filling: ",round(filling$filling.percentage[sampleID],digits = 1),'%), ')
        }
        else{
          ef.label <- paste0(kuerzel," ")
        }
        main.label <- paste0(ef.label,sample.label,states[index])
        if(normalise)
        {
          hist.data <- hist.data/sum(hist.data)
          ylimit <- 0.08*50/nBins*smoothing.factor
          #ylimit <- 0.2
          norm.string <- " normalised "
        }
        if(nchar(kuerzel)==1){
          ylimit <- ylimit*2
        }
        hist.name <- histo.disuse$name[sampleID]
        hist.info <- getInfoFromName(hist.name)
        
        overall.data[sampleID,] <- c(hist.name, kuerzel, unlist(hist.info), unlist(hist.data))
        barplot(hist.data, las=2, xlab="", col = colors[index], ylim = c(0,ylimit), main=main.label)
        #axis.label <- seq(-1,1,0.2)
        #axis.label[1] <- "plate -1"
        #axis.label[length(axis.label)] <- "rod 1"
        #axis(side=1,las=2,at=seq(0.1,60.1,6), label=axis.label)
        axis.label <- seq(bottom.range,top.range,length.out=11)
        axis(side=1,las=2,at=seq(0.1,nBins/50/smoothing.factor*60.5,nBins/50/smoothing.factor*6), label=axis.label)
        #axis(side=1,las=2,at=seq(0.1,30.1,3), label=axis.label)
        if((sampleID-1)%%2==1)
        {
          #prev.hist.data <- as.numeric(gsub("L","",histo.disuse[sampleID-1,-1]))
          temp.hist.data <- matrix(NA,1,nBins/smoothing.factor)
          for(j in 1:(nBins/smoothing.factor)){
            temp.hist.data[1,j] <- sum(histo.disuse[sampleID-1,(2+step*(j-1)):(2+step*j-1)])
          }
          prev.hist.data <- temp.hist.data
          if(normalise)
          {
            prev.hist.data <- prev.hist.data/sum(prev.hist.data)
          }
          diff.hist.data <- prev.hist.data-hist.data
          
          breaks <- seq(bottom.range,top.range,length.out=nBins/smoothing.factor+1)
          samplesize=nBins/smoothing.factor
          simulated.bins=sample(nBins/smoothing.factor,200,p=hist.data,replace=TRUE) # choose a bin
          simulated.result=runif(length(simulated.bins),breaks[simulated.bins],breaks[simulated.bins+1]) # sample a uniform in it
  
          prev.simulated.bins=sample(nBins/smoothing.factor,samplesize,p=prev.hist.data,replace=TRUE) # choose a bin
          prev.simulated.result=runif(length(prev.simulated.bins),breaks[prev.simulated.bins],breaks[prev.simulated.bins+1]) # sample a uniform in it
          
          #KSpval <- round(ks.test(hist.data, prev.hist.data)$p.value, digits = 5)
          KSpval <- round(ad.test(hist.data, prev.hist.data)$ad[5], digits = 5)
          
          p.value.label <- paste0("Control vs Disuse ",kuerzel," distribution \n KS test, p=",KSpval)
          barplot(diff.hist.data, las=2, xlab="", col = "green", ylim = c(-ylimit,ylimit), main=paste0(sample.label,"control minus disuse"), ylab="> disuse \U2190 | \U2192 > control")
          mtext(p.value.label, side=1, line=4, cex=0.65)
          #axis(side=1,las=2,at=seq(0.1,60.1,6), label=seq(-1,1,0.2))
          axis.label <- seq(bottom.range,top.range,length.out=11)
          axis(side=1,las=2,at=seq(0.1,nBins/50/smoothing.factor*60.5,nBins/50/smoothing.factor*6), label=axis.label)
          #axis(side=1,las=2,at=seq(0.1,30.1,3), label=axis.label)
        }
      }
      
      title(paste0("trabecular compartment, proximal tibial metaphysis \n\n",kuerzel,norm.string,"distributions\n",day.label, outer=TRUE))
      dev.off()
    }
    overall.overall.data <- rbind(overall.overall.data, overall.data)
  }
  #raw.data <- read.csv("raw-data-EF.csv", stringsAsFactors=FALSE)
  #test <- matrix(NA,1,nBins/smoothing.factor)
  #step <- smoothing.factor
  #for(j in 1:(nBins/smoothing.factor)){
  #  print(j)
  #  test[1,j] <- sum(histo.disuse[1,(2+step*(j-1)):(2+step*j-1)])
  #}
  
  for(timepoint in c(5,35,65)){
    for(is.disuse in c(0,1)){
      for(variable in kuerzels) {
        final.data <- getSpecificData(overall.overall.data,timepoint,variable,is.disuse)
        data1<- as.numeric(as.character(final.data$bin.density[final.data$mouseID==1]))
        data2<- as.numeric(as.character(final.data$bin.density[final.data$mouseID==2]))
        data3<- as.numeric(as.character(final.data$bin.density[final.data$mouseID==3]))
        data4<- as.numeric(as.character(final.data$bin.density[final.data$mouseID==4]))
        ad.test.results <- ad.test(data1,data2,data3,data4)
        p.value <- round(ad.test.results$ad[5],3)
        
        if(kuerzel=="A") {bins <- seq(0, 10, length=nBins/smoothing.factor); bottom.range <- 0; top.range <-  10}
        if(kuerzel=="B") {bins <- seq(0, 25, length=nBins/smoothing.factor); bottom.range <- 0; top.range <-  25}
        if(kuerzel=="C") {bins <- seq(0, 100, length=nBins/smoothing.factor); bottom.range <- 0; top.range <- 100}
        
        if(kuerzel=="AB") {bins <- seq(0, 1, length=nBins/smoothing.factor); bottom.range <- 0; top.range <- 1; histo.disuse <- histo.disuse[,c(1,26:51)];}
        if(kuerzel=="BC") {bins <- seq(0, 1, length=nBins/smoothing.factor); bottom.range <- 0; top.range <- 1; histo.disuse <- histo.disuse[,c(1,26:51)];}
        if(kuerzel=="EF") {bins <- seq(-1,1,length.out = nBins/smoothing.factor); bottom.range <- -1; top.range <- 1}
        
        p <- ggplot(final.data,aes(mouseID,bin.number))+geom_tile(aes(fill=as.numeric(as.character(bin.density))))
        is.disuse.string <- NA
        if(is.disuse==1){
          is.disuse.string <- "Disuse"
        } else {
          is.disuse.string <- "Control"
        }
        p <- p+ggtitle(paste0(variable," at day ",timepoint,", ",is.disuse.string, ", AD p = ", p.value))
        p <- p+labs(fill="frequency")
        approx.max <- round(max(data4,data1,data2,data3)+0.1,1)
        brks <- c(0,0.25,0.5,0.75,1)*approx.max
        p <- p+scale_fill_gradientn(colours=topo.colors(7),na.value = "transparent",
                                    breaks=brks,labels=brks,
                                    limits=c(0,approx.max))
        p <- p + theme_bw()
        p <- p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank())
        if(p.value < 0.05){
          show(p)
          ggsave(paste0("heatmaps/heatmap-",variable,"-day-",timepoint,"-",is.disuse.string,"-AD-test-significant-5percent-level-with-",nBins/smoothing.factor,"-bins.pdf"),p,width=10,height=10,units="cm")
        }
      }
    }
  }
}
