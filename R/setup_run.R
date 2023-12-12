if (!exists("t_start")) {
  t_start <- Sys.time()
}
################################################################################

################################################################################
#########################  0. PATHS  #########################
################################################################################
dpm_data_dir <- "//tdata21/isd/DPM/Demographic Accounts/Data/England and Wales/John_Bryant_approach/DPM_data/"

input_data_folder <- "la_annual_jun23"

out_dir <- "default" # Set to "default" to create/use a "/dpm-account-local-authority-outputs" folder next to code repo location

out_folder_isd <- "ChangeMe" # Name for ISD output folder (to store all_summary/diagnostics.csv) - create in dpm_setup.R (if not already created)

out_dir_isd <- paste0(dpm_data_dir, input_data_folder, "/outputs/", out_folder_isd)

code_path <- dirname(rstudioapi::getActiveDocumentContext()$path)
################################################################################


################################################################################
###################  1. CREATE OUTPUT & WORKING DIRECTORIES  ###################
################################################################################
# Create the wrk_dir/out_dir/out_dir_isd folders if they don't already exist
#   o out_dir created next to code repo folder (DEFAULT: dpm-account-local-authority-outputs)
#   o wrk_dir temp folder created within repo code location (not git version controlled - .gitignored)
#   o out_dir_isd dpm network storage location to export all_summary & diagnostics csv files

# DEFAULT out_dir 'dpm-account-local-authority-outputs' created next to 'dpm-account-local-authority' location
if ((out_dir == "default") | (!exists("out_dir"))) {
  out_dir <- paste0(gsub("/dpm-tmb-account-local-authority.*", "", code_path), "/dpm-tmb-account-local-authority-outputs") # Don't change
}

if (!dir.exists(out_dir)) {
  dir.create(out_dir, recursive = T)
}

# DEFAULT wrk_dir created within code folder
wrk_dir <- paste0(code_path, "/temp") # Shouldn't need to change

# Create if not already present
if (!dir.exists(wrk_dir)) {
  dir.create(wrk_dir, recursive = T)
}

# DEFAULT our_dir_isd created in an 'outputs' folder within input_data_folder - specific folder name assigned in dpm_config.R
if (!dir.exists(out_dir_isd)) {
  dir.create(out_dir_isd, recursive = T)
}
################################################################################

################################################################################
##############################  2. LOAD PACKAGES  ##############################
################################################################################
# source("./models/dpm_model_tmb.R") # Contains 'run_mod_tmb()' function used in foreach - takes input data, produces res.RDS, summary.csv, diagnostics.csv
# source("./helpers/dpm_functions.R") # Contains DPM specific functions
# source("./helpers/requirements.R") # Package install/import function - pkgLoad()
# pkgLoad(dpm_packages)
################################################################################

################################################################################
############################  3. LOAD DATA FOR DPM  ############################
################################################################################
t_start_data <- Sys.time()

# Construct input_data_dir from dpm_data_dir, input_data_folder and live_data
input_data_dir <- paste0(dpm_data_dir, input_data_folder, "/live_data")
