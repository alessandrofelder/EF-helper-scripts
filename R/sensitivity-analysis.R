library(ggplot2)
library(grid)
library(gridExtra)

doAnalysis <- function(study.name)
{
  wd = paste0("/media/alessandro/Seagate Expansion Drive/",study.name,"-study/")
  for (sample.string in c("emu.tif", "shrew.tif", "rods_plates.tif"))
  {
    filename <- paste0(gsub(".tif","",sample.string),paste0("_",study.name))
    timing.data <- read.csv(paste0(wd,filename,".txt"), comment.char="#")
    
    all.sensitivity.data <- read.csv(paste0(wd,filename,".txt-table"), row.names=1, quote="", comment.char="#", stringsAsFactors=FALSE)
    all.sensitivity.data <- as.data.frame(t(all.sensitivity.data[,-dim(all.sensitivity.data)[2]]))
    
    data<-cbind(all.sensitivity.data,timing.data)
  
  
    print(sample.string)
    sample.data <- data[data$file==sample.string,]
    print(dim(sample.data))
    plt.timing <- ggplot(data = sample.data,aes(runs, time/60, color = factor(weighted), shape = factor(skipRatio)))+geom_point()
    plt.timing <- plt.timing + ggtitle(gsub(".tif","",sample.string)) + theme_bw() + theme(legend.position=c(0.15,0.7)) + xlab("total runs")+ylab("time [min]")+ labs(color="weighted",shape="skip ratio")
    
    plt.filling <- ggplot(data = sample.data,aes(runs, as.numeric(as.character(sample.data$`filling percentage`)), color = factor(weighted), shape = factor(skipRatio)))+geom_point(show.legend = FALSE)
    plt.filling <- plt.filling + ggtitle("") + theme_bw() +xlab("total runs)") + ylab("% foreground filled") +ylim(c(60,100))
    
    
    #plt.ellipsoids <- ggplot(data = sample.data,aes(log10(runs)/log10(2), as.numeric(as.character(sample.data$`number of ellipsoids found in total`)), color = factor(weighted), shape = factor(skipRatio)))+geom_point(show.legend = FALSE)
    #plt.ellipsoids <- plt.ellipsoids + ggtitle(sample.string) + theme_bw() + ylab("total ellipsoids found")
    
    median.data <- cbind(as.numeric(as.character(sample.data$`median change 1`)),
                         as.numeric(as.character(sample.data$`median change 2`)),
                         as.numeric(as.character(sample.data$`median change 3`)),
                         as.numeric(as.character(sample.data$`median change 4`)),
                         as.numeric(as.character(sample.data$`median change 5`)),
                         as.numeric(as.character(sample.data$`median change 6`)),
                         as.numeric(as.character(sample.data$`median change 7`)))
    
    maximum.data <- cbind(as.numeric(as.character(sample.data$`maximum change 1`)),
                         as.numeric(as.character(sample.data$`maximum change 2`)),
                         as.numeric(as.character(sample.data$`maximum change 3`)),
                         as.numeric(as.character(sample.data$`maximum change 4`)),
                         as.numeric(as.character(sample.data$`maximum change 5`)),
                         as.numeric(as.character(sample.data$`maximum change 6`)),
                         as.numeric(as.character(sample.data$`maximum change 7`)))
    
    number.of.runs <- dim(median.data)[2]
    error.runs <- t(matrix(rep(c(1:number.of.runs),length(sample.data$weighted)),ncol=length(sample.data$weighted)))
    error.weighted <- matrix(rep(sample.data$weighted,number.of.runs),ncol=number.of.runs)
    error.skipRatio <- matrix(rep(sample.data$skipRatio,number.of.runs),ncol=number.of.runs)
    
    plt.errors.med <- ggplot()
    plt.errors.max <- ggplot()
    for(i in 1:number.of.runs)
    {
      plt.errors.med <- plt.errors.med+geom_point(aes_string(error.runs[,i], median.data[,i], color = factor(error.weighted[,i]),shape = factor(error.skipRatio[,i])),show.legend = FALSE)
      plt.errors.max <- plt.errors.max+geom_point(aes_string(error.runs[,i], maximum.data[,i], color = factor(error.weighted[,i]),shape = factor(error.skipRatio[,i])),show.legend = FALSE)
    }
    plt.errors.med <- plt.errors.med + xlab("run number") + ggtitle("") + theme_bw() + ylab("median pixel change (EF)")+ylim(c(0,2))
    plt.errors.max <- plt.errors.max + xlab("run number") + ggtitle("")+theme_bw()+theme(legend.position=c(0.9,0.7))+ylab("maximum pixel change (EF)")+ylim(c(0,2))+labs(color="weighted")+labs(shape="skip ratio")
    
    p<-grid.arrange(plt.timing, plt.filling, plt.errors.med, plt.errors.max, nrow = 2)
    
    ggsave(paste0(wd,gsub(".tif","",sample.string),"-",study.name,".png"), plot = p, device = "png", width = 8.27, height = 8.27, units = "in")
    
    ## need to add histograms here
  }
}

doAnalysis("sensitivity")
doAnalysis("drift")
#doAnalysis("vertebrae")
#doAnalysis("disuse")