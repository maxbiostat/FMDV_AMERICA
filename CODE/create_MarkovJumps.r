##
makeVector <- function(a, b, S){
  K <- length(S)
  mat <- matrix(0, K, K)
  mat[match(a, S), match(b, S)] <- 1
  diag(mat) <- 0 # just making sure
  return(as.vector(mat))
}
##
########################################
########################################

States <- c("Argentina", "Brazil", "Bolivia",
            "Colombia", "Ecuador",
            "Paraguay", # comment this out to get serotype A
            "Peru", "Uruguay", "Venezuela")


Grid <- subset(expand.grid(States, States), Var1 != Var2)

IndicatorsBulk <- lapply(1:nrow(Grid), function(k){ ## that's for transitions
  makeVector(a = Grid[k, 1], b = Grid[k, 2], S = States)
} )

IndicatorsFrom <- lapply(States, function(s) makeVector(a = s, b = States, S = States))

IndicatorsTo <- lapply(States, function(s) makeVector(a = States, b = s, S = States))


NamesBulk <- lapply(1:nrow(Grid), function(k){ ## that's for transitions
  paste('<parameter id="from_', Grid[k, 1], '_to_', Grid[k, 2], '" value="',
        paste(IndicatorsBulk[[k]], collapse = " "), '" />', sep = "")
} )

NamesFrom <- lapply(States, function(s){ ## that's for transitions
  paste('<parameter id="from_', s, '" value="',
        paste(IndicatorsFrom[[match(s, States)]], collapse = " "), '" />', sep = "")
} )

NamesTo <- lapply(States, function(s){ ## that's for transitions
  paste('<parameter id="to_', s, '" value="',
        paste(IndicatorsTo[[match(s, States)]], collapse = " "), '" />', sep = "")
} )

write(x = unlist(c(NamesBulk, NamesFrom, NamesTo), recursive = FALSE),
      file  = "../DATA/XML/markov_jumps/MJ_block_serotype_O.txt")
