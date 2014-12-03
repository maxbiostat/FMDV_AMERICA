dataA <- read.table("~/Dropbox/FMDV_AMERICA/DATA/BANCO/Serotype A/metadata_A.csv", TRUE)
dataO <- read.table("~/Dropbox/FMDV_AMERICA/DATA/BANCO/Serotype O/metadata_O.csv", TRUE)

table(as.factor(dataA$COUNTRY),as.factor(dataA$YEAR))