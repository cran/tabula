## ----setup, include = FALSE, echo=FALSE---------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----packages-----------------------------------------------------------------
# Load packages
library(tabula)
library(magrittr)

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

## ----ranking, fig.show='hold'-------------------------------------------------
## Build an incidence matrix with random data
set.seed(12345)
incidence1 <- IncidenceMatrix(data = sample(0:1, 400, TRUE, c(0.6, 0.4)),
                              nrow = 20)

## Get seriation order on rows and columns
## If no convergence is reached before the maximum number of iterations (100), 
## it stops with a warning.
(indices <- seriate_reciprocal(incidence1, margin = c(1, 2), stop = 100))

## Permute matrix rows and columns
incidence2 <- permute(incidence1, indices)

## Plot matrix
plot_heatmap(incidence1) + 
  ggplot2::labs(title = "Original matrix") +
  ggplot2::scale_fill_manual(values = c("TRUE" = "black", "FALSE" = "white"))
plot_heatmap(incidence2) + 
  ggplot2::labs(title = "Rearranged matrix") +
  ggplot2::scale_fill_manual(values = c("TRUE" = "black", "FALSE" = "white"))

## ----averaging, fig.width=7, fig.height=3.5, fig.show='hold'------------------
## Replicates Desachy 2004 results

## Coerce dataset to an abundance matrix
compiegne_counts <- as_count(compiegne)

## Plot original data matrix
plot_ford(compiegne_counts, EPPM = TRUE) +
  ggplot2::labs(title = "Original dataset") +
  khroma::scale_fill_bright()

## Get seriation order for columns on EPPM using the reciprocal averaging method
## Expected column order: N, A, C, K, P, L, B, E, I, M, D, G, O, J, F, H
compiegne_indices <- seriate_reciprocal(compiegne_counts, EPPM = TRUE, margin = 2)

## Permute columns
compiegne_seriation <- permute(compiegne_counts, compiegne_indices)

## Plot new matrix
plot_ford(compiegne_seriation, EPPM = TRUE) +
  ggplot2::labs(title = "Reordered dataset") +
  khroma::scale_fill_bright()

## ----ca-----------------------------------------------------------------------
## Coerce dataset to an abundance matrix
zuni_counts <- as_count(zuni)

## correspondence analysis of the whole dataset
corresp <- ca::ca(zuni_counts)
coords <- ca::cacoord(corresp, type = "principal")

## Plot CA results
ggplot2::ggplot(mapping = ggplot2::aes(x = Dim1, y = Dim2)) +
  ggplot2::geom_vline(xintercept = 0, linetype = 2) +
  ggplot2::geom_hline(yintercept = 0, linetype = 2) +
  ggplot2::geom_point(data = as.data.frame(coords$rows), color = "black") +
  ggplot2::geom_point(data = as.data.frame(coords$columns), color = "red") +
  ggplot2::coord_fixed() + 
  ggplot2::theme_bw()

## ----ca-seriation, fig.width=7, fig.height=7----------------------------------
## Get row permutations from CA coordinates
zuni_indices <- zuni_counts %>%
  seriate_correspondence(margin = 1)

## Permute data matrix
zuni_seriation <- permute(zuni_counts, zuni_indices)

## Plot Ford diagram
## Warning: this may take a few seconds!
plot_ford(zuni_seriation) +
  ggplot2::theme(axis.text = ggplot2::element_blank(),
                 axis.ticks = ggplot2::element_blank())

## ----refine, fig.show='hold'--------------------------------------------------
## Replicates Peeples and Schachner 2012 results

## Samples with convex hull maximum dimension length greater than the cutoff
## value will be marked for removal.
## Define cutoff as one standard deviation above the mean
fun <- function(x) { mean(x) + sd(x) }

## Get indices of samples to be kept
## Warning: this may take a few seconds!
set.seed(123)
(zuni_keep <- refine_seriation(zuni_counts, cutoff = fun, n = 1000))

## Plot convex hull
## blue: convex hull for samples; red: convex hull for types
### All bootstrap samples
ggplot2::ggplot(mapping = ggplot2::aes(x = x, y = y, group = id)) +
  ggplot2::geom_vline(xintercept = 0, linetype = 2) +
  ggplot2::geom_hline(yintercept = 0, linetype = 2) +
  ggplot2::geom_polygon(data = zuni_keep[["rows"]], 
                        fill = "blue", alpha = 0.05) +
  ggplot2::geom_polygon(data = zuni_keep[["columns"]], 
                        fill = "red", alpha = 0.5) +
  ggplot2::coord_fixed() + 
  ggplot2::labs(title = "Whole dataset", x = "Dim. 1", y = "Dim. 2") + 
  ggplot2::theme_bw()
### Only retained samples
ggplot2::ggplot(mapping = ggplot2::aes(x = x, y = y, group = id)) +
  ggplot2::geom_vline(xintercept = 0, linetype = 2) +
  ggplot2::geom_hline(yintercept = 0, linetype = 2) +
  ggplot2::geom_polygon(data = subset(zuni_keep[["rows"]], 
                                      id %in% names(zuni_keep[["keep"]][[1]])),
                        fill = "blue", alpha = 0.05) +
  ggplot2::geom_polygon(data = zuni_keep[["columns"]], 
                        fill = "red", alpha = 0.5) +
  ggplot2::coord_fixed() + 
  ggplot2::labs(title = "Selected samples", x = "Dim. 1", y = "Dim. 2") + 
  ggplot2::theme_bw()

## Histogram of convex hull maximum dimension length
hull_length <- cbind.data.frame(length = zuni_keep[["lengths"]][[1]])
ggplot2::ggplot(data = hull_length, mapping = ggplot2::aes(x = length)) +
  ggplot2::geom_histogram(breaks = seq(0, 4.5, by = 0.5), fill = "grey70") +
  ggplot2::geom_vline(xintercept = fun(hull_length$length), colour = "red") +
  ggplot2::labs(title = "Convex hull max. dim.", 
                x = "Maximum length", y = "Count") + 
  ggplot2::theme_bw()

## ----refine-ca----------------------------------------------------------------
## Get CA-based seriation order
(zuni_refined <- seriate_correspondence(zuni_counts, zuni_keep, margin = 1))

