#' Print all variables from the dpm_config.R script into a provided log file
#'
#' @param log_filepath Path to log file
#'
#' @returns Input log file with config parameters appended
write_config_log <- function(log_filepath) {
  # Write dpm_config.R parameters to log file
  write(
    c(
      "DPM TMB Config parameters:",
      paste("mye_time_select:", capture.output(mye_time_select)),
      paste("pr_time_select:", capture.output(pr_time_select)),
      paste("spd_time_select:", capture.output(spd_time_select)),
      paste("births_age_select", capture.output(births_age_select)),
      paste("base_mye_sd", capture.output(base_mye_sd)),
      paste("base_spd_sd", capture.output(base_spd_sd)),
      paste("base_pr_sd", capture.output(base_pr_sd)),
      paste("base_ins_sd", capture.output(base_ins_sd)),
      paste("base_outs_sd", capture.output(base_outs_sd)),
      paste("disp_birth", capture.output(disp_birth)),
      paste("disp_death", capture.output(disp_death)),
      paste("disp_imm", capture.output(disp_imm)),
      paste("disp_em", capture.output(disp_em)),
      paste("event_age_definitions", capture.output(event_age_definitions)),
      paste("n_rates_draws", capture.output(n_rates_draws)),
      paste("dpm_packages", capture.output(dpm_packages)),
      paste("scale_sd_ins", capture.output(scale_sd_ins)),
      paste("scale_sd_outs", capture.output(scale_sd_outs)),
      paste("scale_ratio_ins", capture.output(scale_ratio_ins)),
      paste("scale_ratio_outs", capture.output(scale_ratio_outs)),
      paste("dpm_data_dir:", dpm_data_dir),
      paste("input_data_folder:", input_data_folder),
      paste("out_dir:", out_dir),
      paste("out_folder_isd:", out_folder_isd),
      paste("out_dir_isd:", out_dir_isd),
      paste("mye_1_file:", mye_1_file), paste("mye_2_file:", mye_2_file),
      paste("mye_1_uncertainty_file:", mye_1_uncertainty_file), paste("mye_2_uncertainty_file:", mye_2_uncertainty_file),
      paste("spd_file:", spd_file), paste("spd_uncertainty_file:", spd_uncertainty_file),
      paste("pr_file:", pr_file), paste("pr_uncertainty_file:", pr_uncertainty_file),
      paste("births_file:", births_file), paste("deaths_file:", deaths_file),
      paste("emigration_file:", emigration_flows_file), paste("immigration_file:", immigration_flows_file),
      paste("emigration__uncertainty_file:", emigration_uncertainty_file), paste("immigration_uncertainty_file:", immigration_uncertainty_file),
      paste("births_rates_file:", births_rates_file), paste("deaths_rates_file:", deaths_rates_file),
      paste("emigration_rates_file:", emigration_rates_file), paste("immigration_rates_file:", immigration_rates_file),
      paste("imm_rates_draws_file:", imm_rates_draws_file),
      paste("em_rates_draws_file:", em_rates_draws_file),
      paste("birth_rates_draws_file:", birth_rates_draws_file),
      paste("death_rates_draws_file:", death_rates_draws_file),
      paste("la_rate_dispersion_file:", la_rate_dispersion_file), ""
    ),
    # capture_output(source("./dpm_config_tmb.R")),
    file = log_filepath, append = TRUE
  )
}

#' Print variables from the dpm_setup_tmb.R script into a provided log file
#'
#' @param log_filepath Path to log file
#'
#' @returns Input log file with setup objects information appended
write_setup_log <- function(log_filepath) {
  write(
    c(
      "DPM Setup:",
      paste("out_dir:", out_dir),
      paste("wrk_dir:", wrk_dir),
      paste("out_dir_isd:", out_dir_isd),
      paste("input_data_dir:", input_data_dir),
      # paste("colnames(mye_la_model_input):", capture.output(colnames(mye_la_model_input))),
      # paste("colnames(spd_la_model_input):", capture.output(colnames(spd_la_model_input))),
      # paste("colnames(pr_la_model_input):", capture.output(colnames(pr_la_model_input))),
      # paste("colnames(mye_la_uncertainty_model_input):", capture.output(colnames(mye_la_uncertainty_model_input))),
      # paste("colnames(spd_la_uncertainty_model_input):", capture.output(colnames(spd_la_uncertainty_model_input))),
      # paste("colnames(pr_la_uncertainty_model_input):", capture.output(colnames(pr_la_uncertainty_model_input))),
      # paste("colnames(births_la_model_input):", capture.output(colnames(births_la_model_input))),
      # paste("colnames(deaths_la_model_input):", capture.output(colnames(deaths_la_model_input))),
      # paste("colnames(birth_rates_la_model_input):", capture.output(colnames(birth_rates_la_model_input))),
      # paste("colnames(death_rates_la_model_input):", capture.output(colnames(death_rates_la_model_input))),
      # paste("colnames(emig_rates_la_model_input):", capture.output(colnames(emig_rates_la_model_input))),
      # paste("colnames(immig_rates_la_model_input):", capture.output(colnames(immig_rates_la_model_input))),
      # paste("colnames(la_rate_dispersion):", capture.output(colnames(la_rate_dispersion))),
      paste("length(la_list):", capture.output(length(la_list))), ""
    ),
    file = log_filepath, append = TRUE
  )
}

#' Append running information to a log file, including a text string 'tag', a time,
#' a time difference and the log filepath
#'
#' @param tag String log tag
#' @param time Current time
#' @param time_diff Time difference to log
#' @param log_filepath Path to log file
#'
#' @returns Input log file with log objects information appended
update_runtime_log <- function(tag, time, time_diff, log_filepath) {
  write(
    c(
      paste(tag, "completed at", time, "(", time_diff, ")")
    ),
    file = log_filepath, append = TRUE
  )
}
