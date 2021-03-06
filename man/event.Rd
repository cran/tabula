% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/date_event.R, R/refine_event.R
\docType{methods}
\name{event}
\alias{event}
\alias{date_event}
\alias{date_event-method}
\alias{predict_event}
\alias{predict_event-method}
\alias{predict_accumulation}
\alias{predict_accumulation-method}
\alias{bootstrap_event}
\alias{bootstrap_event-method}
\alias{jackknife_event}
\alias{jackknife_event-method}
\alias{date_event,CountMatrix,numeric-method}
\alias{predict_event,DateEvent,missing-method}
\alias{predict_event,DateEvent,CountMatrix-method}
\alias{predict_accumulation,DateEvent,missing-method}
\alias{predict_accumulation,DateEvent,CountMatrix-method}
\alias{jackknife_event,DateEvent-method}
\alias{bootstrap_event,DateEvent-method}
\title{Event and Accumulation Dates}
\usage{
date_event(object, dates, ...)

predict_event(object, data, ...)

predict_accumulation(object, data, ...)

bootstrap_event(object, ...)

jackknife_event(object, ...)

\S4method{date_event}{CountMatrix,numeric}(object, dates, cutoff = 90, level = 0.95, ...)

\S4method{predict_event}{DateEvent,missing}(object, margin = 1, level = 0.95)

\S4method{predict_event}{DateEvent,CountMatrix}(object, data, margin = 1, level = 0.95)

\S4method{predict_accumulation}{DateEvent,missing}(object, level = 0.95)

\S4method{predict_accumulation}{DateEvent,CountMatrix}(object, data, level = 0.95)

\S4method{jackknife_event}{DateEvent}(
  object,
  level = 0.95,
  progress = getOption("tabula.progress"),
  ...
)

\S4method{bootstrap_event}{DateEvent}(
  object,
  level = 0.95,
  probs = c(0.05, 0.95),
  n = 1000,
  progress = getOption("tabula.progress"),
  ...
)
}
\arguments{
\item{object}{A \linkS4class{CountMatrix} or a \linkS4class{DateEvent}
object.}

\item{dates}{A \code{\link{numeric}} vector of dates. If named,
the names must match the row names of \code{object}.}

\item{...}{Further arguments to be passed to internal methods.}

\item{data}{A \linkS4class{CountMatrix} object for which to predict
event and accumulation dates.}

\item{cutoff}{An \code{\link{integer}} giving the cumulative percentage of
variance used to select CA factorial components for linear model fitting
(see details). All compounds with a cumulative percentage of variance of
less than the \code{cutoff} value will be retained.}

\item{level}{A length-one \code{\link{numeric}} vector giving the
confidence level.}

\item{margin}{A \code{\link{numeric}} vector giving the subscripts which the
prediction will be applied over: \code{1} indicates rows, \code{2}
indicates columns.}

\item{progress}{A \code{\link{logical}} scalar: should a progress bar be
displayed?}

\item{probs}{A \code{\link{numeric}} vector of probabilities with values in
\eqn{[0,1]} (see \code{\link[stats:quantile]{quantile}}).}

\item{n}{A non-negative \code{\link{integer}} giving the number of bootstrap
replications.}
}
\value{
\code{date_event} returns a \linkS4class{DateEvent} object.

 \code{predict_event}, \code{predict_accumulation}, \code{bootstrap_event}
 and \code{jackknife_event} return a \code{data.frame}.
}
\description{
\code{date_event} fit a date event model.

 \code{predict_event} and \code{predict_accumulation} estimates the event and
 accumulation dates of an assemblage.
}
\details{
This is an implementation of the chronological modeling method proposed by
 Bellanger and Husi (2012, 2013).

 Event and accumulation dates are density estimates of the occupation and
 duration of an archaeological site (Bellanger and Husi 2012, 2013).
 The event date is an estimation of the \emph{terminus post-quem} of an
 archaeological assemblage. The accumulation date represents the
 "chronological profile" of the assemblage. According to Bellanger and Husi
 (2012), accumulation date can be interpreted "at best [...] as a formation
 process reflecting the duration or succession of events on the scale of
 archaeological time, and at worst, as imprecise dating due to contamination
 of the context by residual or intrusive material." In other words,
 accumulation dates estimate occurrence of archaeological events and rhythms
 of the long term.

 This method relies on strong archaeological and statistical assumptions.
 Use it only if you know what you are doing (see references below and the
 vignette: \code{utils::vignette("dating", package = "tabula")}).
}
\note{
Bellanger \emph{et al.} did not publish the data supporting their
 demonstration: no replication of their results is possible and this
 implementation must be considered \strong{experimental}.
 \code{date_event} may be subject to major changes in a future release.
}
\section{Date Model}{

 If \code{jackknife_event} is used, one type/fabric is removed at a
 time and all statistics are recalculated. In this way, one can assess
 whether certain type/fabric has a substantial influence on the date
 estimate.
 A three columns \code{data.frame} is returned, giving the results of
 the resampling procedure (jackknifing fabrics) for each assemblage (in rows)
 with the following columns:
 \describe{
  \item{mean}{The jackknife mean (event date).}
  \item{bias}{The jackknife estimate of bias.}
  \item{error}{The standard error of predicted means.}
 }

 If \code{bootstrap_event} is used, a large number of new
 bootstrap assemblages is created, with the same sample size, by resampling
 each of the original assemblage with replacement. Then, examination of the
 bootstrap statistics makes it possible to pinpoint assemblages that require
 further investigation.

 A five columns \code{\link{data.frame}} is returned, giving the bootstrap
 distribution statistics for each replicated assemblage (in rows)
 with the following columns:
 \describe{
  \item{min}{Minimum value.}
  \item{mean}{Mean value (event date).}
  \item{max}{Maximum value.}
  \item{Q5}{Sample quantile to 0.05 probability.}
  \item{Q95}{Sample quantile to 0.95 probability.}
 }
}

