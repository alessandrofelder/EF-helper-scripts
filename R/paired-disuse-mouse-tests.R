#data <- read.csv("/media/alessandro/Seagate Expansion Drive/disuse-study-final/logfile-2019-11-06 18:34:55.txt-table", header=TRUE, comment.char="#")
#print("distance-ridge-only")
data <- read.csv("/media/alessandro/Seagate Expansion Drive/disuse-study-final-with-topo/logfile-2019-11-10 18:40:31.txt-table", header=TRUE, comment.char="#")
print("distanc-ridge+topo-preserving")

#bonferroni correction

# at 5 days
data.5.days <- data[,grepl("X5",colnames(data))]

data.5.days.L <- data.5.days[,grepl("L",colnames(data.5.days))]
median.5.days.L <- data.5.days.L[13,]
max.5.days.L <- data.5.days.L[14,]
min.5.days.L <- data.5.days.L[15,]
filling.5.days.L <- data.5.days.L[16,]

data.5.days.R <- data.5.days[,grepl("R",colnames(data.5.days))]
median.5.days.R <- data.5.days.R[13,]
max.5.days.R <- data.5.days.R[14,]
min.5.days.R <- data.5.days.R[15,]
filling.5.days.R <- data.5.days.R[16,]

# at 35 days
data.35.days <- data[,grepl("X35",colnames(data))]

data.35.days.L <- data.35.days[,grepl("L",colnames(data.35.days))]
median.35.days.L <- data.35.days.L[13,]
max.35.days.L <- data.35.days.L[14,]
min.35.days.L <- data.35.days.L[15,]
filling.35.days.L <- data.35.days.L[16,]

data.35.days.R <- data.35.days[,grepl("R",colnames(data.35.days))]
median.35.days.R <- data.35.days.R[13,]
max.35.days.R <- data.35.days.R[14,]
min.35.days.R <- data.35.days.R[15,]
filling.35.days.R <- data.35.days.R[16,]

# at 65 days
data.65.days <- data[,grepl("X65",colnames(data))]

data.65.days.L <- data.65.days[,grepl("L",colnames(data.65.days))]
median.65.days.L <- data.65.days.L[13,]
max.65.days.L <- data.65.days.L[14,]
min.65.days.L <- data.65.days.L[15,]
filling.65.days.L <- data.65.days.L[16,]

data.65.days.R <- data.65.days[,grepl("R",colnames(data.65.days))]
median.65.days.R <- data.65.days.R[13,]
max.65.days.R <- data.65.days.R[14,]
min.65.days.R <- data.65.days.R[15,]
filling.65.days.R <- data.65.days.R[16,]

