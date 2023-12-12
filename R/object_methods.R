## Data Model Config Methods
setMethod(
  "show",
  "DataModelConfig",
  function(object) {
    cat("Data name: ", object@data_name, "\n")
    cat("Series name: ", object@series_name, "\n")
    cat("Data filenames: ", object@data_filenames, "\n")
    cat("Data type: ", object@data_type, "\n")
    cat("Age selection: ", object@age_selection, "\n")
    cat("Uncertainty filenames: ", object@uncertainty_data_filenames, "\n")
    cat("Time selection: ", object@time_selection, "\n")
    cat("Baseline SD: ", object@baseline_sd, "\n")
    cat("Counts: ", object@count_df, "\n")
    cat("Uncertainty: ", object@uncertainty_df, "\n")
  }
)

populate_datamod_object <- function(dm_config, input_data_dir) {
  dm_config@count_df <- setup_input_counts(
    input_data_dir,
    dm_config@data_filenames,
    dm_config@time_selection,
    dm_config@age_selection
  )

  dm_config@uncertainty_df <- setup_input_stocks_uncertainty(
    input_data_dir,
    dm_config@uncertainty_data_filenames,
    dm_config@time_selection,
    dm_config@count_df,
    dm_config@baseline_sd
  )

  return(dm_config)
}

populate_datamod_counts <- function(dm_config, input_data_dir) {
  dm_config@count_df <- setup_input_counts(
    input_data_dir,
    dm_config@data_filenames,
    dm_config@time_selection,
    dm_config@age_selection
  )
  return(dm_config)
}

populate_datamod_uncertainty <- function(dm_config, input_data_dir) {
  dm_config@uncertainty_df <- setup_input_stocks_uncertainty(
    input_data_dir,
    dm_config@uncertainty_data_filenames,
    dm_config@time_selection,
    dm_config@count_df,
    dm_config@baseline_sd
  )
  return(dm_config)
}

## System Model Config Methods
setMethod(
  "show",
  "SystemModelConfig",
  function(object) {
    cat("Data name: ", object@data_name, "\n")
    cat("Series name: ", object@series_name, "\n")
    cat("Data filenames: ", object@data_filenames, "\n")
    cat("Data type: ", object@data_type, "\n")
    cat("Age selection: ", object@age_selection, "\n")
    cat("Dispersion: ", object@rates_dispersion, "\n")
    cat("Rates: ", object@rates_df, "\n")
  }
)


populate_sysmod_rates <- function(sm_config, input_data_dir) {
  sm_config@rates_df <- setup_input_rates(
    input_data_dir,
    sm_config@data_filenames,
    sm_config@age_selection
  )

  return(sm_config)
}
