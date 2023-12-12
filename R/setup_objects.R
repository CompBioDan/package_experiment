# mye_config <- DataModelConfig(
#   data_name = "mye",
#   series_name = "population",
#   data_filenames = c(
#     "mye_la_annual_2011_2020_cen11.csv",
#     "mye_la_annual_2021_2022_cen21.csv"
#   ),
#   uncertainty_filenames = c(
#     "MYE_2011_uncertainty_2021codes.csv",
#     "MYE_2021_CEN21_uncertainty.csv"
#   ),
#   data_type = "stock",
#   time_select = c(2011, 2021),
#   age_selection = c(0:105),
#   baseline_sd = 1,
#   count_df = data.frame(),
#   uncertainty_df = data.frame()
# )
#
# spd_config <- DataModelConfig(
#   data_name = "spd",
#   series_name = "population",
#   data_filenames = c(
#     "spdv4_la_annual_cov_adjusted.csv"
#   ),
#   uncertainty_filenames = c(
#     "SPDV4_la_uncertainty_CEN21.csv"
#   ),
#   data_type = "stock",
#   time_select = c(2016:2020),
#   age_selection = c(0:105),
#   baseline_sd = 2,
#   count_df = data.frame(),
#   uncertainty_df = data.frame()
# )
#
# pr_config <- DataModelConfig(
#   data_name = "pr",
#   series_name = "population",
#   data_filenames = c(
#     "pr_la_annual_cov_adjusted.csv"
#   ),
#   uncertainty_filenames = c(
#     "pr_la_uncertainty.csv"
#   ),
#   data_type = "stock",
#   time_select = c(2012:2015),
#   age_selection = c(0:105),
#   baseline_sd = 2,
#   count_df = data.frame(),
#   uncertainty_df = data.frame()
# )
#
# # dpm_data_dir <- "//tdata21/isd/DPM/Demographic Accounts/Data/England and Wales/John_Bryant_approach/DPM_data/"
# # input_data_folder <- "la_annual_jun23"
# # input_data_dir <- file.path(dpm_data_dir,input_data_folder,"live_data")
# #
# # mye_config <- populate_datamod_counts(mye_config, input_data_dir)
# # mye_config <- populate_datamod_uncertainty(mye_config, input_data_dir)
# # #
# # spd_config <- populate_datamod_counts(spd_config, input_data_dir)
# # spd_config <- populate_datamod_uncertainty(spd_config, input_data_dir)
# # #
# # pr_config <- populate_datamod_counts(pr_config, input_data_dir)
# # pr_config <- populate_datamod_uncertainty(pr_config, input_data_dir)
#
#
#
# births_config <- SystemModelConfig(
#   data_name = "births",
#   series_name = "births",
#   data_filenames = c(
#     "births_la_annual_interpolated_rates.csv"
#   ),
#   rates_dispersion = 0.003,
#   data_type = "rates",
#   age_selection = c(11:60),
#   rates_df = data.frame()
# )
#
# deaths_config <- SystemModelConfig(
#   data_name = "deaths",
#   series_name = "deaths",
#   data_filenames = c(
#     "deaths_la_annual_interpolated_rates.csv"
#   ),
#   rates_dispersion = 0.003,
#   data_type = "rates",
#   age_selection = c(0:105),
#   rates_df = data.frame()
# )
#
# ins_config <- SystemModelConfig(
#   data_name = "ins",
#   series_name = "ins",
#   data_filenames = c(
#     "immigration_la_annual_rates.csv"
#   ),
#   rates_dispersion = 0.05,
#   data_type = "rates",
#   age_selection = c(0:105),
#   rates_df = data.frame()
# )
#
# outs_config <- SystemModelConfig(
#   data_name = "outs",
#   series_name = "outs",
#   data_filenames = c(
#     "emigration_la_annual_interpolated_rates.csv"
#   ),
#   rates_dispersion = 0.05,
#   data_type = "rates",
#   age_selection = c(0:105),
#   rates_df = data.frame()
# )
#
# # births_config <- populate_ratesdf(births_config, input_data_dir)
# # deaths_config <- populate_ratesdf(deaths_config, input_data_dir)
# # ins_config <- populate_ratesdf(ins_config, input_data_dir)
# # outs_config <- populate_ratesdf(outs_config, input_data_dir)
#
#
# # S4Func <- Filter( function(x) 'S4' %in% class( get(x) ), ls() )
# # lapply( S4Func, function(x) )
#
#
# # ClassFilter <- function(x) inherits(get(x), "DataModelConfig")
#
# # Objs_S4 <- Filter( ClassFilter, ls() )
#
#
# # dm_list <- unlist(list(mget(Objs_S4)))
