## ----setup, include = FALSE, echo=FALSE---------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----packages-----------------------------------------------------------------
# Load packages
library(tabula)
library(folio) # Datasets
library(dimensio) # Multivariate analysis
library(magrittr)

## ----reciprocal, fig.width=3.5, fig.height=3.5, fig.show='hold'---------------
## Build an incidence matrix with random data
set.seed(12345)
bin <- sample(0:1, 400, TRUE, c(0.6, 0.4))
incidence1 <- IncidenceMatrix(data = bin, nrow = 20)

## Get seriation order on rows and columns
## If no convergence is reached before the maximum number of iterations (100), 
## it stops with a warning.
(indices <- seriate_rank(incidence1, margin = c(1, 2), stop = 100))

## Permute matrix rows and columns
incidence2 <- permute(incidence1, indices)

## Plot matrix
plot_heatmap(incidence1) + 
  ggplot2::labs(title = "Original matrix") +
  ggplot2::scale_fill_manual(values = c("TRUE" = "black", "FALSE" = "white"))
plot_heatmap(incidence2) + 
  ggplot2::labs(title = "Rearranged matrix") +
  ggplot2::scale_fill_manual(values = c("TRUE" = "black", "FALSE" = "white"))

## ----average, fig.width=7, fig.height=3.5-------------------------------------
## Replicates Desachy 2004 results
## Coerce dataset to an abundance matrix
ccounts1 <- as_count(compiegne)

## Plot original data matrix
plot_ford(ccounts1, EPPM = TRUE) +
  ggplot2::labs(title = "Original dataset") +
  khroma::scale_fill_bright()

## Get seriation order for columns on EPPM using the reciprocal averaging method
## Expected column order: N, A, C, K, P, L, B, E, I, M, D, G, O, J, F, H
(cindices <- seriate_rank(ccounts1, EPPM = TRUE, margin = 2))

## Permute columns
ccounts2 <- permute(ccounts1, cindices)

## Plot new matrix
plot_ford(ccounts2, EPPM = TRUE) +
  ggplot2::labs(title = "Reordered dataset") +
  khroma::scale_fill_bright()

## ----ca-----------------------------------------------------------------------
## Coerce dataset to an count matrix
zcounts1 <- as_count(zuni)

## correspondence analysis of the whole dataset
corresp <- dimensio::ca(zcounts1)

## Plot CA results
dimensio::plot(corresp) +
  ggplot2::theme_bw()

## ----ca-seriation, fig.width=7, fig.height=7----------------------------------
## Get row permutations from CA coordinates
(zindices <- seriate_average(zcounts1, margin = 1))

## Permute data matrix
zcounts2 <- permute(zcounts1, zindices)

## Plot Ford diagram
## Warning: this may take a few seconds!
plot_ford(zcounts2) +
  ggplot2::labs(title = "Reordered dataset") +
  ggplot2::theme(axis.text.y = ggplot2::element_blank())

## ----refine-------------------------------------------------------------------
## Replicates Peeples and Schachner 2012 results
## Samples with convex hull maximum dimension length greater than the cutoff
## value will be marked for removal.
## Define cutoff as one standard deviation above the mean
fun <- function(x) { mean(x) + sd(x) }

## Get indices of samples to be kept
## Warning: this may take a few seconds!
(zuni_keep <- refine_seriation(corresp, cutoff = fun, n = 1000))

## Plot convex hull
## blue: convex hull for samples; red: convex hull for types
### All bootstrap samples
rchull <- as.data.frame(zuni_keep[["rows"]][["chull"]])

ggplot2::ggplot(data = rchull) +
  ggplot2::aes(x = x, y = y, group = id) +
  ggplot2::geom_polygon(fill = "blue", alpha = 0.1) +
  ggplot2::geom_vline(xintercept = 0, size = 0.5, linetype = "dashed") +
  ggplot2::geom_hline(yintercept = 0, size = 0.5, linetype = "dashed") +
  ggplot2::coord_fixed() + 
  ggplot2::labs(x = "", y = "") +
  ggplot2::theme_bw()

### Only retained samples
rchull_sub <- subset(rchull, id %in% zuni_keep[["rows"]][["keep"]])
ggplot2::ggplot(data = rchull_sub) +
  ggplot2::aes(x = x, y = y, group = id) +
  ggplot2::geom_polygon(fill = "blue", alpha = 0.1) +
  ggplot2::geom_vline(xintercept = 0, size = 0.5, linetype = "dashed") +
  ggplot2::geom_hline(yintercept = 0, size = 0.5, linetype = "dashed") +
  ggplot2::coord_fixed() + 
  ggplot2::labs(x = "", y = "") +
  ggplot2::theme_bw()

## Histogram of convex hull maximum dimension length
hull_length <- data.frame(length = zuni_keep[["rows"]][["length"]])
ggplot2::ggplot(data = hull_length) +
  ggplot2::aes(x = length) +
  ggplot2::geom_histogram(breaks = seq(0, 4.5, by = 0.5), fill = "grey70") +
  ggplot2::geom_vline(xintercept = fun(hull_length$length), colour = "red") +
  ggplot2::labs(
    title = "Convex hull max. dim.", 
    x = "Maximum length", 
    y = "Count"
  ) + 
  ggplot2::theme_bw()

