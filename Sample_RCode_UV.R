## An example of UV calibration curve and its table
## Contributor: Jun Yin
rm(list = ls())
setwd("")
# Install the following packages prior to use. It takes some time...
# install.packages(xtable, "minpack.lm", tidyverse, "scales", rlang, latex2exp)
library(xtable) #print tables in LaTeX format
library("minpack.lm")
library(tidyverse) #Including ggplot2, dplyr, tidyr, stringr, readr, purrr, etc.
theme_set(theme_bw())
library("scales")
library(rlang)
library(latex2exp)
###################################################

conc <- c(4.8,9.7,34.5,52.4,67.6,105.1) # write concentration here
cali_abs <- c(0.0758,0.1512, 0.5431, 0.8189, 1.0415,1.6103) # write UV absorbance
summary(lm(cali_abs~conc)) # Read the linear equation here
UV <- calicurve <- as.data.frame(cbind(conc, cali_abs))

## The UV plot ####
ggplot(data = UV, mapping = aes(x = conc, y = cali_abs))+
  geom_point()+
  geom_smooth(method = "lm", se=FALSE, color= "black")+
  labs(y="Absorption", x = TeX("Concentration [$\\mu$mol/L]")) # change axis labs here
ggsave(file = "UVcurve.pdf", height = 5, width = 7)

## The table ####
print(xtable(UV, type = "latex", digits = 3, math.style.exponents = TRUE,
             caption = "The UV calibration curve is listed as a table."),
      label = "UV", 
      table.placement = "H", 
      caption.placement = "top",
      include.rownames = FALSE, include.colnames = TRUE,  
      file = "UV.tex")