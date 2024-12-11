#QUESTION 5d CODE ON LINES 81-94

# Load relevant packages and install through the packages tab if needed
library(dplyr)
library(ggplot2)

head(Cui_etal2014)

# make a copy of the original dataset to avoid overwriting
cui_data <- Cui_etal2014

# Check that the data has been loaded in correctly
head(cui_data)

# Check the number of rows and columns of the dataset
nrow(cui_data)   # 33 rows
ncol(cui_data) # 13 columns
# If code is ran a second time, the number of columns increases from 13 to 15
# This is due to the added log-transformed columns

# Check the names of the columns
# Are the variables I need to use in a good form for R?
colnames(cui_data)

# Make the names of Virion Volume and Genome Size cleaner
# Rename both columns in one step
cui_clean <- cui_data %>%
  rename(
    virion_volume = `Virion volume (nmxnmxnm)`,
    genome_size = `Genome length (kb)`
  )
#  The dataset could be renamed so that the original is not overwritten

# Check that R recognises these new names
cui_clean$genome_size
cui_clean$virion_volume

# Visualize the relationship between genome size (x) and volume (y)
plot(cui_clean$genome_size, cui_clean$virion_volume, 
     main = "Scatter Plot of Virion Volume vs Genome Size",
     xlab = "Genome Size", ylab = "Virion Volume", pch = 19)

# Log transformation for volume and genome size to fit a linear model
cui_clean$log_volume <- log(cui_clean$virion_volume)
cui_clean$log_genome_size <- log(cui_clean$genome_size)

# Fit a linear model: Log-transformed volume predicted by genome size
model <- lm(log_volume ~ log_genome_size, data = cui_clean)

# Summarize the model
summary(model)
# Intercept 7.0748, p-value is significant
# Log genome size 1.5152, p-value is significant

# Visualise the fitted model
plot(cui_clean$log_genome_size, cui_clean$log_volume, 
     main = "Log-Transformed Volume vs Log-Transformed Genome Size",
     xlab = "log(Genome Size)", ylab = "log(Volume)", pch = 19)
abline(model, col = "red")

# Check residuals for diagnostics
par(mfrow = c(2, 2))
plot(model)
# The linear model is not perfect 

alpha <- exp(coef(model)[1])  # Scaling factor α
beta <- coef(model)[2]       # Exponent β
alpha
beta

# Extract p-values
p_values <- summary(model)$coefficients[, 4]
p_values

# confidence intervals
conf_intervals <- confint(model)
conf_intervals
alpha_CI <- exp(conf_intervals[1, ])
alpha_CI

###################

# QUESTION 5d)
# Create the scatter plot with the regression line
ggplot(cui_clean, aes(x = log_genome_size, y = log_volume)) +
  geom_point() +  # scatter plot
  geom_smooth(method = "lm", color = "blue", fill = "gray") +  # linear regression with confidence interval
  labs(
    x = "log [Genome length (kb)]",
    y = "log [Virion volume (nm³)]"
  ) +
  theme_minimal() # set theme the same as image

####################

# Define parameters for estimated volume of a 300kb dsDNA virus
alpha <- 1181.807
beta <- 1.515228
L <- 300000  # Genome length in nucleotides from kb

# Estimate virion volume (V)
Volestimate <- alpha * (L ^ beta)

# Print the estimated volume
print(Volestimate)

