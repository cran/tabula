## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----packages-----------------------------------------------------------------
# Load packages
library(tabula)
library(folio) # Datasets
library(magrittr)

## ----richness-----------------------------------------------------------------
mississippi %>%
  as_count() %>%
  index_richness(method = "margalef")

## ----asymptotic-richness------------------------------------------------------
mississippi %>%
  as_count() %>%
  index_composition(method = "chao1")

## ----rarefaction--------------------------------------------------------------
mississippi %>%
  as_count() %>%
  rarefaction(sample = 10, method = "hurlbert", simplify = TRUE) %>%
  head()

## ----diversity----------------------------------------------------------------
mississippi %>%
  as_count() %>%
  index_heterogeneity(method = "shannon")

## ----evenness-----------------------------------------------------------------
mississippi %>%
  as_count() %>%
  index_evenness(method = "shannon")

## ----refine-------------------------------------------------------------------
mississippi %>%
  as_count() %>%
  jackknife_evenness(method = "shannon")

## ----similarity, fig.width=7, fig.height=5, fig.align="center"----------------
# Brainerd-Robinson (similarity between assemblages)
mississippi %>%
  as_count() %>%
  similarity(method = "brainerd") %>%
  plot_spot() +
  khroma::scale_colour_YlOrBr()

# Binomial co-occurrence (similarity between types)
mississippi %>%
  as_count() %>%
  similarity(method = "binomial") %>%
  plot_spot() +
  khroma::scale_colour_PRGn()

## ----sample-size, fig.width=3.5, fig.height=3.5, fig.show='hold'--------------
## Data from Conkey 1980, Kintigh 1989, p. 28
chevelon <- as_count(chevelon)

sim_evenness <- simulate_heterogeneity(chevelon, method = "shannon")
plot(sim_evenness) +
  ggplot2::theme_bw() +
  ggplot2::theme(legend.position = "bottom")

sim_richness <- simulate_richness(chevelon, method = "none")
plot(sim_richness) +
  ggplot2::theme_bw() +
  ggplot2::theme(legend.position = "bottom")

## ----plot-rank, fig.width=7, fig.height=5, fig.align="center"-----------------
mississippi %>%
  as_count() %>%
  plot_rank(log = "xy") +
  ggplot2::theme_bw() +
  khroma::scale_color_discreterainbow()

