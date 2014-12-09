require(maptools)
require(spdep)
require(RColorBrewer)
########################################################
pal <- c("green", "black", "darkorchid1", "gray")
#Off-diagonal vector to square matrix
vec2sqmat <- function(v)
{
  k <- (1 + sqrt(1 + 4 * length(v)))/2
  m <- rep(NA, k^2)
  m[seq(1, k^2, k+1)] <- 0
  m[setdiff(1:k^2, seq(1, k^2, k+1))] <- v
  m <- matrix(m, ncol = k)  
  return(m)
}
#________________
#Square matrix to off-diagonal vector
sqmat2vec <- function(M){
  k <- ncol(M)
  pos <- setdiff(1:k^2, seq(1, k^2, k+1))
  return(as.vector(M)[pos])}
############################
#Generates a legend from a vector
genleg<-function(x, nbreaks = 5)
{ 
  breaks <- round(quantile(x, probs = seq(0.01, 1, 1/nbreaks)), digits = 2)
  legendd <- leglabs(breaks, over = "over") 
return(list(legend = legendd,  indicators = findInterval(x, breaks, all.inside = TRUE), breaks = breaks))
}
#####
#modified plot.nb that allows for different thickness for each link
mplot.nb <- function (x, coords, col = "black", lwd = 2, points = TRUE, add = FALSE, 
                    arrows = FALSE, length = 0.1, xlim = NULL, ylim = NULL, ...) 
{
  nb <- x
  unb <- unlist(nb)[unlist(nb)>0]
  N <- length(unb)
  stopifnot(length(nb) == nrow(coords))
  sym <- is.symmetric.nb(nb, verbose = FALSE, force = FALSE)
  x <- coords[, 1]
  y <- coords[, 2]
  n <- length(nb)  
  if (n < 1) 
    stop("non-positive number of entities")
  if (!add) {
    plot.new()
    if (is.null(xlim)) 
      xlim <- range(x)
    if (is.null(ylim)) 
      ylim <- range(y)
    plot.window(xlim = xlim, ylim = ylim, log = "", asp = 1)
  }
  cardnb <- card(nb)
  cardnbcs <- cumsum(cardnb)
  cardnbcs <- c(1, cardnbcs[1:(n-1)])
  if (length(col) < N) 
    col <- rep(col[1], N)
  if (length(lwd) < N) 
    lwd <- rep(lwd[1], N)
  for (i in 1:n) {
    if (cardnb[i] > 0) {      
      inb <- nb[[i]]
      pos.ext <- (cardnbcs[i]):N
      ext <- unb[pos.ext]
      for (j in inb) {        
        w <- pos.ext[match(j, ext)]        
        if (sym) {
          lines(c(x[i], x[j]), c(y[i], y[j]), col = col[w], lwd = lwd[w], 
                ...)
        }
        else {
          if (arrows) 
            arrows(x[i], y[i], x[j], y[j], col = col[w], lwd = lwd[w],
                   length = length, ...)
          else lines(c(x[i], x[j]), c(y[i], y[j]), col = col[w], lwd = lwd[w], 
                     ...)
        }
      }
    }
  }
  if (points) 
    points(x, y, ...)
}
##############################
plot.spatnet <- function(map, nmat, s, coords, net, nets, dir, brk = 5, ltitle, mtitle = "", main = ""){
  ## s is a threshold to decide which edges to show. Only edges with weight > s are plotted 
  if(net){
    if(missing(nets)){
      if(dir == "from"){
        nets <- rowSums(nmat)
      }else{
        nets <- colSums(nmat)
      }   
    }   
    colors <- brewer.pal(brk,"YlOrRd")  
    lg <- genleg(nets[nets > 0], nbreaks = brk)
  }
  nmat <- nmat/max(nmat)
  nmatind <- ifelse(nmat > s, 1, 0)
  listw <- mat2listw(nmatind, style = "B")
  if(net){plot(map, col = colors[lg$indicators])}else(plot(map))
  title(mtitle)
  if(missing(coords)){
    coords <- coordinates(map)
  }
  plot(listw, coords, add = TRUE, col = 1, points = FALSE, arrows = TRUE)
  if(net){
    legend("bottomright", fill = colors, bty = "n", legend = lg$legend, title = ltitle, cex = .7, y.intersp = 1)
  }
  #title(substitute(paste( sigma, "=", s), list(s=s)))   
}

##############################################################
plot.spatnett <- function(map, nb, coords, ws, nets, nbrk = 3, 
                          lbrk = 5, thck = FALSE,
                          coropleth = TRUE, arrows = TRUE, title, main = ""){
  if(missing(nb)){nb <- poly2nb(map)}
  if(missing(coords)){coords <- coordinates(map)}
  colors <- brewer.pal(lbrk, "YlOrRd")
  colors2 <- rainbow(nbrk)
  clg <- genleg(nets, nbreaks = lbrk)  
  alg <- genleg(ws, nbreaks = nbrk)
  if(coropleth){
    plot(map, col = colors[clg$indicators])
  }else{
    plot(map)
  }
  if(!thck){
   mplot.nb(nb, coords, col = colors2[alg$indicators], points = FALSE, arrows = arrows, add = TRUE)
  }else{
   mplot.nb(nb, coords, lwd = alg$indicators, points = FALSE, arrows = arrows, add = TRUE)
  }
  if(coropleth){
  legend("bottom", fill = colors, bty = "n", legend = clg$legend, title = title,
         cex = .7, y.intersp = 1)
  }
  if(!thck){
   legend("bottomleft", fill = colors2, bty = "n", legend = alg$legend, title = "Bayes factors",
          cex = .7, y.intersp = 1)
 }else{
   legend("bottomleft", lwd = 1:max(alg$indicators), bty = "n", legend = alg$legend,
          title = "Bayes factors", cex = .7, y.intersp = 1)
 }
}
##############################################################
## FAIR WARNING: if you continue reading you'll see what might very well be the most heinous hack in all of R coding history. I advise against it.
plot.spatnettinv <- function(map, nb, coords, ws, nets, nbrk = 3, 
                          lbrk = 5, thck = FALSE,
                          coropleth = TRUE, arrows = TRUE, title, main = ""){
  if(missing(nb)){nb <- poly2nb(map)}
  if(missing(coords)){coords <- coordinates(map)}
  colors <- brewer.pal(lbrk, "YlOrRd")
  colors2 <- rainbow(nbrk)
  clg <- genleg(nets, nbreaks = lbrk)  
  alg <- genleg(ws, nbreaks = nbrk)
  if(coropleth){
    plot(map, col = colors[clg$indicators])
  }else{
    plot(map)
  }
  if(!thck){
    mplot.nb(nb, coords, col = colors2[alg$indicators], points = FALSE, arrows = arrows, add = TRUE)
  }else{
    mplot.nb(nb, coords, lwd = alg$indicators, points = FALSE, arrows = arrows, add = TRUE)
  }
  if(coropleth){
    legend("bottomright", fill = colors, bty = "n", legend = clg$legend, title = title,
           cex = .7, y.intersp = 1)
  }
  if(!thck){
    legend("bottom", fill = colors2, bty = "n", legend = alg$legend, title = "Bayes factors",
           cex = .7, y.intersp = 1)
  }else{
    legend("bottom", lwd = 1:max(alg$indicators), bty = "n", legend = alg$legend,
           title = "Bayes factors", cex = .7, y.intersp = 1)
  }
}