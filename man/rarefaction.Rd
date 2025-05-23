% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/rarefaction.R
\docType{methods}
\name{rarefaction}
\alias{rarefaction}
\alias{rarefaction-method}
\alias{rarefaction,matrix-method}
\alias{rarefaction,data.frame-method}
\title{Rarefaction}
\usage{
rarefaction(object, ...)

\S4method{rarefaction}{matrix}(object, sample = NULL, method = c("hurlbert", "baxter"), step = 1)

\S4method{rarefaction}{data.frame}(object, sample = NULL, method = c("hurlbert", "baxter"), step = 1)
}
\arguments{
\item{object}{A \eqn{m \times p}{m x p} \code{numeric} \code{\link{matrix}} or
\code{\link{data.frame}} of count data (absolute frequencies giving the number of
individuals for each category, i.e. a contingency table). A \code{\link{data.frame}}
will be coerced to a \code{numeric} \code{matrix} via \code{\link[=data.matrix]{data.matrix()}}.}

\item{...}{Currently not used.}

\item{sample}{A length-one \code{\link{numeric}} vector giving the sub-sample size.
The size of sample should be smaller than total community size.}

\item{method}{A \code{\link{character}} string or vector of strings specifying the
index to be computed (see details). Any unambiguous substring can be given.}

\item{step}{An \code{\link{integer}} giving the increment of the sample size.}
}
\value{
A \linkS4class{RarefactionIndex} object.
}
\description{
Rarefaction
}
\section{Rarefaction Measures}{

The following rarefaction measures are available for count data:
\describe{
\item{\code{baxter}}{\link[=index_baxter]{Baxter's rarefaction}.}
\item{\code{hurlbert}}{\link[=index_hurlbert]{Hurlbert's unbiased estimate} of
Sander's rarefaction.}
}
}

\section{Details}{

The number of observed taxa, provides an instantly comprehensible
expression of diversity. While the number of taxa within a sample
is easy to ascertain, as a term, it makes little sense: some taxa
may not have been seen, or there may not be a fixed number of taxa
(e.g. in an open system; Peet 1974). As an alternative, \emph{richness}
(\eqn{S}) can be used for the concept of taxa number (McIntosh 1967).

It is not always possible to ensure that all sample sizes are equal
and the number of different taxa increases with sample size and
sampling effort (Magurran 1988). Then, \emph{\link[=rarefaction]{rarefaction}}
(\eqn{E(S)}) is the number of taxa expected if all samples were of a
standard size (i.e. taxa per fixed number of individuals).
Rarefaction assumes that imbalances between taxa are due to sampling and
not to differences in actual abundances.
}

\examples{
## Data from Conkey 1980, Kintigh 1989
data("cantabria")

## Replicate fig. 3 from Baxter 2011
rare <- rarefaction(cantabria, sample = 23, method = "baxter")
plot(rare, panel.first = graphics::grid())

## Change graphical parameters
plot(rare, color = color("bright")(5), symbol = 1:5)
}
\seealso{
\code{\link[=index_baxter]{index_baxter()}}, \code{\link[=index_hurlbert]{index_hurlbert()}}, \code{\link[=plot.RarefactionIndex]{plot()}}

Other diversity measures: 
\code{\link{diversity}()},
\code{\link{evenness}()},
\code{\link{heterogeneity}()},
\code{\link{occurrence}()},
\code{\link{plot.DiversityIndex}()},
\code{\link{plot.RarefactionIndex}()},
\code{\link{profiles}()},
\code{\link{richness}()},
\code{\link{she}()},
\code{\link{similarity}()},
\code{\link{simulate}()},
\code{\link{turnover}()}
}
\author{
N. Frerebeau
}
\concept{diversity measures}
