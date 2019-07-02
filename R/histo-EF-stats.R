setwd("/media/alessandro/Seagate Expansion Drive/disuse-OP-study/")

#set upt
show.filling<-FALSE
nBins <- 200
#nBins <- 50
kuerzels <- c("EF","BC","AB")#,"A","B","C")

#dummy values - will catch bugs
bins <- seq(0,0.98,length.out = 3)
top.range <- -2
bottom.range <- -2

for(kuerzel in kuerzels)
{
  if(kuerzel=="A") {bins <- seq(0, 10, length=nBins); bottom.range <- 0; top.range <-  10}
  if(kuerzel=="B") {bins <- seq(0, 25, length=nBins); bottom.range <- 0; top.range <-  25}
  if(kuerzel=="C") {bins <- seq(0, 100, length=nBins); bottom.range <- 0; top.range <- 100}
  
  if(kuerzel=="AB") {bins <- seq(0, 1, length=nBins); bottom.range <- 0; top.range <- 1; histo.disuse <- histo.disuse[,c(1,26:51)];}
  if(kuerzel=="BC") {bins <- seq(0, 1, length=nBins); bottom.range <- 0; top.range <- 1; histo.disuse <- histo.disuse[,c(1,26:51)];}
  if(kuerzel=="EF") {bins <- seq(-1,1,length.out = nBins); bottom.range <- -1; top.range <- 1}
  
  histo.disuse <- read.csv(paste0("clean-histogram-data-rep-dev-",kuerzel,".csv"), stringsAsFactors=FALSE)
  #histo.disuse <- read.csv(paste0(kuerzel,"-histo-parameters-disuse-averaged-clean",".csv"), stringsAsFactors=FALSE)
  histo.disuse <- histo.disuse[order(histo.disuse$name),]
  bv.tv <- read.csv("bv-tv-tmp-sam.csv", stringsAsFactors=FALSE)
  filling <- read.csv("filling.csv", stringsAsFactors = FALSE)
  histo.disuse <- as.data.frame(histo.disuse)
  smi.data <- read.csv("smi-bvtv-65days-med3thr85.csv", stringsAsFactors=FALSE)
  colors <- c('blue','red')       
  states <- c('control leg','disuse leg')
  normalise <- TRUE
  ylimit <- 90000
  norm.string <- ""
  
  for(timepoint in c(1,2,3)){
    day <- as.numeric( sub("\\D*(\\d+).*", "\\1", histo.disuse[8*(timepoint-1)+1,1]) )
    pdf(paste0(kuerzel,day,"-avg.pdf"),paper="a4",width=8.27, height=11.69)
    par(mfrow=c(4,3), oma=c(0,0,10,0))
    day.label <- paste0(day," days after neurectomy to the right limb")
  
    newbins <- rep("",length(bins))
    for(i in 1:10) {
      newbins[3+(i-1)*5] <- round(bins[3+(i-1)*5],digits=2)
    }
    for(sampleID in 8*(timepoint-1)+1:8){
      hist.data <- as.numeric(gsub("L","",histo.disuse[sampleID,-1]))
      index <- (sampleID-1)%%2+1
      mouseid <- 4
      if(timepoint==1) mouseid <-3
      sample.label <- paste0("mouse ",ceiling(sampleID/2),", ")
      if(show.filling) {
        ef.label <- paste0(kuerzel," (filling: ",round(filling$filling.percentage[sampleID],digits = 1),'%), ')
      }
      else{
        ef.label <- paste0(kuerzel," ")
      }
      main.label <- paste0(ef.label,sample.label,states[index])
      smi.info <- paste0("SMI (SMI+/SMI-):\n ",smi.data[sampleID, 5]," (",smi.data[sampleID, 3],"/",smi.data[sampleID,4],")\n Concave fraction: ",smi.data$Concave[sampleID])
      if(normalise)
      {
        hist.data <- hist.data/sum(hist.data)
        ylimit <- 0.08*50/nBins
        #ylimit <- 0.2
        norm.string <- " normalised "
      }
      barplot(hist.data, las=2, xlab="", col = colors[index], ylim = c(0,ylimit), main=main.label)
      #axis.label <- seq(-1,1,0.2)
      #axis.label[1] <- "plate -1"
      #axis.label[length(axis.label)] <- "rod 1"
      #axis(side=1,las=2,at=seq(0.1,60.1,6), label=axis.label)
      axis.label <- seq(bottom.range,top.range,length.out=11)
      axis(side=1,las=2,at=seq(0.1,nBins/50*60.1,nBins/50*6), label=axis.label)
      #axis(side=1,las=2,at=seq(0.1,30.1,3), label=axis.label)
      mtext(smi.info, side=1, line=4, cex=0.5)
      if((sampleID-1)%%2==1)
      {
        prev.hist.data <- as.numeric(gsub("L","",histo.disuse[sampleID-1,-1]))
        if(normalise)
        {
          prev.hist.data <- prev.hist.data/sum(prev.hist.data)
        }
        diff.hist.data <- prev.hist.data-hist.data
        
        breaks <- seq(bottom.range,top.range,length.out=nBins+1)
        samplesize=100
        simulated.bins=sample(nBins,samplesize,p=hist.data,replace=TRUE) # choose a bin
        simulated.result=runif(length(simulated.bins),breaks[simulated.bins],breaks[simulated.bins+1]) # sample a uniform in it

        prev.simulated.bins=sample(nBins,samplesize,p=prev.hist.data,replace=TRUE) # choose a bin
        prev.simulated.result=runif(length(prev.simulated.bins),breaks[prev.simulated.bins],breaks[prev.simulated.bins+1]) # sample a uniform in it
        
        KSpval <- round(ks.test(prev.simulated.result, simulated.result)$p.value, digits = 9)
              
        p.value.label <- paste0("Control vs Disuse ",kuerzel," distribution \n KS test, p=",KSpval)
        barplot(diff.hist.data, las=2, xlab="", col = "green", ylim = c(-ylimit,ylimit), main=paste0(sample.label,"control minus disuse"), ylab="> disuse \U2190 | \U2192 > control")
        mtext(p.value.label, side=1, line=4, cex=0.65)
        #axis(side=1,las=2,at=seq(0.1,60.1,6), label=seq(-1,1,0.2))
        axis.label <- seq(bottom.range,top.range,length.out=11)
        axis(side=1,las=2,at=seq(0.1,nBins/50*60.1,nBins/50*6), label=axis.label)
        #axis(side=1,las=2,at=seq(0.1,30.1,3), label=axis.label)
      }
    }
    
    title(paste0("trabecular compartment, proximal tibial metaphysis \n\n",kuerzel,norm.string,"distributions\n SMI/SMI+/SMI-/Concave Fraction \n\n ",day.label, "\n control <BV/TV> = ",bv.tv$bv.tv.control[bv.tv$day==day], "\n disuse <BV/TV> = ",bv.tv$bv.tv.disuse[bv.tv$day==day]), outer=TRUE)
    dev.off()
  }
}
#raw.data <- read.csv("raw-data-EF.csv", stringsAsFactors=FALSE)