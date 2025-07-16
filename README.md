# Oxygen Data Segmentation Tutorial

This repository provides an example of how to segment repeated oxygen measurements into valid blocks of time using R.

## 📦 Overview

We analyze 5 rounds of oxygen measurements from 10 individuals, collected via optical sensors. Each round is stored in a separate `.csv` file. The goal is to segment continuous valid measurement periods (i.e., non-NA oxygen values) and summarize them by average oxygen and temperature levels.

This is useful when preprocessing raw oxygen sensor outputs (e.g., from PreSens systems) prior to rate calculation.

## 🗂 Repository Contents
```
.
├── README.md
├── respiRate_highR1_t1.csv
├── respiRate_highR1_t2.csv
├── respiRate_highR1_t3.csv
├── respiRate_highR1_t4.csv
├── respiRate_highR1_t5.csv
├── oxygen_segments_all_rounds.csv     # Output file
└── data_segmentation.R                # Main R script
```

## 🧪 Required R Packages

- `readr`
- `dplyr`

Install them (if needed):

```r
install.packages(c("readr", "dplyr"))
```

## 🚀 How to Run

Open R or RStudio and from the same directory as the script and data, run:
```r
source('data_segmentation.R')
```

The script will:
	1.	Read all 5 trial files.
	2.	Identify valid measurement segments (non-NA oxygen).
	3.	Assign segment IDs and summarize:
	•	start_time
	•	mean_oxygen
	•	mean_temperature
	4.	Save results as oxygen_segments_all_rounds.csv.

## 📤 Output File: oxygen_segments_all_rounds.csv
| Column Name       | Description                         |
|-------------------|-------------------------------------|
| `round`           | Trial round (1 to 5)                |
| `segment`         | Unique segment ID within round      |
| `start_time`      | First timestamp of the segment      |
| `mean_oxygen`     | Average oxygen value (µmol/L)       |
| `mean_temperature`| Average temperature (°C)            |

## 📄 Citation

If you use or modify this repository, feel free to cite or contact the author, visit:  
🔗 [Zhengquan Zhou on ResearchGate](https://www.researchgate.net/profile/Zhengquan-Zhou)

---

© 2025 @zqzhou7
