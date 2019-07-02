mustela <- read.delim("~/Documents/code/EF-test-images/mustela.csv", header=FALSE)
somateria <- read.delim("~/Documents/code/EF-test-images/somateria.csv", header=FALSE)

par(mfrow = c(2,1))
barplot(mustela$V3/sum(mustela$V3),main="Mustela EF")
barplot(somateria$V3/sum(somateria$V3),main="Somateria EF")
ks.test(mustela$V3/sum(mustela$V3),somateria$V3/sum(mustela$V3))

