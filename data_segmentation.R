# segment_oxygen_trials.R
# Author: Zhengquan Zhou
# Description: Segment valid oxygen measurement periods across 5 trials, and summarize by segment.

# Load required packages
library(readr)
library(dplyr)

# Set trial file names
rounds <- 1:5
file_prefix <- "respiRate_highR1_t"
file_suffix <- ".csv"

# Store summary of all segments
all_segments <- list()

# Loop through each trial file
for (r in rounds) {
  file_name <- paste0(file_prefix, r, file_suffix)
  message("Processing file: ", file_name)
  
  # Read file with UTF-16 encoding and tab delimiter
  df <- read_tsv(file_name, locale = locale(encoding = "UTF-16"))
  
  # Mark valid (non-NA) oxygen values
  df$valid <- !is.na(df$oxygen)
  
  # Initialize segment ID
  segment <- numeric(nrow(df))
  seg_id <- 0
  
  for (i in seq_len(nrow(df))) {
    if (df$valid[i]) {
      if (i == 1 || !df$valid[i - 1]) {
        seg_id <- seg_id + 1
      }
      segment[i] <- seg_id
    }
  }
  
  df$segment <- segment
  
  # Re-index to consecutive segment IDs
  used_segments <- sort(unique(df$segment[df$segment != 0]))
  segment_map <- setNames(seq_along(used_segments), used_segments)
  df$segment_reindexed <- ifelse(df$segment == 0, 0, segment_map[as.character(df$segment)])
  
  # Add round number
  df$round <- r
  
  # Summarize each segment
  segment_summary <- df %>%
    filter(segment_reindexed != 0) %>%
    group_by(round, segment = segment_reindexed) %>%
    summarise(
      start_time = first(time),
      mean_oxygen = mean(oxygen, na.rm = TRUE),
      mean_temperature = mean(temperature, na.rm = TRUE),
      .groups = "drop"
    )
  
  all_segments[[r]] <- segment_summary
}

# Combine all rounds
final_segments <- bind_rows(all_segments)

# Write output
write_csv(final_segments, "oxygen_segments_all_rounds.csv")
message("✅ Segmentation complete. Results saved to 'oxygen_segments_all_rounds.csv'.")