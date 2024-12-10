library(dplyr)
library(ggplot2)

head(Cui_etal2014)

# Check the dimensions of the dataset
rows <- nrow(Cui_etal2014)   # Number of rows
columns <- ncol(Cui_etal2014) # Number of columns

rows
columns

colnames(Cui_etal2014)


library(dplyr)

# Rename both columns in one step
#Cui_etal2014 <- Cui_etal2014 %>%
  rename(
    virion_volume = `Virion volume (nmxnmxnm)`,
    genome_size = `Genome length (kb)`
  )


Cui_etal2014$genome_size
Cui_etal2014$virion_volume

# Visualize the relationship between genome size (x) and volume (y)
plot(Cui_etal2014$genome_size, Cui_etal2014$virion_volume, 
     main = "Scatter Plot of Virion Volume vs Genome Size",
     xlab = "Genome Size", ylab = "Virion Volume", pch = 19)

# Log transformation for volume if necessary
#Cui_etal2014$log_volume <- log(Cui_etal2014$virion_volume)
#Cui_etal2014$log_genome_size <- log(Cui_etal2014$genome_size)

# Fit a linear model: Log-transformed volume predicted by genome size
model <- lm(log_volume ~ log_genome_size, data = Cui_etal2014)

# Summarize the model
summary(model)

# Visualize the fitted model
plot(Cui_etal2014$log_genome_size, Cui_etal2014$log_volume, 
     main = "Log-Transformed Volume vs Log-Transformed Genome Size",
     xlab = "log(Genome Size)", ylab = "log(Volume)", pch = 19)
abline(model, col = "red")

# Check residuals for diagnostics
par(mfrow = c(2, 2))
plot(model)

alpha <- exp(coef(model)[1])  # Scaling factor α
beta <- coef(model)[2]       # Exponent β
alpha
beta

# Extract p-values
p_values <- summary(model)$coefficients[, 4]
p_values


# Create the scatter plot with the regression line
ggplot(Cui_etal2014, aes(x = log_genome_size, y = log_volume)) +
  geom_point() +  # scatter plot
  geom_smooth(method = "lm", color = "blue", fill = "gray") +  # linear regression with confidence interval
  labs(
    x = "log [Genome length (kb)]",
    y = "log [Virion volume (mm³)]"
  ) +
  theme_minimal()  # optional: for cleaner background

# Define parameters
alpha <- 1181.807
beta <- 1.515228
L <- 300  # Genome length in kb

# Estimate virion volume (V)
V_estimate <- alpha * (L ^ beta)

# Print the estimated volume
print(V_estimate)

