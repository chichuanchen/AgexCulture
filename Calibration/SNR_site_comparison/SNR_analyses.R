################## to read and compute SNR from ROIs values that were 
################## extracted using extract_voxel_values.m

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

setwd("/home/.bml/Data/Bank1/Age_Culture/Calibration/SNR_site_comparison/extracted_values_smoothed")

matfiles = c("TW_v.mat", "TW_m.mat", 
             "US_v.mat", "US_m.mat")
num_subject = 4
num_session = 12
num_visual_vol = 192
num_motor_vol = 462


column_names <- c("peak_3wayinteraction", "outside_brain", 
                  "cor_callosum", "central_ventricle", "sinus")

TW_v_mat <- readMat("TW_v.mat")
TW_v <- as_tibble(TW_v_mat$Ym.TW.v) 

TW_m_mat <- readMat("TW_m.mat")
TW_m <- as_tibble(TW_m_mat$Ym.TW.m)

US_v_mat <- readMat("US_v.mat")
US_v <- as_tibble(US_v_mat$Ym.US.v)

US_m_mat <- readMat("US_m.mat")
US_m <- as_tibble(US_m_mat$Ym.US.m)

## Long format
calibration_data <- bind_rows(list(TW_v = TW_v,
                                   TW_m = TW_m,
                                   US_v = US_v,
                                   US_m = US_m) , .id = "site_task") %>%
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
  

# calculate_SNR <- calibration_data %>%
#   group_by(site, task, subject, session) %>%
#   summarise(signal_activation_mean = mean(peak_3wayinteraction),
#             signal_cor_callosun_mean = mean(cor_callosum),
#             signal_central_ventricle_mean = mean(central_ventricle),
#             signal_sinus_mean = mean(sinus),
#             noise_outside_sd = sd(outside_brain),
#             SNR_activation = signal_activation_mean/noise_outside_sd,
#             SNR_corca = signal_cor_callosun_mean/noise_outside_sd,
#             SNR_ventricle = signal_central_ventricle_mean/noise_outside_sd,
#             SNR_sinus = signal_sinus_mean/noise_outside_sd)

calculate_NRMS <- calibration_data %>%
  group_by(site, task, subject, session) %>%
  summarise(signal_activation_mean = mean(peak_3wayinteraction),
            signal_cor_callosun_mean = mean(cor_callosum),
            signal_central_ventricle_mean = mean(central_ventricle),
            signal_sinus_mean = mean(sinus),
            
            signal_activation_sd = sd(peak_3wayinteraction),
            signal_cor_callosun_sd = sd(cor_callosum),
            signal_central_ventricle_sd = sd(central_ventricle),
            signal_sinus_sd = sd(sinus),
#            noise_outside_sd = sd(outside_brain),
            NRMS_activation = signal_activation_sd/signal_activation_mean,
            NRMS_corca = signal_cor_callosun_sd/signal_cor_callosun_mean,
            NRMS_ventricle = signal_central_ventricle_sd/signal_central_ventricle_mean,
            NRMS_sinus = signal_sinus_sd/signal_sinus_mean)

calculate_NRMS$task <- factor(calculate_NRMS$task, levels = c("v", "m"), labels = c("Visual task", "Motor task"))

# SNR_across_sessions <- calculate_SNR %>%
#   ungroup() %>%
#   group_by(site, task, subject) %>%
#   summarise(mean_SNR_activation = mean(SNR_activation),
#             sd_SNR_activation = sd(SNR_activation),
#             mean_SNR_corca = mean(SNR_corca),
#             sd_SNR_corca = sd(SNR_corca),
#             mean_SNR_ventricle = mean(SNR_ventricle),
#             sd_SNR_ventricle = sd(SNR_ventricle),
#             mean_SNR_sinus = mean(SNR_sinus),
#             sd_SNR_sinus = sd(SNR_sinus),
#             n = n()) %>%
#   mutate(se_SNR_activation = mean_SNR_activation/sqrt(n),
#          se_SNR_corca = mean_SNR_corca/sqrt(n),
#          se_SNR_ventricle = mean_SNR_ventricle/sqrt(n),
#          se_SNR_sinus = mean_SNR_sinus/sqrt(n))

# SNR_across_sessions$task <- factor(SNR_across_sessions$task, levels = c("v", "m"), labels = c("Visual task", "Motor task"))

NRMS_across_sessions <- calculate_NRMS %>%
  ungroup() %>%
  group_by(site, task, subject) %>%
  summarise(mean_NRMS_activation = mean(NRMS_activation),
            sd_NRMS_activation = sd(NRMS_activation),
            
            mean_NRMS_corca = mean(NRMS_corca),
            sd_NRMS_corca = sd(NRMS_corca),
            
            mean_NRMS_ventricle = mean(NRMS_ventricle),
            sd_NRMS_ventricle = sd(NRMS_ventricle),
            
            mean_NRMS_sinus = mean(NRMS_sinus),
            sd_NRMS_sinus = sd(NRMS_sinus),
            
            n = n()) %>%
  mutate(se_NRMS_activation = sd_NRMS_activation/sqrt(n),
         se_NRMS_corca = sd_NRMS_corca/sqrt(n),
         se_NRMS_ventricle = sd_NRMS_ventricle/sqrt(n),
         se_NRMS_sinus = sd_NRMS_sinus/sqrt(n))

# NRMS_across_sessions$task <- factor(NRMS_across_sessions$task, levels = c("v", "m"), labels = c("Visual task", "Motor task"))

################################################### ANOVA ################# 

anova_activation <- anova(lmer(NRMS_activation ~ subject*site*task + 
                                 (1|subject), data=calculate_NRMS))

anova_corca <- anova(lmer(NRMS_corca ~ subject*site*task + 
                            (1|subject), data=calculate_NRMS))

