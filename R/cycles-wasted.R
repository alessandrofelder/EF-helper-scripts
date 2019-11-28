filenames = c("shrew","emu")

max.non.na.length = 0
color.ramp <- hcl.colors(33)#33 comes from running this once and looking at value of max.non.na.length

for(filename in filenames)
{
  cycles.wasted <- read.csv(paste0("~/Documents/cycles-wasted-",filename,".txt"), header=FALSE, row.names = NULL, na.strings=c(""," ","NA"));
  iterations.until.improvement <- cycles.wasted[c(TRUE,FALSE),]
  gradual.improvements <- cycles.wasted[c(FALSE,TRUE),]
  
  png(paste0("~/Documents/",filename,".png"))
  indices <- !is.na(iterations.until.improvement[1,])
  if(length(indices[indices])>max.non.na.length){
    max.non.na.length <- length(indices[indices])
  }
  flattened.iterations <- as.numeric(iterations.until.improvement[1,indices])
  plot(main=paste0("For ",filename," with typical parameters:"),pch=3,cex=0.1,
       as.numeric(iterations.until.improvement[1,indices]),log10(as.numeric(gradual.improvements[1,indices])),
       ylim = c(0,log10(50000)),xlim=c(0,102),
       ylab="log10(improvement in volume) [cubic pixels]",xlab="number of iterations tried until improvement found",
       col = color.ramp[indices]
       )
  legend(100,4.8,legend=1:33,col = color.ramp, cex=0.4,pch=3)
  for(i in 2:length(as.numeric(iterations.until.improvement[,1])))
  {
    indices <- !is.na(iterations.until.improvement[i,])
    if(length(indices[indices])>max.non.na.length){
      max.non.na.length <- length(indices[indices])
    }
    points(pch=3,cex=0.1,as.numeric(iterations.until.improvement[i,indices]),log10(as.numeric(gradual.improvements[i,indices])),col = color.ramp[indices])
    flattened.iterations <- append(flattened.iterations,as.numeric(iterations.until.improvement[i,indices]))
  }
  dev.off()
  png(paste0("~/Documents/",filename,"-iteration-histogram.png"))
  histogram <- hist(flattened.iterations, xlab = "iterations until improvement found", main = paste0("Iteration histogram for ", filename, " with typical parameters"))
  sorted.flattened.iterations <- sort(flattened.iterations)
  l <- length(sorted.flattened.iterations)
  equal.chance.iterations <- sorted.flattened.iterations[l-2*length(as.numeric(iterations.until.improvement[,1]))]
  print(equal.chance.iterations)
  dev.off()
}
