data <- read.csv("/media/alessandro/Seagate Expansion Drive/disuse-OP-study-pre-BRS/logfile-2019-08-28 12:10:45.txt-table", header=TRUE, comment.char="#")

#bonferroni correction

# at 5 days
data.5.days <- data[,grepl("X5",colnames(data))]

data.5.days.L <- data.5.days[,grepl("L",colnames(data.5.days))]
median.5.days.L <- data.5.days.L[9,]
max.5.days.L <- data.5.days.L[10,]
min.5.days.L <- data.5.days.L[11,]

data.5.days.R <- data.5.days[,grepl("R",colnames(data.5.days))]
median.5.days.R <- data.5.days.R[9,]
max.5.days.R <- data.5.days.R[10,]
min.5.days.R <- data.5.days.R[11,]

med.test.5 <- wilcox.test(as.numeric(median.5.days.L),as.numeric(median.5.days.R))
max.test.5 <- wilcox.test(as.numeric(max.5.days.L),as.numeric(max.5.days.R))
min.test.5 <- wilcox.test(as.numeric(min.5.days.L),as.numeric(min.5.days.R))

med.test.5$p.value
max.test.5$p.value
min.test.5$p.value

normality.test <- shapiro.test(as.numeric(median.5.days.L-median.5.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal median differences")
}
median.diff.sd <- sd(median.5.days.L-median.5.days.R)
power.result.5 <- power.t.test(n=4,power=0.85, sd=median.diff.sd, sig.level=0.05, alternative = "one.sided", type="paired")
power.result.5$delta

# at 35 days
data.35.days <- data[,grepl("X35",colnames(data))]

data.35.days.L <- data.35.days[,grepl("L",colnames(data.35.days))]
median.35.days.L <- data.35.days.L[9,]
max.35.days.L <- data.35.days.L[10,]
min.35.days.L <- data.35.days.L[11,]

data.35.days.R <- data.35.days[,grepl("R",colnames(data.35.days))]
median.35.days.R <- data.35.days.R[9,]
max.35.days.R <- data.35.days.R[10,]
min.35.days.R <- data.35.days.R[11,]

med.test.35 <- wilcox.test(as.numeric(median.35.days.L),as.numeric(median.35.days.R))
max.test.35 <- wilcox.test(as.numeric(max.35.days.L),as.numeric(max.35.days.R))
min.test.35 <- wilcox.test(as.numeric(min.35.days.L),as.numeric(min.35.days.R))

med.test.35$p.value
max.test.35$p.value
min.test.35$p.value

normality.test <- shapiro.test(as.numeric(median.35.days.L-median.35.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal median differences")
}
median.diff.sd <- sd(median.35.days.L-median.35.days.R)
power.result.35 <- power.t.test(n=4,power=0.85, sd=median.diff.sd, sig.level=0.05, alternative = "one.sided", type="paired")
power.result.35$delta

# at 65 days
data.65.days <- data[,grepl("X65",colnames(data))]

data.65.days.L <- data.65.days[,grepl("L",colnames(data.65.days))]
median.65.days.L <- data.65.days.L[9,]
max.65.days.L <- data.65.days.L[10,]
min.65.days.L <- data.65.days.L[11,]

data.65.days.R <- data.65.days[,grepl("R",colnames(data.65.days))]
median.65.days.R <- data.65.days.R[9,]
max.65.days.R <- data.65.days.R[10,]
min.65.days.R <- data.65.days.R[11,]

med.test.65 <- wilcox.test(as.numeric(median.65.days.L),as.numeric(median.65.days.R))
max.test.65 <- wilcox.test(as.numeric(max.65.days.L),as.numeric(max.65.days.R))
min.test.65 <- wilcox.test(as.numeric(min.65.days.L),as.numeric(min.65.days.R))

med.test.65$p.value
max.test.65$p.value
min.test.65$p.value

normality.test <- shapiro.test(as.numeric(median.65.days.L-median.65.days.R))
if(normality.test$p.value<0.05)
{
  print("warning: non-normal median differences")
}
median.diff.sd <- sd(median.65.days.L-median.65.days.R)
power.result.65 <- power.t.test(n=4,power=0.85, sd=median.diff.sd, sig.level=0.05, alternative = "one.sided", type="paired")
power.result.65$delta
