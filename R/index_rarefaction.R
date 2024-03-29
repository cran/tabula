#' @include AllGenerics.R AllClasses.R
NULL

#' @export
#' @rdname rarefaction
#' @aliases rarefaction,matrix-method
setMethod(
  f = "rarefaction",
  signature = signature(object = "matrix"),
  definition = function(object, sample = NULL, method = c("hurlbert", "baxter"),
                        step = 1) {
    ## Validation
    method <- match.arg(method, several.ok = FALSE)

    n <- nrow(object)
    if (is.null(sample)) {
      sample <- rowSums(object)
    }
    if (length(sample) == 1) {
      sample <- rep(sample, n)
    }
    k <- seq(from = 1, to = max(sample), by = step)

    ## Matrix of results
    z <- matrix(data = NA_real_, nrow = n, ncol = length(k))
    row_names <- rownames(object) %||% paste0("S", seq_len(n)) # Fix names
    dimnames(z) <- list(row_names, k)

    for (i in seq_len(n)) {
      spl <- k[k <= sample[[i]]]
      rare <- vapply(
        X = spl,
        FUN = function(s, x, f) f(x, s),
        FUN.VALUE = numeric(1),
        x = object[i, ],
        f = get_index(method) # Select method
      )
      z[i, seq_along(rare)] <- rare
    }

    .RarefactionIndex(
      z,
      labels = row_names,
      size = as.integer(k),
      method = method
    )
  }
)

#' @export
#' @rdname rarefaction
#' @aliases rarefaction,data.frame-method
setMethod(
  f = "rarefaction",
  signature = signature(object = "data.frame"),
  definition = function(object, sample = NULL, method = c("hurlbert", "baxter"),
                        step = 1) {
    object <- data.matrix(object)
    methods::callGeneric(object, sample = sample, method = method, step = step)
  }
)

# Index ========================================================================
#' @export
#' @rdname rarefaction
#' @aliases index_baxter,numeric-method
setMethod(
  f = "index_baxter",
  signature = signature(x = "numeric"),
  definition = function(x, sample, ...) {
    ## Validation
    arkhe::assert_count(x)

    x <- x[x > 0]
    N <- sum(x)

    E <- suppressWarnings(exp(ramanujan(N - x) + ramanujan(N - sample) -
                                ramanujan(N - x - sample) - ramanujan(N)))
    sum(1 - E, na.rm = FALSE)
  }
)

#' @export
#' @rdname rarefaction
#' @aliases index_hurlbert,numeric-method
setMethod(
  f = "index_hurlbert",
  signature = signature(x = "numeric"),
  definition = function(x, sample, ...) {
    ## Validation
    arkhe::assert_count(x)

    x <- x[x > 0]
    N <- sum(x)

    E <- vapply(
      X = x,
      FUN = function(x, N, sample) {
        if (N - x > sample) {
          combination(N - x, sample) / combination(N, sample)
        } else {
          0
        }
      },
      FUN.VALUE = double(1),
      N, sample
    )
    E <- sum(1 - E, na.rm = FALSE)
    return(E)
  }
)
