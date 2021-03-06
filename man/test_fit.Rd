% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/plot_time.R, R/test_fit.R
\docType{methods}
\name{test_fit}
\alias{test_fit}
\alias{test_fit-method}
\alias{plot_time,IncrementTest,missing-method}
\alias{test_fit,CountMatrix-method}
\title{Frequency Increment Test}
\usage{
test_fit(object, ...)

\S4method{plot_time}{IncrementTest,missing}(object, level = 0.95, roll = FALSE, window = 3)

\S4method{test_fit}{CountMatrix}(object, dates, ...)
}
\arguments{
\item{object}{A \eqn{m \times p}{m x p} matrix of count data.}

\item{...}{Currently not used.}

\item{level}{A length-one \code{\link{numeric}} vector giving the
confidence level.}

\item{roll}{A \code{\link{logical}} scalar: should each time series be
subsetted to look for episodes of selection?
Only used if \code{highlight} is "\code{FIT}" (see details).}

\item{window}{An odd \code{\link{integer}} giving the size of the rolling
window. Only used if \code{roll} is \code{TRUE}.}

\item{dates}{A \code{\link{numeric}} vector of dates.}
}
\value{
If \code{simplify} is \code{FALSE}, returns a list (default), else returns
 a matrix.
}
\description{
Frequency Increment Test
}
\details{
The Frequency Increment Test (FIT) rejects neutrality if the distribution
 of normalized variant frequency increments exhibits a mean that deviates
 significantly from zero.
}
\examples{
data("merzbach", package = "folio")

## Coerce the merzbach dataset to a count matrix
## Keep only decoration types that have a maximum frequency of at least 50
keep <- apply(X = merzbach, MARGIN = 2, FUN = function(x) max(x) >= 50)
counts <- as_count(merzbach[, keep])

## Group by phase
## We use the row names as time coordinates (roman numerals)
dates <- as.numeric(utils::as.roman(rownames(counts)))

## Frequency Increment Test
freq <- test_fit(counts, dates)

## Plot time vs abundance and highlight selection
plot_time(freq)
plot_time(freq, roll = TRUE, window = 5)
}
\references{
Feder, A. F., Kryazhimskiy, S. & Plotkin, J. B. (2014). Identifying
 Signatures of Selection in Genetic Time Series. \emph{Genetics}, 196(2),
 509-522. \doi{10.1534/genetics.113.158220}.
}
\seealso{
Other statistics: 
\code{\link{independance}},
\code{\link{test_diversity}()}
}
\author{
N. Frerebeau
}
\concept{statistics}
