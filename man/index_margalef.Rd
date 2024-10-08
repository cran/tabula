% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/diversity_alpha.R
\docType{methods}
\name{index_margalef}
\alias{index_margalef}
\alias{index_margalef-method}
\alias{index_margalef,numeric-method}
\title{Margalef Richness Index}
\usage{
index_margalef(x, ...)

\S4method{index_margalef}{numeric}(x, na.rm = FALSE, ...)
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
Margalef Richness Index
}
\references{
Margalef, R. (1958). Information Theory in Ecology. \emph{General Systems},
3, 36-71.
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
\code{\link{index_mcintosh}()},
\code{\link{index_menhinick}()},
\code{\link{index_shannon}()},
\code{\link{index_simpson}()},
\code{\link{index_squares}()},
\code{\link{observed}()}
}
\author{
N. Frerebeau
}
\concept{alpha diversity measures}
