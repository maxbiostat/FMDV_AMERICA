library(flexmix)
U9 <- rep(1/9, 9)
U8 <- rep(1/8, 8)
A <- c(6.41E-02, 6.41E-02, .245, .189, .101, .137, 9.15E-02, .109)# estimated frequencies
Ap <- c(6.41E-02, 6.41E-02, .245, .189, .101, 0, .137, 9.15E-02, .109)
O <- c(.116, .114, .115, 9.08E-02, .221, .115, 6.86E-02, 7.87E-02, 8.13E-02)  
KLdiv(cbind(A, U8))
KLdiv(cbind(Ap, U9))
KLdiv(cbind(O, U9))
statesA <- c("Arg", "Bol", "Bra", "Col", "Ecu", "Per", "Uru", "Ven")
statesO <- c("Arg", "Bol", "Bra", "Col", "Ecu", "Par", "Per", "Uru", "Ven")
fA <- c(0.4427480916, 0.0534351145, 0.1221374046, 0.106870229,
        0.0229007634, 0, 0.0305343511, 0.0152671756, 0.2061068702)
fO <- c(0.0119760479, 0.0838323353, 0.0898203593, 0.2155688623, 0.5389221557,
        0.0119760479, 0.005988024, 0.005988024, 0.0359281437)
names(Ap) <- names(O) <- statesO
barplot(Ap, col = 2)
barplot(O, col = 3, add = T)
legend(x = "topright",legend = c("Serotype A", "Serotype O"),
       col = c(2, 3), pch = 16)
#
par(mfrow = c(1, 2))
barplot(Ap, col = "yellow", main = "Serotype A", ylim = c(0, .5))
barplot(fA, col = "blue", add = TRUE)
legend(x = "topright", legend = c("Empirical", "Estimated"),
       col = c("blue", "yellow"), pch = 16)
#
barplot(O, col = "yellow", main = "Serotype O", ylim = c(0, .5))
barplot(fO, col = "blue", add = TRUE)
legend(x = "topleft",legend = c("Empirical", "Estimated"),
       col = c("blue", "yellow"), pch = 16)