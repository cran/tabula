## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----intro, fig.width=7, fig.height=5, fig.align="center"---------------------
## Install extra packages (if needed)
# install.packages("folio") # Datasets

## Load packages
library(tabula)

## Ceramic data from Lipo et al. 2015
data("mississippi", package = "folio")

## Turnover
turnover(mississippi, method = "whittaker")

## Similarity
BR <- similarity(mississippi, method = "brainerd")

## Plot
plot_spot(BR, col = color("YlOrBr")(12))

## ----woodland-----------------------------------------------------------------
## Data from Magurran 1988, p. 162
woodland <- matrix(
  data = c(TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, 
           TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 
           FALSE, FALSE, TRUE, FALSE, TRUE, FALSE, 
           FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, 
           FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, 
           FALSE, FALSE, FALSE, TRUE, FALSE, TRUE),
  nrow = 6, ncol = 6
)
colnames(woodland) <- c("Birch", "Oak", "Rowan", "Beech", "Hazel", "Holly")

## ----whittaker----------------------------------------------------------------
index_whittaker(woodland)

## ----cody---------------------------------------------------------------------
index_cody(woodland)

## ----routledge1---------------------------------------------------------------
index_routledge1(woodland)

## ----routledge2---------------------------------------------------------------
index_routledge2(woodland)

## ----routledge3---------------------------------------------------------------
index_routledge3(woodland)

## ----wilson-------------------------------------------------------------------
index_wilson(woodland)

