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

indices.5.control <- which((mouse.smi$days.post.surgery==5) & (mouse.smi$disease.state="control"))
indices.35.control <- which((mouse.smi$days.post.surgery==35) & (mouse.smi$disease.state="control"))
indices.65.control <- which((mouse.smi$days.post.surgery==65) & (mouse.smi$disease.state="control"))

indices.5.disuse <- which((mouse.smi$days.post.surgery==5) & (mouse.smi$disease.state="disuse"))
indices.35.disuse <- which((mouse.smi$days.post.surgery==35) & (mouse.smi$disease.state="disuse"))
indices.65.disuse <- which((mouse.smi$days.post.surgery==65) & (mouse.smi$disease.state="disuse"))

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

par(mfrow=c(1,1))
plot(mouse.smi$SMI~mouse.smi$BV.TV.fraction,xlab="bone volume fraction",ylab="SMI")
overall.cor<-cor.test(mouse.smi$BV.TV.fraction,mouse.smi$SMI)
print(paste("cor bvtv-smi overall, r=",overall.cor$estimate,"p-val=",overall.cor$p.value))