anova_ventricle <- anova(lmer(NRMS_ventricle ~ subject*site*task + 
                            (1|subject), data=calculate_NRMS))

# anova_sinus <- anova(lmer(signal_sinus_mean ~ subject*site*task + 
#                                  (1|subject), 
#                                data=calculate_SNR))


# anova(calculate_SNR$signal_activation_mean[calculate_SNR$site == "TW" &
#                                            calculate_SNR$task == "v" & 
#                                            calculate_SNR$subject == 1],
#       calculate_SNR$signal_activation_mean[calculate_SNR$site == "US" &
#                                              calculate_SNR$task == "v" & 
#                                              calculate_SNR$subject == 1])

################################################### PLOTS #################  
output_dir = "/home/.bml/Data/Bank1/Age_Culture/Calibration/SNR_site_comparison/extracted_values_smoothed/"


## plot for acivation NRMS
ggplot(NRMS_across_sessions, aes(x = subject, y = mean_NRMS_activation*100, fill = site)) +
  geom_col(position = "dodge") +
  geom_errorbar(aes(ymax = mean_NRMS_activation*100 + se_NRMS_activation*100,
                    ymin = mean_NRMS_activation*100 - se_NRMS_activation*100),
                position = position_dodge(0.9), size = 0.6, width = 0.2) +
  ylim(0, 1.5) + 
  facet_grid(~task, labeller = label_value) +
  labs(title = "ROI center: MNI [-9, -97, 11]\n(site*task*subject interaction peak activation)\n\n\n\n\n\n\n",
       #subtitle = "ROI: 6 mm radius sphere centered at MNI [-9, -97, 11]\n(site*task*subject interaction peak activation)",
       x = "Subjects",
       y = "NRMS (%) \nacross 12 sessions",
       fill = "Site") +
  theme_bw() +
  theme(plot.title = element_text(size = 16, hjust=0.5),
        #plot.subtitle = element_text(size = 12, hjust=0.5, face = "italic"),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size =14),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        strip.text.x = element_text(size = 16),
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 14))

ggsave(last_plot(), device = "pdf", 
       dpi = 300, width = 6, units = "in",
       path = output_dir,
       filename = "NRMS_activation.pdf")

## plot for white matter NRMS
ggplot(NRMS_across_sessions, aes(x = subject, y = mean_NRMS_corca*100, fill = site)) +
  geom_col(position = "dodge") +
  geom_errorbar(aes(ymax = mean_NRMS_corca*100 + se_NRMS_corca*100, 
                    ymin = mean_NRMS_corca*100 - se_NRMS_corca*100), 
                position = position_dodge(0.9), size = 0.6, width = 0.2) + 
  ylim(0, .75) + 
  facet_grid(~task, labeller = label_value) +
  labs(title = "ROI center: MNI [0, -35, 15]\n(posterior corpus callosum)\n\n\n\n\n\n\n",
       #subtitle = "ROI: 6 mm radius sphere centered at MNI [0, -35, 15]\n(posterior corpus callosum)",
       x = "Subjects",
       y = "NRMS (%) \nacross 12 sessions",
       fill = "Site") +
  theme_bw() +
  theme(plot.title = element_text(size = 16, hjust=0.5),
        #plot.subtitle = element_text(size = 12, hjust=0.5, face = "italic"),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size =14),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        strip.text.x = element_text(size = 16),
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 14))

ggsave(last_plot(), device = "pdf", 
       dpi = 300, height = 5, units = "in",
       path = output_dir,
       filename = "NRMS_whitematter.pdf")

## plot for ventricle NRMS
ggplot(NRMS_across_sessions, aes(x = subject, y = mean_NRMS_ventricle*100, fill = site)) +
  geom_col(position = "dodge") +
  geom_errorbar(aes(ymax = mean_NRMS_ventricle*100 + se_NRMS_ventricle*100, 
                    ymin = mean_NRMS_ventricle*100 - se_NRMS_ventricle*100), 
                position = position_dodge(0.9), size = 0.6, width = 0.2) +
  ylim(0, 1.1) + 
  facet_grid(~task, labeller = label_value) +
  labs(title = "ROI center: MNI [0, 12, 8]\n(central ventricle)\n\n\n\n\n\n\n",
       #subtitle = "ROI: 6 mm radius sphere centered at MNI [0, 12, 8]\n(central ventricle)",
       x = "Subjects",
       y = "NRMS (%) \nacross 12 sessions",
       fill = "Site") +
  theme_bw() +
  theme(plot.title = element_text(size = 16, hjust=0.5),
        #plot.subtitle = element_text(size = 12, hjust=0.5, face = "italic"),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size =14),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        strip.text.x = element_text(size = 16),
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 14))

ggsave(last_plot(), device = "pdf", 
       dpi = 300, height = 5, units = "in",
       path = output_dir,
       filename = "NRMS_ventricle.pdf")

# ## plot for sinus SNR
# ggplot(SNR_across_sessions, aes(x = subject, y = mean_SNR_sinus, fill = site)) +
#   geom_col(position = "dodge") +
#   geom_errorbar(aes(ymax = mean_SNR_sinus + se_SNR_sinus, 
#                     ymin = mean_SNR_sinus - se_SNR_sinus), 
#                 position = position_dodge(0.9), size = 0.3, width = 0.2) + 
#   ylim(0, 500) + 
#   facet_grid(~task, labeller = label_value) +
#   labs(title = "SNR comparison -
#   signal ROI: sinus void of signal (3, 17, -39)
#   noise ROI: 6 mm radius sphere outside the brain",
#        x = "Subjects",
#        y = "Average SNR \nacross 12 sessions") +
#   theme(title = element_text(size = 9))
