#' Convert the first character of a string (x) to uppercase
#'
#' @param x String
#'
#' @returns String with first character converted to uppercase
#'
#' @noRd
first_upper <- function(x) {
  upp <- paste0(toupper(substr(x, 1, 1)), substr(x, 2, nchar(x)))
  return(upp)
}


## HAS_TESTS
#' Apply consistent standardization to DPM stocks/flows data counts and sex (uppercase)
#'
#' @param counts_df
#'
#' @return A dataframe with standardized count and sex columns
standardise_counts <- function(counts_df,
                               time_selection,
                               age_selection = c(0:105)) {
  stopifnot(c("region", "time", "sex", "age", "count") %in% colnames(counts_df))

  counts_df <- counts_df %>%
    dplyr::mutate(sex = first_upper(sex)) %>%
    dplyr::filter(
      age %in% age_selection,
      time %in% time_selection
    ) %>%
    dplyr::select(c(region, time, sex, age, count))
  return(counts_df)
}


## HAS_TESTS
#' Import, filter and standardise input stocks
#'
#' @param input_data_directory String filepath to the data directory storing stocks .csv files
#' @param filenames Vector containing filenames of stocks to setup
#'
#' @return A dataframe containing the imported, filtered and standardised stocks
setup_input_counts <- function(input_data_directory,
                               filenames,
                               time_selection,
                               age_selection = c(0:105)) {
  stopifnot(file.exists(file.path(input_data_directory, filenames)))

  files_list <- as.list(file.path(input_data_directory, filenames))
  counts_df <- data.table::rbindlist(lapply(files_list, data.table::fread), use.names = TRUE)

  stopifnot(c("region", "time", "sex", "age", "count") %in% colnames(counts_df))

  counts_df <- standardise_counts(counts_df, time_selection, age_selection)

  return(as.data.frame(counts_df))
}


## HAS_TESTS
#' Apply a base-level standard deviation to a stocks uncertainty dataframe
#'
#' @param uncertainty_df A dataframe containing the uncertainty for an input stock
#' @param base_sd A numeric base-level standard deviation to apply to the stock
#'
#' @return The input dataframe with the base-level standard deviation applied
apply_base_sd <- function(uncertainty_df,
                          base_sd) {
  stopifnot("sd" %in% colnames(uncertainty_df))

  uncertainty_df <- uncertainty_df %>%
    dplyr::mutate(sd = ifelse(sd < base_sd | is.na(sd),
      base_sd,
      sd
    ))
}


#' Import, filter and standardise input stocks uncertainty
#'
#' @param input_data_directory String filepath to the data directory storing stocks .csv files
#' @param stock_uncertainty_filenames Vector containing filenames of stocks uncertainty to setup
#' @param stock_time_selection A int vector containing years to subset stocks uncertainty time range
#' @param stocks_df A dataframe containing related stocks for uncertainty
#'
#' @return A dataframe containing the imported, filtered and standardised stocks uncertainty
setup_input_stocks_uncertainty <- function(input_data_directory,
                                           stock_uncertainty_filenames,
                                           stock_time_selection,
                                           stocks_df,
                                           stocks_base_sd) {
  stocks_uncertainty_files <- as.list(file.path(input_data_directory, stock_uncertainty_filenames))
  stocks_uncertainty <- data.table::rbindlist(lapply(stocks_uncertainty_files, data.table::fread), use.names = TRUE) %>%
    dplyr::filter(time %in% stock_time_selection) %>%
    dplyr::mutate(sex = first_upper(sex))

  # Merge stocks & uncertainty to trim overhanging uncertainty
  temp <- merge(stocks_df, stocks_uncertainty, by = c("region", "age", "sex", "time"), all.x = TRUE) %>%
    apply_base_sd(base_sd = stocks_base_sd)
  stocks_uncertainty <- temp %>%
    dplyr::select(-count)
  rm(temp)

  return(stocks_uncertainty)
}


