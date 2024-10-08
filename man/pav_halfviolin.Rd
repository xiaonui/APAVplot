% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pav_halfviolin.R
\name{pav_halfviolin}
\alias{pav_halfviolin}
\title{pav_halfviolin}
\usage{
pav_halfviolin(
  pav_obj,
  violin_color = "#7e9bc0",
  add_pheno_info = NULL,
  pheno_info_color_list = NULL,
  x_text_size = NULL,
  y_text_size = NULL,
  x_title_size = NULL,
  y_title_size = NULL
)
}
\arguments{
\item{pav_obj}{A PAV object.}

\item{violin_color}{A string of color for half-violin plot.}

\item{add_pheno_info}{A character string of \code{pheno_info} names.}

\item{pheno_info_color_list}{A list contains named vector of colors for \code{pheno_info} annotation.
e.g. list(gender = c("Male" = "green", "Female" = "red"))}

\item{x_text_size}{The size of tick labels on x-axis.}

\item{y_text_size}{The size of tick labels on y-axis.}

\item{x_title_size}{The size of x-axis title.}

\item{y_title_size}{The size of y-axis title.}
}
\description{
Plot a half-violin plot for a object of PAV class.
}