\examples{
## Event and accumulation dates (Bellanger et al.)
## See the vignette:
\dontrun{
utils::vignette("dating")
}
}
\references{
Bellanger, L. & Husi, P. (2013). Mesurer et modéliser le temps inscrit dans
 la matière à partir d'une source matérielle : la céramique médiévale.
 In \emph{Mesure et Histoire Médiévale}. Histoire ancienne et médiévale.
 Paris: Publication de la Sorbonne, p. 119-134.

 Bellanger, L. & Husi, P. (2012). Statistical Tool for Dating and
 Interpreting Archaeological Contexts Using Pottery. \emph{Journal of
 Archaeological Science}, 39(4), 777-790. \doi{10.1016/j.jas.2011.06.031}.

 Bellanger, L., Tomassone, R. & Husi, P. (2008). A Statistical Approach for
 Dating Archaeological Contexts. \emph{Journal of Data Science}, 6, 135-154.

 Bellanger, L., Husi, P. & Tomassone, R. (2006). Une approche statistique
 pour la datation de contextes archéologiques. \emph{Revue de Statistique
 Appliquée}, 54(2), 65-81.

 Bellanger, L., Husi, P. & Tomassone, R. (2006). Statistical Aspects of
 Pottery Quantification for the Dating of Some Archaeological Contexts.
 \emph{Archaeometry}, 48(1), 169-183. \doi{10.1111/j.1475-4754.2006.00249.x}.

 Poblome, J. & Groenen, P. J. F. (2003). Constrained Correspondence Analysis
 for Seriation of Sagalassos Tablewares. In Doerr, M. & Apostolis, S. (eds.),
 \emph{The Digital Heritage of Archaeology}. Athens: Hellenic Ministry of
 Culture.
}
\seealso{
Other dating: 
\code{\link{date_mcd}()}
}
\author{
N. Frerebeau
}
\concept{dating}