print("analysing day 5: ")
normality.test <- shapiro.test(as.numeric(median.5.days.L-median.5.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal median differences")
}
normality.test <- shapiro.test(as.numeric(min.5.days.L-min.5.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal min differences")
}
normality.test <- shapiro.test(as.numeric(max.5.days.L-max.5.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal max differences")
}

normality.test <- shapiro.test(as.numeric(filling.5.days.L-filling.5.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal filling differences")
}

med.test.5 <- t.test(as.numeric(median.5.days.L),as.numeric(median.5.days.R),paired = TRUE,alternative = 'l')
max.test.5 <- t.test(as.numeric(max.5.days.L),as.numeric(max.5.days.R),paired = TRUE)
min.test.5 <- t.test(as.numeric(min.5.days.L),as.numeric(min.5.days.R),paired = TRUE)
filling.test.5 <- t.test(as.numeric(filling.5.days.L),as.numeric(filling.5.days.R), paired = TRUE)

print(paste("median 5 test, p val: ", med.test.5$p.value))
print(paste("median 5 test, estimate of diff of means: ", med.test.5$estimate))
print(paste("max 5 test, p val: ", max.test.5$p.value))
print(paste("min 5 test, p val: ", min.test.5$p.value))
print(paste("filling 5 test, p val: ", filling.test.5$p.value))

np.med.test.5 <- wilcox.test(as.numeric(median.5.days.L),as.numeric(median.5.days.R),paired = TRUE,alternative = 'l')
np.max.test.5 <- wilcox.test(as.numeric(max.5.days.L),as.numeric(max.5.days.R),paired = TRUE)
np.min.test.5 <- wilcox.test(as.numeric(min.5.days.L),as.numeric(min.5.days.R),paired = TRUE)
np.filling.test.5 <- wilcox.test(as.numeric(filling.5.days.L),as.numeric(filling.5.days.R), paired = TRUE)

print(paste("nonp. median 5 test, p val: ", np.med.test.5$p.value))
print(paste("nonp. max 5 test, p val: ", np.max.test.5$p.value))
print(paste("nonp. min 5 test, p val: ", np.min.test.5$p.value))
print(paste("nonp. filling 5 test, p val: ", np.filling.test.5$p.value))

median.diff.sd <- sd(median.5.days.L-median.5.days.R)
power.result.5 <- power.t.test(n=4,power=0.8, sd=median.diff.sd, sig.level=0.05, alternative = "one.sided", type="paired")
print(paste("median EF: one-sided difference detectable at power 0.8 and significance level 0.05:",power.result.5$delta))


print("analysing day 35: ")
normality.test <- shapiro.test(as.numeric(median.35.days.L-median.5.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal median differences")
}
normality.test <- shapiro.test(as.numeric(min.35.days.L-min.5.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal min differences")
}
normality.test <- shapiro.test(as.numeric(max.35.days.L-max.35.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal max differences")
}
normality.test <- shapiro.test(as.numeric(filling.35.days.L-filling.35.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal filling differences")
}

med.test.35 <- t.test(as.numeric(median.35.days.L),as.numeric(median.35.days.R),paired = TRUE,alternative = 'l')
max.test.35 <- t.test(as.numeric(max.35.days.L),as.numeric(max.35.days.R),paired = TRUE)
min.test.35 <- t.test(as.numeric(min.35.days.L),as.numeric(min.35.days.R),paired = TRUE)
filling.test.35 <- t.test(as.numeric(filling.35.days.L),as.numeric(filling.35.days.R), paired = TRUE)

print(paste("median 35 test, p val: ", med.test.35$p.value))
print(paste("median 35 test, estimate of diff of means: ", med.test.35$estimate))
print(paste("max 35 test, p val: ", max.test.35$p.value))
print(paste("min 35 test, p val: ", min.test.35$p.value))
print(paste("filling 35 test, p val: ", filling.test.35$p.value))

np.med.test.35 <- wilcox.test(as.numeric(median.35.days.L),as.numeric(median.35.days.R),paired = TRUE,alternative = 'l')
np.max.test.35 <- wilcox.test(as.numeric(max.35.days.L),as.numeric(max.35.days.R),paired = TRUE)
np.min.test.35 <- wilcox.test(as.numeric(min.35.days.L),as.numeric(min.35.days.R),paired = TRUE)
np.filling.test.35 <- wilcox.test(as.numeric(filling.35.days.L),as.numeric(filling.35.days.R), paired = TRUE)

print(paste("nonp. median 35 test, p val: ", np.med.test.35$p.value))
print(paste("nonp. max 35 test, p val: ", np.max.test.35$p.value))
print(paste("nonp. min 35 test, p val: ", np.min.test.35$p.value))
print(paste("nonp. filling 35 test, p val: ", np.filling.test.35$p.value))


median.diff.sd <- sd(median.35.days.L-median.35.days.R)
power.result.35 <- power.t.test(n=4,power=0.8, sd=median.diff.sd, sig.level=0.05, alternative = "one.sided", type="paired")
print(paste("median EF: one-sided difference detectable at power 0.8 and significance level 0.05:",power.result.35$delta))


print("analysing day 65: ")
normality.test <- shapiro.test(as.numeric(median.65.days.L-median.65.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal median differences")
}
normality.test <- shapiro.test(as.numeric(min.65.days.L-min.65.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal min differences")
}
normality.test <- shapiro.test(as.numeric(max.65.days.L-max.65.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal max differences")
}
normality.test <- shapiro.test(as.numeric(filling.65.days.L-filling.65.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal filling differences")
}

med.test.65 <- t.test(as.numeric(median.65.days.L),as.numeric(median.65.days.R),paired = TRUE,alternative = 'l')
max.test.65 <- t.test(as.numeric(max.65.days.L),as.numeric(max.65.days.R),paired = TRUE)
min.test.65 <- t.test(as.numeric(min.65.days.L),as.numeric(min.65.days.R),paired = TRUE)
filling.test.65 <- t.test(as.numeric(filling.65.days.L),as.numeric(filling.65.days.R), paired = TRUE)

print(paste("median 65 test, p val: ", med.test.65$p.value))
print(paste("median 65 test, estimate of diff of means: ", med.test.65$estimate))
print(paste("max 65 test, p val: ", max.test.65$p.value))
print(paste("min 65 test, p val: ", min.test.65$p.value))
print(paste("filling 65 test, p val: ", filling.test.65$p.value))

np.med.test.65 <- wilcox.test(as.numeric(median.65.days.L),as.numeric(median.65.days.R),paired = TRUE,alternative = 'l')
np.max.test.65 <- wilcox.test(as.numeric(max.65.days.L),as.numeric(max.65.days.R),paired = TRUE)
np.min.test.65 <- wilcox.test(as.numeric(min.65.days.L),as.numeric(min.65.days.R),paired = TRUE)
np.filling.test.65 <- wilcox.test(as.numeric(filling.65.days.L),as.numeric(filling.65.days.R), paired = TRUE)

print(paste("nonp. median 65 test, p val: ", np.med.test.65$p.value))
print(paste("nonp. max 65 test, p val: ", np.max.test.65$p.value))
print(paste("nonp. min 65 test, p val: ", np.min.test.65$p.value))
print(paste("nonp. filling 65 test, p val: ", np.filling.test.65$p.value))

median.diff.sd <- sd(median.65.days.L-median.65.days.R)
power.result.65 <- power.t.test(n=4,power=0.8, sd=median.diff.sd, sig.level=0.05, alternative = "one.sided", type="paired")
print(paste("median EF: one-sided difference detectable at power 0.8 and significance level 0.05:",power.result.65$delta))

mouse.smi <- read.csv("/media/alessandro/Seagate Expansion Drive/Results-mouse-smi.csv", stringsAsFactors=FALSE)
mouse.smi$days.post.surgery <- c(rep(35,8),rep(5,8),rep(65,8))
mouse.smi$disease.state<-rep(c("control","disuse"),12)

indices.5 <- which(mouse.smi$days.post.surgery==5)
indices.35 <- which(mouse.smi$days.post.surgery==35)
indices.65 <- which(mouse.smi$days.post.surgery==65)

#check normality assumptions on bvtv
d <- with(mouse.smi[indices.5,], BV.TV.fraction[disease.state == "disuse"] - BV.TV.fraction[disease.state == "control"])
shap.test <- shapiro.test(d)
print("testing normality at day 5")
if(shap.test$p.value<0.05)
{
  print("warning: t-test normality conditions not fulfilled")
}
d <- with(mouse.smi[indices.35,], BV.TV.fraction[disease.state == "disuse"] - BV.TV.fraction[disease.state == "control"])
shap.test <- shapiro.test(d)
print("testing normality at day 35")
if(shap.test$p.value<0.05)
{
  print("warning: t-test normality conditions not fulfilled")
}
d <- with(mouse.smi[indices.65,], BV.TV.fraction[disease.state == "disuse"] - BV.TV.fraction[disease.state == "control"])
shap.test <- shapiro.test(d)
print("testing normality at day 65")
if(shap.test$p.value<0.05)
{
  print("warning: t-test normality conditions not fulfilled")
}

#check normality assumptions on SMI
d <- with(mouse.smi[indices.5,], SMI[disease.state == "disuse"] - SMI[disease.state == "control"])
shap.test <- shapiro.test(d)
print("testing normality at day 5")
if(shap.test$p.value<0.05)
{
  print("warning: t-test normality conditions not fulfilled")
}
d <- with(mouse.smi[indices.35,], SMI[disease.state == "disuse"] - SMI[disease.state == "control"])
shap.test <- shapiro.test(d)
print("testing normality at day 35")
if(shap.test$p.value<0.05)
{
  print("warning: t-test normality conditions not fulfilled")
}
d <- with(mouse.smi[indices.65,], SMI[disease.state == "disuse"] - SMI[disease.state == "control"])
shap.test <- shapiro.test(d)
print("testing normality at day 65")
if(shap.test$p.value<0.05)
{
  print("warning: t-test normality conditions not fulfilled")
}

indices.5.control <- which((mouse.smi$days.post.surgery==5) & (mouse.smi$disease.state=="control"))
indices.35.control <- which((mouse.smi$days.post.surgery==35) & (mouse.smi$disease.state=="control"))
indices.65.control <- which((mouse.smi$days.post.surgery==65) & (mouse.smi$disease.state=="control"))

indices.5.disuse <- which((mouse.smi$days.post.surgery==5) & (mouse.smi$disease.state=="disuse"))
indices.35.disuse <- which((mouse.smi$days.post.surgery==35) & (mouse.smi$disease.state=="disuse"))
indices.65.disuse <- which((mouse.smi$days.post.surgery==65) & (mouse.smi$disease.state=="disuse"))

#SMI plots and tests
par(mfrow=c(1,3))
plot(mouse.smi$SMI[indices.5] ~ as.numeric(as.factor(mouse.smi$disease.state))[indices.5],xlab="5 days", ylab="SMI",ylim=c(1.5,3.5),xaxt="n",xlim=c(0.5,2.5))
axis(side=1, at=c(1,2), labels = c("control","disuse"))
plot(mouse.smi$SMI[indices.35] ~ as.numeric(as.factor(mouse.smi$disease.state))[indices.5],xlab="35 days", ylab="SMI",ylim=c(1.5,3.5),xaxt="n",xlim=c(0.5,2.5))
axis(side=1, at=c(1,2), labels = c("control","disuse"))
plot(mouse.smi$SMI[indices.65] ~ as.numeric(as.factor(mouse.smi$disease.state))[indices.5],xlab="65 days", ylab="SMI",ylim=c(1.5,3.5),xaxt="n",xlim=c(0.5,2.5))
axis(side=1, at=c(1,2), labels = c("control","disuse"))

test.smi.5 <- t.test(mouse.smi$SMI[indices.5.disuse],mouse.smi$SMI[indices.5.control],paired = TRUE)#shows that other method works
test.smi.35 <- t.test(mouse.smi$SMI[indices.35] ~ as.factor(mouse.smi$disease.state)[indices.35],paired=TRUE)
test.smi.65 <- t.test(mouse.smi$SMI[indices.65] ~ as.factor(mouse.smi$disease.state)[indices.65],paired=TRUE)
print(paste("p-vals SMI~disease (5,35,65)", test.smi.5$p.value, test.smi.35$p.value, test.smi.65$p.value))

#BVTV plots and tests
plot(mouse.smi$BV.TV.fraction[indices.5] ~ as.numeric(as.factor(mouse.smi$disease.state))[indices.5],xlab="5 days", ylab="bone volume fraction",ylim=c(0,0.2),xaxt="n",xlim=c(0.5,2.5))
axis(side=1, at=c(1,2), labels = c("control","disuse"))
plot(mouse.smi$BV.TV.fraction[indices.35] ~ as.numeric(as.factor(mouse.smi$disease.state))[indices.5],xlab="35 days", ylab="bone volume fraction",ylim=c(0,0.2),xaxt="n",xlim=c(0.5,2.5))
axis(side=1, at=c(1,2), labels = c("control","disuse"))
plot(mouse.smi$BV.TV.fraction[indices.65] ~ as.numeric(as.factor(mouse.smi$disease.state))[indices.5],xlab="65 days", ylab="bone volume fraction",ylim=c(0,0.2),xaxt="n",xlim=c(0.5,2.5))
axis(side=1, at=c(1,2), labels = c("control","disuse"))

test.smi.5 <- t.test(mouse.smi$BV.TV.fraction[indices.5] ~ as.factor(mouse.smi$disease.state)[indices.5],paired=TRUE)
test.smi.35 <- t.test(mouse.smi$BV.TV.fraction[indices.35] ~ as.factor(mouse.smi$disease.state)[indices.35],paired=TRUE)
test.smi.65 <- t.test(mouse.smi$BV.TV.fraction[indices.65] ~ as.factor(mouse.smi$disease.state)[indices.65],paired=TRUE)
print(paste("p-vals bvtv~disease (5,35,65)", test.smi.5$p.value, test.smi.35$p.value, test.smi.65$p.value))

#EF median plots and tests
interleaved.median.5 <- c(rbind(unlist(median.5.days.L),unlist(median.5.days.R)))
interleaved.median.35 <- c(rbind(unlist(median.35.days.L),unlist(median.35.days.R)))
interleaved.median.65 <- c(rbind(unlist(median.65.days.L),unlist(median.65.days.R)))

plot(interleaved.median.5 ~ as.numeric(as.factor(mouse.smi$disease.state))[indices.5],xlab="5 days", ylab="EF median",ylim=c(-0.5,0.5),xaxt="n",xlim=c(0.5,2.5))
axis(side=1, at=c(1,2), labels = c("control","disuse"))
plot(interleaved.median.35 ~ as.numeric(as.factor(mouse.smi$disease.state))[indices.5],xlab="35 days", ylab="EF median",ylim=c(-0.5,0.5),xaxt="n",xlim=c(0.5,2.5))
axis(side=1, at=c(1,2), labels = c("control","disuse"))
plot(interleaved.median.65 ~ as.numeric(as.factor(mouse.smi$disease.state))[indices.5],xlab="65 days", ylab="EF median",ylim=c(-0.5,0.5),xaxt="n",xlim=c(0.5,2.5))
axis(side=1, at=c(1,2), labels = c("control","disuse"))

test.smi.5 <- t.test(interleaved.median.5 ~ as.factor(mouse.smi$disease.state)[indices.5],paired=TRUE)
test.smi.35 <- t.test(interleaved.median.35 ~ as.factor(mouse.smi$disease.state)[indices.35],paired=TRUE)
test.smi.65 <- t.test(interleaved.median.65 ~ as.factor(mouse.smi$disease.state)[indices.65],paired=TRUE)
print(paste("p-vals EF median~disease (5,35,65)", test.smi.5$p.value, test.smi.35$p.value, test.smi.65$p.value))



par(mfrow=c(1,1))
plot(mouse.smi$SMI~mouse.smi$BV.TV.fraction,xlab="bone volume fraction",ylab="SMI")
overall.cor<-cor.test(mouse.smi$BV.TV.fraction,mouse.smi$SMI)
print(paste("cor bvtv-smi overall, r=",overall.cor$estimate,"p-val=",overall.cor$p.value))

par(mfrow=c(1,3))
disease.states <- c(1,1,1,1,2,2,2,2)
plot(disease.states,c(median.5.days.L, median.5.days.R),ylim=c(-1,1),xlim=c(0.5,2.5),cex=2,xlab = "5 days", ylab="EF", xaxt="n")
points(disease.states,c(max.5.days.L,max.5.days.R), pch=21, bg=rgb(1,0.988,0.29,maxColorValue = 1),cex=2)
points(disease.states,c(min.5.days.L,min.5.days.R), pch=21, bg=rgb(0.21,0,0.67,maxColorValue = 1), cex=2)
axis(side=1, at=c(1,2), labels = c("control","disuse"))

plot(disease.states,c(median.35.days.L, median.35.days.R),ylim=c(-1,1),xlim=c(0.5,2.5),cex=2,xlab = "35 days", ylab="EF", xaxt="n")
points(disease.states,c(max.35.days.L,max.35.days.R), pch=21, bg=rgb(1,0.988,0.29,maxColorValue = 1),cex=2)
points(disease.states,c(min.35.days.L,min.35.days.R), pch=21, bg=rgb(0.21,0,0.67,maxColorValue = 1), cex=2)
axis(side=1, at=c(1,2), labels = c("control","disuse"))

plot(disease.states,c(median.65.days.L, median.65.days.R),ylim=c(-1,1),xlim=c(0.5,2.5),cex=2,xlab = "65 days", ylab="EF", xaxt="n")
points(disease.states,c(max.65.days.L,max.65.days.R), pch=21, bg=rgb(1,0.988,0.29,maxColorValue = 1),cex=2)
points(disease.states,c(min.65.days.L,min.65.days.R), pch=21, bg=rgb(0.21,0,0.67,maxColorValue = 1), cex=2)
axis(side=1, at=c(1,2), labels = c("control","disuse"))

#filling
plot(disease.states,c(filling.5.days.L,filling.5.days.R),ylim=c(80,100),xlim=c(0.5,2.5),cex=2,xlab = "5 days", ylab="filling", xaxt="n")
axis(side=1, at=c(1,2), labels = c("control","disuse"))

plot(disease.states,c(filling.35.days.L,filling.35.days.R),ylim=c(80,100),xlim=c(0.5,2.5),cex=2,xlab = "35 days", ylab="filling", xaxt="n")
axis(side=1, at=c(1,2), labels = c("control","disuse"))

plot(disease.states,c(filling.65.days.L,filling.65.days.R),ylim=c(80,100),xlim=c(0.5,2.5),cex=2,xlab = "65 days", ylab="filling", xaxt="n")
axis(side=1, at=c(1,2), labels = c("control","disuse"))

interleaved <- c(interleaved.median.35,interleaved.median.5,interleaved.median.65)
overall.cor <- cor.test(interleaved,mouse.smi$BV.TV.fraction)
print(paste("cor bvtv-EF median overall, r=",overall.cor$estimate,"p-val=",overall.cor$p.value))
par(mfrow=c(1,1))
plot(mouse.smi$BV.TV.fraction,c(interleaved.median.35,interleaved.median.5,interleaved.median.65),xlab="bone volume fraction", ylab="EF median")








