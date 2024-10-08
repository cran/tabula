% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/diversity_alpha.R
\docType{methods}
\name{index_mcintosh}
\alias{index_mcintosh}
\alias{index_mcintosh-method}
\alias{index_mcintosh,numeric-method}
\title{McIntosh Dominance Index.}
\usage{
index_mcintosh(x, ...)

\S4method{index_mcintosh}{numeric}(x, evenness = FALSE, na.rm = FALSE, ...)
}
\arguments{
\item{x}{A \code{\link{numeric}} vector of count data (absolute frequencies).}

\item{...}{Currently not used.}

\item{evenness}{A \code{\link{numeric}} scalar: should evenness be computed?}

\item{na.rm}{A \code{\link{numeric}} scalar: should missing values (including \code{NaN}) be
removed?}
}
\value{
A \code{\link{numeric}} vector.
}
\description{
McIntosh Dominance Index.
}
\details{
The McIntosh index expresses the heterogeneity of a sample in geometric
terms. It describes the sample as a point of a \eqn{S}-dimensional
hypervolume and uses the Euclidean distance of this point from the origin.

This is a \emph{dominance} index, so that an increase in the value of the index
accompanies a decrease in diversity.
}
\references{
McIntosh, R. P. (1967). An Index of Diversity and the Relation of Certain
Concepts to Diversity. \emph{Ecology}, 48(3), 392-404.
\doi{10.2307/1932674}.
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
