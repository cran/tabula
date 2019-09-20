## ----setup, include = FALSE, echo=FALSE----------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----uml, echo=FALSE, fig.cap="UML class diagram of the S4 classes structure.", fig.width=7----
knitr::include_graphics("classes.svg")

## ----packages------------------------------------------------------------
# Load packages
library(tabula)
library(magrittr)

## ----create--------------------------------------------------------------
set.seed(12345)
## Create a count data matrix
CountMatrix(data = sample(0:10, 100, TRUE),
            nrow = 10, ncol = 10)

## Create an incidence (presence/absence) matrix
## Numeric values are coerced to logical as by as.logical
IncidenceMatrix(data = sample(0:1, 100, TRUE),
                nrow = 10, ncol = 10)

## ----coerce--------------------------------------------------------------
## Create a count matrix
## Numeric values are coerced to integer and hence truncated towards zero
A1 <- CountMatrix(data = sample(0:10, 100, TRUE),
                  nrow = 10, ncol = 10)

## Coerce counts to frequencies
B <- as_frequency(A1)

## Row sums are internally stored before coercing to a frequency matrix
## (use totals() to get these values)
## This allows to restore the source data
A2 <- as_count(B)
all(A1 == A2)

## Coerce to presence/absence
C <- as_incidence(A1)

## Coerce to a co-occurrence matrix
D <- as_occurrence(A1)

## ----plot-freq, fig.cap="Spot plot", fig.width=4, fig.height=6, fig.align="center"----
## Plot frequencies with the column means as a threshold
mississippi %>%
  as_count() %>%
  plot_spot(threshold = mean) +
  ggplot2::labs(size = "Frequency", colour = "Mean") +
  khroma::scale_colour_vibrant()

## ----plot-occ, fig.cap="Spot plot of co-occurrence", fig.width=6, fig.height=4, fig.align="center"----
## Plot co-occurrence of types
## (i.e. how many times (percent) each pairs of taxa occur together 
## in at least one sample.)
mississippi %>%
  as_occurrence() %>%
  plot_spot() +
  ggplot2::labs(size = "", colour = "Co-occurrence") +
  ggplot2::theme(legend.box = "horizontal") +
  khroma::scale_colour_YlOrBr()

## ----plot-matrix, fig.cap="Heatmap", fig.width=7, fig.height=3.5, fig.align="center"----
boves %>%
  as_count() %>%
  plot_heatmap() +
  khroma::scale_fill_YlOrBr()

## ----plot-matrigraphe, fig.cap="Matrigraphe", fig.width=7, fig.height=3.5, fig.align="center"----
## Reproduce B. Desachy's matrigraphe
boves %>%
  as_count() %>%
  plot_heatmap(PVI = TRUE) +
  khroma::scale_fill_BuRd(midpoint = 1)

## ----plot-bertin, fig.cap="Bertin diagram", fig.width=7, fig.height=7, fig.align="center"----
mississippi %>%
  as_count() %>%
  plot_bertin(threshold = mean) +
  khroma::scale_fill_bright()

## ----plot-ford, fig.cap="Ford diagram", fig.width=7, fig.height=3.5, fig.align="center"----
boves %>%
  as_count() %>%
  plot_ford(EPPM = TRUE) +
  khroma::scale_fill_contrast()

