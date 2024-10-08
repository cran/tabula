% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/diversity_alpha.R
\docType{methods}
\name{index_squares}
\alias{index_squares}
\alias{index_squares-method}
\alias{index_squares,numeric-method}
\title{Squares Estimator}
\usage{
index_squares(x, ...)

\S4method{index_squares}{numeric}(x, na.rm = FALSE, ...)
}
\arguments{
\item{x}{A \code{\link{numeric}} vector of count data (absolute frequencies).}

\item{...}{Currently not used.}

\item{na.rm}{A \code{\link{numeric}} scalar: should missing values (including \code{NaN}) be
removed?}
}
\value{
A \code{\link{numeric}} vector.
}
\description{
Squares Estimator
}
\references{
Alroy, J. (2018). Limits to Species Richness in Terrestrial Communities.
\emph{Ecology Letters}, 21(12), 1781-1789. \doi{10.1111/ele.13152}.
}
\seealso{
Other alpha diversity measures: 
\code{\link{index_ace}()},
\code{\link{index_baxter}()},
\code{\link{index_berger}()},
\code{\link{index_boone}()},
\code{\link{index_brillouin}()},
\code{\link{index_chao1}()},
\code{\link{index_chao2}()},
\code{\link{index_hurlbert}()},
\code{\link{index_ice}()},
\code{\link{index_margalef}()},
\code{\link{index_mcintosh}()},
\code{\link{index_menhinick}()},
\code{\link{index_shannon}()},
\code{\link{index_simpson}()},
\code{\link{observed}()}
}
\author{
N. Frerebeau
}
\concept{alpha diversity measures}
