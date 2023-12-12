## BaseModelConfig S4 class - inherited by SystemModelConfig & DataModelConfig objects
# Object to store the configuration/data for the models required by TMB implementation
# of DPM (system models/data models)
setClass("BaseModelConfig",
  slots = list(
    data_name = "character",
    series_name = "character",
    data_filenames = "character",
    data_type = "character",
    age_selection = "numeric"
  ),
  prototype = list(
    data_name = "mye",
    series_name = "series",
    data_filenames = c("stock_1.csv", "stock_2.csv"),
    data_type = "type",
    age_selection = c(0:105)
  )
)


## DataModelConfig S4 class - inherits from BaseModelConfig object
# Extension of the BaseModelConfig object specifically for system model configuration
setClass("DataModelConfig",
  slots = list(
    uncertainty_data_filenames = "character",
    time_selection = "numeric",
    baseline_sd = "numeric",
    scale_sd = "numeric",
    scale_ratio = "numeric",
    count_df = "ANY",
    uncertainty_df = "ANY",
    datamod_type = "character"
  ),
  contains = "BaseModelConfig",
  prototype = list(
    data_name = "mye",
    series_name = "population",
    data_filenames = c("example_stock.csv"),
    uncertainty_data_filenames = c("example_stock_uncertainty.csv"),
    data_type = "stock",
    time_selection = c(2011:2021),
    age_selection = c(0:105),
    baseline_sd = 0,
    scale_sd = 0,
    scale_ratio = 0,
    count_df = data.frame(),
    uncertainty_df = data.frame(),
    datamod_type = "datamod_norm"
  )
)

## DataModelConfig Constructor
DataModelConfig <- function(
    data_name,
    series_name,
    data_filenames,
    uncertainty_filenames,
    data_type,
    time_select = c(2011:2021),
    age_selection = c(0:105),
    baseline_sd = 0,
    scale_sd = 0,
    scale_ratio = 0,
    datamod_type = "datamod_norm") {
  new("DataModelConfig",
    data_name = data_name,
    series_name = series_name,
    data_filenames = data_filenames,
    uncertainty_data_filenames = uncertainty_filenames,
    data_type = data_type,
    time_selection = time_select,
    age_selection = age_selection,
    baseline_sd = baseline_sd,
    scale_sd = scale_sd,
    scale_ratio = scale_ratio,
    datamod_type = datamod_type,
    count_df = data.frame(),
    uncertainty_df = data.frame()
  )
}


## SystemModelConfig S4 class - inherits from BaseModelConfig object
# Extension of the BaseModelConfig object specifically for system model configuration
setClass("SystemModelConfig",
  slots = list(
    rates_dispersion = "numeric",
    rates_df = "ANY"
  ),
  contains = "BaseModelConfig",
  prototype = list(
    series_name = "births",
    data_filenames = c("rates.csv"),
    rates_dispersion = 0.05,
    data_type = "rates",
    age_selection = c(0:105),
    rates_df = data.frame()
  )
)

## SystemModelConfig Constructor
SystemModelConfig <- function(
    data_name,
    series_name,
    data_filenames,
    data_type,
    age_selection = c(0:105),
    rates_dispersion = 0.05,
    rates_df = data.frame()) {
  new("SystemModelConfig",
    data_name = data_name,
    series_name = series_name,
    data_filenames = data_filenames,
    data_type = data_type,
    age_selection = age_selection,
    rates_dispersion = rates_dispersion,
    rates_df = rates_df
  )
}
