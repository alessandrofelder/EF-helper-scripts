clean.combined.logfile <- read.csv("/media/alessandro/Seagate Expansion Drive/iteration-study/clean-combined-logfile.csv", comment.char="#")

emu.data <- clean.combined.logfile[which(clean.combined.logfile$file=="emu.tif"),]
shrew.data <- clean.combined.logfile[which(clean.combined.logfile$file=="shrew.tif"),]

plot(clean.combined.logfile$maxIterations,clean.combined.logfile$time,col=clean.combined.logfile$file)
legend(700,1300,legend = c("emu","shrew"),pch=1, col = clean.combined.logfile$file)
