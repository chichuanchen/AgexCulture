################## to read and compute SNR from ROIs values that were 
################## extracted using extract_voxel_values.m

install.packages("R.matlab")
install.packages("dplyr")
install.packages("tidyr")
install.packages("lme4")
install.packages("lmerTest")
install.packages("ggplot2")
install.packages("ggpubr")
library("R.matlab")
library("tidyr")
library("dplyr")
library("lme4")
library("lmerTest")
library("ggplot2")
library("ggpubr")

setwd("/home/.bml/Data/Bank1/Age_Culture/Calibration/voxelwise_site_correlation/output_variables/")
mat_files <- list.files()

# mat_var = "m_mean_1.mat"
# mat_var = mat_files[2]
# write a function to pull the two lists in a variable into 2 columns of a tibble
plot_signal_scatter_sites <- function(mat_var){
  
  mat_inR <- readMat(mat_var)
  
  TW <- as.vector(unlist(mat_inR[grepl("TW", names(mat_inR))]))
  US <- as.vector(unlist(mat_inR[grepl("US", names(mat_inR))]))
  mytibble <- as_tibble(cbind(TW, US))
  
  # get correlation
  correlation <- cor.test(mytibble$TW, mytibble$US, method = "pearson")
  
  individualize <- list(subject_num = as.numeric(regmatches(mat_var, gregexpr("[[:digit:]]+", mat_var))),
                        task = ifelse(as.logical(grepl("m_", mat_var)), "motor", "visual"),
                        value_type = ifelse(as.logical(grepl("mean", mat_var)), "averaged", "variance"),
                        corr_r = round(as.numeric(correlation$estimate), digits = 2),
                        corr_p = ifelse(as.numeric(correlation$p.value) < 0.001, "p < .001",
                                        ifelse(as.numeric(correlation$p.value) < 0.01, "p < .01",
                                               ifelse(as.numeric(correlation$p.value) < 0.05, "p < .05"))))
  ## scatter plot
  ggplot() +
    geom_point(data = mytibble, aes(x = TW, y = US), alpha = 0.25, size = 3, color = "#F53D52") +
    geom_abline(slope = 1, intercept = 0, size = 1.5, linetype = 2) +
#    coord_fixed() +
    labs(title = paste0("r = ", individualize$corr_r, ", ", individualize$corr_p),
         # subtitle = ifelse(individualize$value_type == "averaged", 
         #                   "T values averaged across 12 sessions",
         #                   "T value variance across 12 sessions"),
         x = "Taiwan Site",
         y = "U.S.A. Site") +
    theme_bw() +
    theme(plot.title = element_text(size = 36, hjust=0.5),
          #plot.subtitle = element_text(size = 24, hjust=0.5, face = "italic"),
          axis.text.x = element_text(size = 25),
          axis.text.y = element_text(size = 25),
          axis.title.x = element_text(size = 30),
          axis.title.y = element_text(size = 30))
  
  output_dir = "/home/.bml/Data/Bank1/Age_Culture/Calibration/voxelwise_site_correlation/Rplots/"
  
  ggsave(last_plot(), device = "png", 
         dpi = 300, width = 6, units = "in",
         path = output_dir,
         filename = paste("subj", 
                          individualize$subject_num, 
                          individualize$task, 
                          individualize$value_type,
                          ".png",
                          sep = "_"))
  
}

lapply(mat_files, plot_signal_scatter_sites)



