## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----intro--------------------------------------------------------------------
## Install extra packages (if needed)
# install.packages("folio") # Datasets

## Load package
library(tabula)

## Ceramic data from Lipo et al. 2015
data("mississippi", package = "folio")

## Heterogeneity
heterogeneity(mississippi, method = "shannon")

## Evenness
evenness(mississippi, method = "shannon")

## Richness
richness(mississippi, method = "margalef")

## Asymptotic species richness
composition(mississippi, method = "chao1")

## ----woodland-----------------------------------------------------------------
## Abundance data from Magurran (1988), p. 145
woodland <- c(35, 26, 25, 21, 16, 11, 6, 5, 3, 3, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1)

## ----shannon-index------------------------------------------------------------
index_shannon(woodland)

## ----shannon-unbiased---------------------------------------------------------
index_shannon(woodland, unbiased = TRUE)

## ----shannon-evenness---------------------------------------------------------
index_shannon(woodland, evenness = TRUE)

## ----brillouin-index----------------------------------------------------------
index_brillouin(woodland)

## ----brillouin-evenness-------------------------------------------------------
index_brillouin(woodland, evenness = TRUE)

## ----simpson-index------------------------------------------------------------
index_simpson(woodland)

## ----simpson-evenness---------------------------------------------------------
index_simpson(woodland, evenness = TRUE)

## ----mcintosh-index-----------------------------------------------------------
index_mcintosh(woodland)

## ----mcintosh-evenness--------------------------------------------------------
index_mcintosh(woodland, evenness = TRUE)

## ----berger-index-------------------------------------------------------------
index_berger(woodland)

## ----margalef-index-----------------------------------------------------------
index_margalef(woodland)

## ----menhinick-index----------------------------------------------------------
index_menhinick(woodland)

## ----chao1-index--------------------------------------------------------------
index_chao1(woodland)

## ----chao1-unbiased-----------------------------------------------------------
index_chao1(woodland, unbiased = TRUE)

## ----chao1-improved, eval=FALSE-----------------------------------------------
#  index_chao1(woodland, improved = TRUE)

## ----ace-index----------------------------------------------------------------
index_ace(woodland)

## ----squares-index------------------------------------------------------------
index_squares(woodland)

## ----rarefaction, fig.width=7, fig.height=5, fig.align="center"---------------
## Baxter rarefaction
RA <- rarefaction(mississippi, sample = 100, method = "baxter")
plot(RA)

