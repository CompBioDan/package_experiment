% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/setup_functions.R
\name{split_flow_count_cohorts}
\alias{split_flow_count_cohorts}
\title{Derive flow counts with corresponding cohorts from an input without cohorts}
\usage{
split_flow_count_cohorts(flows_df)
}
\arguments{
\item{flows_df}{A dataframe of flows containing region, time, sex, age, count}
}
\value{
A dataframe with region, time, sex, age, count, cohort
}
\description{
Derive flow counts with corresponding cohorts from an input without cohorts
}