#' Set up the input rates for the TMB DPM, reading the .csv file, subsetting to
#' expected columns, standardising 'sex' and subsetting to an age range
#'
#' @param input_data_directory String filepath to the data directory
#' @param rates_filename String filename of the rates file to setup
#' @param rates_age_selection A vector containing the ages to subset rates to
#'
#' @return A dataframe containing the required standardised rates
setup_input_rates <- function(input_data_directory,
                              rates_filename,
                              rates_age_selection = c(0:105)) {
  rates_la <- read.csv(file.path(input_data_directory, rates_filename))

  if ("sex" %in% colnames(rates_la)) {rates_la_model_input <- rates_la %>% dplyr::select(c(region, age, sex, time, rate)) %>%
      dplyr::mutate(sex = first_upper(sex)) %>%
      dplyr::filter(age %in% rates_age_selection)
  } else {rates_la_model_input <- rates_la %>%
      dplyr::select(c(region, age, time, rate)) %>%
      dplyr::filter(age %in% rates_age_selection)
  }

  return(rates_la_model_input)
}


#' Prepare rates for DPM input, forcing uppercase 'sex' and subsetting by age
#'
#' @param rates Dataframe containing raw imported rates data
#' @param rates_age_selection A vector containing the ages to subset rates to
#' @param columns A vector containing columns to subset to for input into TMB DPM (default: region, age, sex, time, rate)
#'
#' @return A dataframe containing the required standardised rates
prepare_rates <- function(rates, rates_age_selection = c(0:105)) {rates <- rates %>%
    dplyr::filter(age %in% rates_age_selection)
  if ("sex" %in% colnames(rates)) {rates <- rates %>%
      mutate(sex = first_upper(sex))
  }
  return(rates)
}


#' Set up the input rates for the TMB DPM, reading the .csv file, subsetting to
#' expected columns, standardising 'sex' and subsetting to an age range
#'
#' @param input_data_directory String filepath to the data directory
#' @param rates_filename String filename of the rates file to setup
#' @param rates_age_selection A vector containing the ages to subset rates to
#'
#' @return A dataframe containing the required standardised rates
setup_input_rates <- function(input_data_directory,
                              rates_filename,
                              rates_age_selection = c(0:105)) {rates_la <- read.csv(file.path(input_data_directory, rates_filename))
  rates_la_model_input <- prepare_rates(rates_la, rates_age_selection)
  return(rates_la_model_input)
}


#' Derive flow counts with corresponding cohorts from an input without cohorts
#'
#' @param flows_df A dataframe of flows containing region, time, sex, age, count
#'
#' @return A dataframe with region, time, sex, age, count, cohort
split_flow_count_cohorts <- function(flows_df) {
  split_flows_df <- bind_rows(
    flows_df %>% dplyr::select(c(region, time, sex, age, count)) %>%dplyr::mutate(
        cohort = time - age,
        count = count / 2
      ),
    flows_df %>% dplyr::select(c(region, time, sex, age, count)) %>% dplyr::mutate(cohort = time - age - 1,
        count = count / 2
      )
  )

  return(split_flows_df)
}


#' Derive uncertainty (sd) for a flow using the flow counts and flow cv along with
#' a base sd
#'
#' @param flow_df A dataframe containing the flow counts
#' @param flow_uncertainty_df A dataframe containing the flow cv
#' @param flow_base_sd A numeric representation of the base level uncertainty (sd)
#'
#' @return A dataframe with the derived sd
derive_flow_uncertainty <- function(flow_df,
                                    flow_uncertainty_df,
                                    flow_base_sd) {flow_uncertainty <- left_join(flow_df, bind_rows(
      flow_uncertainty_df %>% dplyr::mutate(cohort = time - age),
      flow_uncertainty_df %>% dplyr::mutate(cohort = time - age - 1)
    ) %>%
      rename(region = LA_Code_2021),
    by = c("region", "sex", "time", "age", "cohort")
  ) %>%
    dplyr::mutate(sd = ifelse(is.na(cv) | cv == 0,
      count,
      cv * count
    )) %>%
    dplyr::select(region, time, sex, age, cohort, sd) %>%
    dplyr::mutate(sd = ifelse(sd < flow_base_sd | is.na(sd),
      flow_base_sd,
      sd
    ))

  temp <- merge(flow_df, flow_uncertainty, by = c("region", "age", "sex", "time", "cohort"))
  flow_uncertainty <- temp %>%
    dplyr::select(-count)
  rm(temp)

  return(flow_uncertainty)
}
