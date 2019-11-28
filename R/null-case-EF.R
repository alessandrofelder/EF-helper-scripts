n <- 100000
y.limits <- c(0, 20000)
f <- function(n,parameter) return(rgamma(n,parameter)/2)
#f <- runif
#f <- function(n) return(rnorm(n,mean=0.5, sd = 0.1))

#to mimic rods and plate structure: a unimodal, b bimodal, c unimodal
f.rods.plates <- function(n) {
  adist <- rnorm(n / 3, mean = 0.2, sd = 0.03)
cdist <- rnorm(n / 3, mean = 0.8, sd = 0.03)
bdist <- unlist(c(rnorm(n / 6, mean = 0.2, sd = 0.03),rnorm(1+n / 6, mean = 0.8, sd = 0.03)))
return(rbind(rbind(adist, bdist), cdist))}

f.uniform.sorted.below.1 <- function(n) {
  adist <- runif(round(n/3), 0,1)
  bdist <- runif(round(n/3), adist,1)
  cdist <- runif(round(n/3), bdist,1)
  return(rbind(rbind(adist, bdist), cdist))}


f.uniform.sorted.varying.upper.limit <- function(n) {
  u <- runif(round(n/3),0,1000)
  adist <- runif(round(n/3), 0,u)
  bdist <- runif(round(n/3), adist,u)
  cdist <- runif(round(n/3), bdist,u)
  return(rbind(rbind(adist, bdist), cdist))}

#radii <- rbind(rbind(f(n), f(n)), f(n))
radii <- rbind(rbind(f(n,4), f(n,10)), f(n,20))
#radii <- f.rods.plates(n)
#radii <- f.uniform.sorted.varying.upper.limit(n)
sorted.radii <- apply(radii, 2, sort)

data.range <- range(radii)
data.min <- data.range[1]
data.max <- data.range[2]
n.bins <- 50
n.breaks <- seq(data.min, data.max, (data.max - data.min) / n.bins)

par(mfrow = c(3, 3))
hist(
  radii[1, ],
  xlab = "radius",
  main = "Histogram before sorting 1",
  xlim = data.range,
  breaks = n.breaks,
  ylim = y.limits
)
hist(
  radii[2, ],
  xlab = "radius",
  main = "Histogram before sorting 2",
  xlim = data.range,
  breaks = n.breaks,
  ylim = y.limits
)
hist(
  radii[3, ],
  xlab = "radius",
  main = "Histogram before sorting 3",
  xlim = data.range,
  breaks = n.breaks,
  ylim = y.limits
)

hist(
  sorted.radii[1, ],
  xlab = "a",
  main = "Histogram of a",
  xlim = data.range,
  breaks = n.breaks,
  ylim = y.limits
)
hist(
  sorted.radii[2, ],
  xlab = "b",
  main = "Histogram of b",
  xlim = data.range,
  breaks = n.breaks,
  ylim = y.limits
)
hist(
  sorted.radii[3, ],
  xlab = "c",
  main = "Histogram of c",
  xlim = data.range,
  breaks = n.breaks,
  ylim = y.limits
)

a.divided.by.b <- sorted.radii[1, ] / sorted.radii[2, ]
hist(
  a.divided.by.b,
  xlab = "a/b",
  main = "Histogram a/b",
  xlim = c(0, 1),
  breaks = seq(0, 1, 1. / n.bins),
  ylim = y.limits *2
)
b.divided.by.c <- sorted.radii[2, ] / sorted.radii[3, ]
hist(
  b.divided.by.c,
  xlab = "b/c",
  main = "Histogram b/c",
  xlim = c(0, 1),
  breaks = seq(0, 1, 1. / n.bins),
  ylim = y.limits *2
)
#a.divided.by.c <- sorted.uniform.radii[1,]/sorted.uniform.radii[3,]
#hist(a.divided.by.c, xlab = "a/c", main = "Histogram a/c")

ef <- a.divided.by.b - b.divided.by.c
hist(
  ef,
  xlab = "a/b-b/c",
  main = "Histogram a/b-b/c",
  xlim = c(-1, 1),
  breaks = seq(0, 1, 1. / n.bins) * 2 - 1,
  ylim = y.limits *2
)

