## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----packages-----------------------------------------------------------------
## Install extra packages (if needed)
# install.packages("folio") # Datasets

## Load packages
library(tabula)

## ----data---------------------------------------------------------------------
## Data from Lipo et al. 2015
data("mississippi", package = "folio")

## ----diversity----------------------------------------------------------------
heterogeneity(mississippi, method = "shannon")

## ----evenness-----------------------------------------------------------------
evenness(mississippi, method = "shannon")

## ----richness-----------------------------------------------------------------
richness(mississippi, method = "margalef")

## ----asymptotic-richness------------------------------------------------------
composition(mississippi, method = "chao1")

## ----rarefaction, fig.width=7, fig.height=5, fig.align="center"---------------
## Baxter rarefaction
RA <- rarefaction(mississippi, sample = 100, method = "baxter")
plot(RA)

## ----similarity, fig.width=7, fig.height=5, fig.align="center"----------------
## Brainerd-Robinson (similarity between assemblages)
BR <- similarity(mississippi, method = "brainerd")
plot_spot(BR, col = khroma::colour("YlOrBr")(12))
  
## Binomial co-occurrence (similarity between types)
BI <- similarity(mississippi, method = "binomial")
plot_spot(BI, col = khroma::colour("PRGn")(12))

