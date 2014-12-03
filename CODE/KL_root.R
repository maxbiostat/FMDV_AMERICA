### This script will perform the Kullback-Liebler (KL) divergence analyses reported in the main text
### The main idea is to calculate the KL divergence between the root state distribution and a discrete uniform(1,K)
### Copyleft (or the one to blame): Carvalho, LMF (2014)

library(flexmix)

brA <- rep(1/8, 8) # 'null' uniform of A,  K = 8
brO <- rep(1/9, 9) # 'null' uniform of O,  K = 9

## Subsamples
A1 <- c(.413, .004, 0.11, 0, .342, .003, .064, .027)
A2 <- c(.268, .046, .182, .001, .407, .004, .060, .027)
A3 <- c(.173, .004, .103, .001, .57, .004, .074, .026)
A4 <- c(.083, .062, .113, .004, .611, .005, .080, .038)
A5 <- c(.270, .038, .125, .003, .457, .005, .068, .030)
#
O1 <- c(.030, 0.061, .056, .452, .038, .301, .041, .015, 0)
O2 <- c(.027, .057, .052, .469, .040, .302, .036, .013, .001)
O3 <- c(.022, .048, .029, .513, .016, .331, .023, .014, 0)
O4 <- c(.028, .062, .053, .494, .041, .263, .038, .015, .001)
O5 <- c(.034, .065, .057, .449, .034, .302, .037, .017, 0)
#
KLsA <- KLdiv(as.matrix(cbind(A1, A2, A3, A4, A5, brA)))
KLsA[6, ]
KLsO <- KLdiv(as.matrix(cbind(O1, O2, O3, O4, O5, brO)))
KLsO[6, ]

## Predictors

# Serotype A
A_cattle <- c(.932, .067, 0, 0, 0, 0, 0, 0)
A_distance <- c(.752, .0006, .0004, .0008, .244, .0008, .0008, 0)
A_pigs <- c(1, 0, 0, 0, 0, 0, 0, 0)
A_sheep <- c(.064, .0002, .027, .898, .0012, .0092, 0, 0)
A_uniform <- c(.842, .0002, .0016, .152, .0018, .0014, .0004, 0)

KLpA <- KLdiv(as.matrix(cbind(A_cattle, A_distance, A_pigs, A_sheep, A_uniform, brA)))
KLpA[6, ]

# Serotype O
O_cattle <- c(.0004, .0002, .007, .953, .0268, .0108, .002, 0, 0)
O_distance <- c(.0002, .0044, .0082, .969, .0024, .0126, .0024, 0, 0)
O_pigs <- c(.0002, .916, .0002, .0026, .081, 0, 0, 0, 0)
O_sheep <- c(.0002, .9998, 0, 0, 0, 0, 0, 0, 0)
O_uniform <- c(.004, .0002, .0008, .0032, .0084, .964, .0012, .0158, .0024)

KLpO <- KLdiv(as.matrix(cbind(O_cattle, O_distance, O_pigs, O_sheep, O_uniform, brO)))
KLpO[6, ]

#########
# New (o - overall) analyses
Ao <- c(.65, .0001, .0003, .0007, .3472, .0002, .0011, .0003)
Oo <- c(.0002, .0004, .1528, .0432, .7843, .0007, .0021, .0163, .0001)
KLdiv(as.matrix(cbind(Ao, brA)))
KLdiv(as.matrix(cbind(Oo, brO)))