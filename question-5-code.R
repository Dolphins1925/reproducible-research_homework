#QUESTION 5d CODE ON LINES 70-83

# Load relevant packages and install through the packages tab if needed
library(dplyr)
library(ggplot2)

# Check that the data has been loaded in correctly
head(Cui_etal2014)

# Check the number of rows and columns of the dataset
nrow(Cui_etal2014)   # 33 rows
ncol(Cui_etal2014) # 13 columns
# If code is ran a second time, the number of columns increases from 13 to 15
# This is due to the added log-transformed columns

# Check the names of the columns
# Are the variables I need to use in a good form for R?
colnames(Cui_etal2014)

# Make the names of Virion Volume and Genome Size cleaner
# Rename both columns in one step
Cui_etal2014 <- Cui_etal2014 %>%
  rename(
    virion_volume = `Virion volume (nmxnmxnm)`,
    genome_size = `Genome length (kb)`
  )
#  The dataset could be renamed so that the original is not overwritten

# Check that R recognises these new names
Cui_etal2014$genome_size
Cui_etal2014$virion_volume

# Visualize the relationship between genome size (x) and volume (y)
plot(Cui_etal2014$genome_size, Cui_etal2014$virion_volume, 
     main = "Scatter Plot of Virion Volume vs Genome Size",
     xlab = "Genome Size", ylab = "Virion Volume", pch = 19)

# Log transformation for volume and genome size to fit a linear model
Cui_etal2014$log_volume <- log(Cui_etal2014$virion_volume)
Cui_etal2014$log_genome_size <- log(Cui_etal2014$genome_size)

# Fit a linear model: Log-transformed volume predicted by genome size
model <- lm(log_volume ~ log_genome_size, data = Cui_etal2014)

# Summarize the model
summary(model)
# Intercept 7.0748, p-value is significant
# Log genome size 1.5152, p-value is significant

# Visualise the fitted model
plot(Cui_etal2014$log_genome_size, Cui_etal2014$log_volume, 
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

###################

# QUESTION 5d)
# Create the scatter plot with the regression line
ggplot(Cui_etal2014, aes(x = log_genome_size, y = log_volume)) +
  geom_point() +  # scatter plot
  geom_smooth(method = "lm", color = "blue", fill = "gray") +  # linear regression with confidence interval
  labs(
    x = "log [Genome length (kb)]",
    y = "log [Virion volume (nm³)]"
  ) +
  theme_minimal() # set theme the same as image

####################

# Define parameters for estimayted volume of a 300kb dsDNA virus
alpha <- 1181.807
beta <- 1.515228
L <- 300  # Genome length in kb

# Estimate virion volume (V)
Volestimate <- alpha * (L ^ beta)

# Print the estimated volume
print(Volestimate)

