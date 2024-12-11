# Reproducible research: version control and R

\# INSERT ANSWERS HERE #

4. a) The graphs show examples of Brownian motion- small and random changes in direction which create unique paths each time that the code is run. The random nature of the paths create areas of denser and sparser lines, often leaving large areas of white space. The line starts on the same coordinates each time (0,0), but the axes may be different on the graphs. The code also embeds another element of time, another random function which is represented in shades of blue in the graphs. The darker the blue, the less time is spent on a particular part of the path.

b) The random seeds term allows for a psuedo-random number to be generated. A seed is required to generate these numbers and are already stored in R. For example, in this code, a number is generated to create the path, which appears to be unqiue each time. In reality, this random number generation is deterministic, simply setting the seed as a specific number, the same path is generated again. This function allows for reproducibility within any simulation or analysis which calls for randomisation.

c) The script has been edited, commited and pushed to the repo. The changes include a seed argument so that the seed can be set, two seed values set for reproducibility, and notes within the code and on the graphs to allow people accessing the code to undertand how the graohs have been produced.

d)
![image](https://github.com/user-attachments/assets/a21451bd-7e14-452c-90ca-d44d08030ac9)
![image](https://github.com/user-attachments/assets/77594a6a-9588-4ea8-8233-545796f21044)
![image](https://github.com/user-attachments/assets/6bdf147a-530b-48dd-8b5f-2e707d54b1c7)

5. a) Data for double-stranded DNA viruses uploaded. The table has 33 rows and 13 columns.

b) For this particular dataset, log-transforming both the Genome length (kb) and the Virion Volume (nm^3) allows for a linear model to be applied. I have applied this transformation in the script entitled **question-5-code.R** where a line can be fitted through. When checking the residuals on a Q-Q residuals plot, the fit is not perfect but is relatively good so we can still assume normality for any futher anlysis on the log-transformed data.

c) The exponent (β) can be taken as the regression line for this model, annotated as the log-genome size coefficient in our model. This is 1.515228 in our model with a p-value of 6.44e-10, making this value significant and with confidence interval 1.163426 - 1.867030. The value in the paper is 1.52 (1.16–1.87), which is the same as the value I calculated from my model. The confidence intervals that we calculated are also the same, considering rounding. The scaling factor (α) can be taken as the intercept of the regression line, which needs to have the exponential taken to state the exact value. My model shows that ln(α) is 7.0748, and so α is 1181.807 with a p-value of 2.28e-10, making this value significant and with confidence interval 246.1069 – 5675.04389. The value in the paper is 1,182 (246–5,675), which is similarly identical to my value and confidence intervals. To conclude, I found the same values in my model as in the paper (when taking into account the rounding performed in the paper).

d) Code can also be found in the Rscript **question-5-code.R**. Create the scatter plot with the regression line
ggplot(Cui_etal2014, aes(x = log_genome_size, y = log_volume)) +
  geom_point() +  # scatter plot
  geom_smooth(method = "lm", color = "blue", fill = "gray") +  # linear regression with confidence interval
  labs(
    x = "log [Genome length (kb)]",
    y = "log [Virion volume (nm³)]"
  ) +
  theme_minimal() # set theme the same as image

e) The estimated volume of a 300kb dsDNA virus using the allometric equation V= αL^β, where V is the virion volume in nm^3, L is the genome length in nucleotides (300kb is equal to 300,000 nucleotides), alpha is 1181.807, and beta is 1.515228, is equal to 2.353×10^11 (235,306,564,197)nm^3.

## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points. First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers (also make sure that your username has been anonymised). All answers should be on the `main` branch.

## Assignment questions 

1) (**10 points**) Annotate the **README.md** file in your `logistic_growth` repo with more detailed information about the analysis. Add a section on the results and include the estimates for $N_0$, $r$ and $K$ (mention which *.csv file you used).
   
2) (**10 points**) Use your estimates of $N_0$ and $r$ to calculate the population size at $t$ = 4980 min, assuming that the population grows exponentially. How does it compare to the population size predicted under logistic growth? 

3) (**20 points**) Add an R script to your repository that makes a graph comparing the exponential and logistic growth curves (using the same parameter estimates you found). Upload this graph to your repo and include it in the **README.md** file so it can be viewed in the repo homepage.
   
4) (**30 points**) Sometimes we are interested in modelling a process that involves randomness. A good example is Brownian motion. We will explore how to simulate a random process in a way that it is reproducible:

   a) A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points) \
   b) Investigate the term **random seeds**. What is a random seed and how does it work? (5 points) \
   c) Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points) \
   d) Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points) 

5) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \alpha L^{\beta}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   a) Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)\
   b) What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points) \
   c) Find the exponent ($\beta$) and scaling factor ($\alpha$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points) \
   d) Write the code to reproduce the figure shown below. (10 points) 

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  e) What is the estimated volume of a 300 kb dsDNA virus? (4 points) 
