% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pheno_plot.R
\name{pheno_violin}
\alias{pheno_violin}
\title{pheno_violin}
\usage{
pheno_violin(
  pav_obj,
  pheno_name,
  region_name,
  pav_colors = c("gray60", "steelblue"),
  x_text_size = NULL,
  x_title_size = NULL,
  y_text_size = NULL,
  y_title_size = NULL,
  legend_side = "top",
  legend_title_size = NULL,
  legend_text_size = NULL
)
}
\arguments{
\item{pav_obj}{A PAV object.}

\item{pheno_name}{The name of phenotype.}

\item{region_name}{The name of region.
.}

\item{pav_colors}{A vector of colors for presence and absence.}

\item{x_text_size}{The size of tick labels on x-axis.}

\item{x_title_size}{The size of x-axis title.}

\item{y_text_size}{The size of tick labels on y-axis.}

\item{y_title_size}{The size of y-axis title.}

\item{legend_side}{The position of legend.}

\item{legend_title_size}{The size of legend title.}

\item{legend_text_size}{The size of legend item labels.}
}
\description{
Compare a phenotype in absence/presence regions.
}
