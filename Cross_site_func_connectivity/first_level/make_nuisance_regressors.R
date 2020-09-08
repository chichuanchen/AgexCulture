################## to read values from ROIs that were extracted using extract_voxel_values.m
################## write txt files for nuisance regressors

# libraries
#####
install.packages("R.matlab")
install.packages("dplyr")
install.packages("tidyr")
install.packages("lme4")
install.packages("lmerTest")
install.packages("ggplot2")
library("R.matlab")
library("tidyr")
library("dplyr")
library("lme4")
library("lmerTest")
library("ggplot2")

#####
rm(list = ls())

num_subject = 4
num_session = 12
num_visual_vol = 192
num_motor_vol = 462

PATH_TW = "/home/.bml/Data/Bank1/Age_Culture/Calibration/TW/Nifti/"
PATH_US = "/home/.bml/Data/Bank1/Age_Culture/Calibration/US/Nifti/"

VAR_PATH = "/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/"
setwd(VAR_PATH)

# read mat files
matfiles = c("TW_v.mat", "TW_m.mat", 
             "US_v.mat", "US_m.mat")
column_names <- c("WM", "CSF")

TW_v_mat <- readMat("TW_v.mat")
TW_v_og <- as_tibble(TW_v_mat$Ym.TW.v) 

TW_m_mat <- readMat("TW_m.mat")
TW_m_og <- as_tibble(TW_m_mat$Ym.TW.m)

US_v_mat <- readMat("US_v.mat")
US_v_og <- as_tibble(US_v_mat$Ym.US.v)

US_m_mat <- readMat("US_m.mat")
US_m_og <- as_tibble(US_m_mat$Ym.US.m)

# add data information
TW_v <- TW_v_og %>%
  setNames(column_names) %>%
  mutate(site = "TW",
         task = "v",
         subject = rep(1:num_subject, each = num_visual_vol*num_session),
         session = rep(1:num_session, each = num_visual_vol, times = num_subject))

TW_m <- TW_m_og %>%
  setNames(column_names) %>%
  mutate(site = "TW",
         task = "m",
         subject = rep(1:num_subject, each = num_motor_vol*num_session),
         session = rep(1:num_session, each = num_motor_vol, times = num_subject))

US_v <- US_v_og %>%
  setNames(column_names) %>%
  mutate(site = "US",
         task = "v",
         subject = rep(1:num_subject, each = num_visual_vol*num_session),
         session = rep(1:num_session, each = num_visual_vol, times = num_subject))

US_m <- US_m_og %>%
  setNames(column_names) %>%
  mutate(site = "US",
         task = "m",
         subject = rep(1:num_subject, each = num_motor_vol*num_session),
         session = rep(1:num_session, each = num_motor_vol, times = num_subject))

# write nuisance regressor out as a txt file for each session
for (subj in 1:num_subject) {
  for (sess in 1:num_session) {
    
    TW_v_out <- TW_v %>%
      filter(subject == subj, session == sess) %>%
      select(WM, CSF) 
      
    TW_m_out <- TW_m %>%
      filter(subject == subj, session == sess) %>%
      select(WM, CSF) 
    
    US_v_out <- US_v %>%
      filter(subject == subj, session == sess) %>%
      select(WM, CSF) 
    
    US_m_out <- US_m %>%
      filter(subject == subj, session == sess) %>%
      select(WM, CSF) 
    
    write.table(TW_v_out, row.names = F, col.names = F, sep = "   ",
                file = paste0(PATH_TW, "sub-", subj, "/ses-", sess, "/func/",
                              "nuisance_WM_CSF_sub-",subj,"_ses-",sess,"_task-visual_acq-EPI_bold.txt"))
    write.table(TW_m_out, row.names = F, col.names = F, sep = "   ",
                file = paste0(PATH_TW, "sub-", subj, "/ses-", sess, "/func/",
                              "nuisance_WM_CSF_sub-",subj,"_ses-",sess,"_task-motor_acq-EPI_bold.txt"))
    write.table(US_v_out, row.names = F, col.names = F, sep = "   ",
                file = paste0(PATH_US, "sub-", subj, "/ses-", sess, "/func/",
                              "nuisance_WM_CSF_sub-",subj,"_ses-",sess,"_task-visual_acq-EPI_bold.txt"))
    write.table(US_m_out, row.names = F, col.names = F, sep = "   ",
                file = paste0(PATH_US, "sub-", subj, "/ses-", sess, "/func/",
                              "nuisance_WM_CSF_sub-",subj,"_ses-",sess,"_task-motor_acq-EPI_bold.txt"))
  }
}


# pull all data into one big data frame (not necessary if the goal is to generate a txt file for each session)
##### 
#Long format, each row is a volume
nuisance_per_volume <- bind_rows(list(TW_v = TW_v_og,
                                   TW_m = TW_m_og,
                                   US_v = US_v_og,
                                   US_m = US_m_og) , .id = "site_task") %>%
  setNames(c("site_task", column_names)) %>%
  separate(site_task, c("site", "task"), sep = "_") %>%
  mutate(
    subject = rep(
      c(rep(1:num_subject, each = num_visual_vol*num_session), 
        rep(1:num_subject, each = num_motor_vol*num_session)), 
      times = 2),
    session = rep(
      c(rep(1:num_session, each = num_visual_vol, times = num_subject), 
        rep(1:num_session, each = num_motor_vol, times = num_subject)), 
      times = 2)) 


  
  
  




