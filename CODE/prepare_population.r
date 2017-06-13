Raw <- read.csv("../DATA/TRADE_DATA/raw/FAOSTAT_data_5-24-2017_PRODUCTION_LIVE_ANIMALS.csv")

Raw$Area <- gsub(" \\(Plurinational State of\\)", "", Raw$Area)
Raw$Area <- gsub(" \\(Bolivarian Republic of\\)", "", Raw$Area)

Raw$Country <- Raw$Area

library(ggplot2)
number_ticks <- function(n) {function(limits) pretty(limits, n)}

p <- qplot(Year, Value/1000,
           data = subset(Raw, Item == c("Cattle", "Sheep", "Pigs") ),
           colour = Country, fill = Country) 
q0 <- p +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_y_log10("Number of animals (thousands)", breaks = number_ticks(4)) + 
  scale_x_continuous("Year", breaks = number_ticks(10)) +
  facet_grid(Item~., scales = "free_y") +
  theme_bw()
q0
pdf("../FIGURES/PLOTS/livestock_production_SouthAmerica.pdf")
q0
dev.off()
ForAnalysis <- reshape2::dcast(data = Raw, formula = Area + Year ~ Item,
                               fun.aggregate = sum, value.var = "Value")
write.csv(ForAnalysis,
          file = "../DATA/TRADE_DATA/livestock_population_South_America.csv",
          row.names = FALSE)