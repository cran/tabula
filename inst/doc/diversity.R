## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----packages-----------------------------------------------------------------
# Load packages
library(tabula)
library(folio) # Datasets

## ----richness-----------------------------------------------------------------
richness(mississippi, method = "margalef")

## ----asymptotic-richness------------------------------------------------------
composition(mississippi, method = "chao1")

## ----diversity----------------------------------------------------------------
heterogeneity(mississippi, method = "shannon")

## ----evenness-----------------------------------------------------------------
evenness(mississippi, method = "shannon")

## ----similarity, fig.width=7, fig.height=5, fig.align="center"----------------
# Brainerd-Robinson (similarity between assemblages)
BR <- similarity(mississippi, method = "brainerd")
plot_spot(BR) +
  khroma::scale_colour_YlOrBr()

# Binomial co-occurrence (similarity between types)
BI <- similarity(mississippi, method = "binomial")
plot_spot(BI) +
  khroma::scale_colour_PRGn()

## ----rarefaction--------------------------------------------------------------
RA <- rarefaction(mississippi, sample = 100, method = "hurlbert")

plot(RA)

## ----sample-size, fig.width=3.5, fig.height=3.5, fig.show='hold'--------------
## Data from Conkey 1980, Kintigh 1989, p. 28
HE <- heterogeneity(chevelon, method = "shannon")
HE_sim <- simulate(HE)
plot(HE_sim)

RI <- index_richness(chevelon, method = "count")
RI_sim <- simulate(RI)
plot(RI_sim) 

## ----plot-rank, fig.width=7, fig.height=5, fig.align="center"-----------------
plot_rank(mississippi, log = "xy") +
  ggplot2::theme_bw() +
  khroma::scale_color_discreterainbow()

