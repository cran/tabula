## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----intro--------------------------------------------------------------------
## Install extra packages (if needed)
# install.packages("folio") # Datasets

## Load packages
library(tabula)

## Ceramic data from Lipo et al. 2015
data("mississippi", package = "folio")

## ----similarity, fig.width=7, fig.height=5, fig.align="center"----------------
## Brainerd-Robinson (similarity between assemblages)
BR <- similarity(mississippi, method = "brainerd")
plot_spot(BR, col = khroma::colour("YlOrBr")(12))

## Binomial co-occurrence (similarity between types)
BI <- similarity(mississippi, method = "binomial")
plot_spot(BI, col = khroma::colour("PRGn")(12))

