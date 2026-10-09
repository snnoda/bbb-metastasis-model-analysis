# Input file directory
base_path <- "/path/to/input/"

# File numbers
file_nums <- sprintf("%02d", 1:12)

# Store results
results_list <- list()

for (num in file_nums) {
file_name <- paste0("sample_", num, "_results.csv")
file_path <- file.path(base_path, file_name)

# Read the result CSV
df <- read.csv(file_path, header = TRUE)

# Number of ROIs
roi_count <- nrow(df)

# Sum of ROI areas
area_sum <- sum(df$Area)

# Area-weighted mean fluorescence intensity
weighted_mean <- sum(df$Area * df$Mean) / area_sum

# Result of each image
results_list[[num]] <- data.frame(
file = file_name,
roi_count = roi_count,
area_sum = area_sum,
mean_mean = weighted_mean
)
}

# Combine results from all images
final_results <- do.call(rbind, results_list)

# Save the summary results
output_csv <- file.path(base_path, "sample_summary_results.csv")
write.csv(final_results, output_csv, row.names = FALSE)

print(paste("All results saved to:", output_csv))
