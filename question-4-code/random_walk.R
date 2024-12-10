#install.packages("ggplot2")
#install.packages("gridExtra")

library(ggplot2)
library(gridExtra)

random_walk  <- function (n_steps, seed = NULL) {
  
  if (!is.null(seed)) {
    set.seed(seed) # set the seed for reproducibility
  }
  
  df <- data.frame(x = rep(NA, n_steps), y = rep(NA, n_steps), time = 1:n_steps)
  
  df[1,] <- c(0,0,1) # starting point
  
  for (i in 2:n_steps) {
    
    h <- 0.25 # step size
    
    angle <- runif(1, min = 0, max = 2*pi) # random angle 
    
    df[i,1] <- df[i-1,1] + cos(angle)*h # update x-coordination
    
    df[i,2] <- df[i-1,2] + sin(angle)*h # update y-coordinate
    
    df[i,3] <- i # update time step
    
  }
  
  return(df)
  
}

# simulate two random walks with reproducible seeds

data1 <- random_walk(500, seed = 25 )

plot1 <- ggplot(aes(x = x, y = y), data = data1) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate") +
  
  ggtitle ("Brownian Motion (Seed = 25)")


data2 <- random_walk(500, seed = 98)

plot2 <- ggplot(aes(x = x, y = y), data = data2) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate") +
  
  ggtitle("Brownian Motion (Seed = 98)")

grid.arrange(plot1, plot2, ncol=2)
