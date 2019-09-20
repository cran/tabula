## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----packages------------------------------------------------------------
# Load packages
library(tabula)
library(magrittr)

## ----richness------------------------------------------------------------
mississippi %>%
  as_count() %>%
  richness(method = c("chao1", "margalef", "menhinick"), 
           unbiased = TRUE, simplify = TRUE) %>%
  head()

## ----diversity-----------------------------------------------------------
mississippi %>%
  as_count() %>%
  diversity(simplify = TRUE) %>%
  head()

## ----evenness------------------------------------------------------------
mississippi %>%
  as_count() %>%
  evenness(simplify = TRUE) %>%
  head()

## ----similarity, fig.width=7, fig.height=5, fig.align="center"-----------
# Brainerd-Robinson index
mississippi %>%
  as_count() %>%
  similarity(method = "brainerd") %>%
  plot_spot() +
  ggplot2::labs(size = "Similarity", colour = "Similarity") +
  khroma::scale_colour_YlOrBr()

## ----plot-rank, fig.width=7, fig.height=5, fig.align="center"------------
mississippi %>%
  as_count() %>%
  plot_rank(log = "xy", facet = FALSE) +
  ggplot2::theme_bw() +
  khroma::scale_color_discreterainbow()

