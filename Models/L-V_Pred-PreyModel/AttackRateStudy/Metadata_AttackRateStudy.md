# Lotka-Volterra Predator-Prey Model
## Example of a parameter study

This directory contains data produced from the discrete-time, Lotka-Volterra predator-prey model, "predPreyModelParameterStudy.R", on March 6, 2017, by Sam Flaxman (https://github.com/flaxmans/CompBio_on_git/tree/master/Models/L-V_Pred-PreyModel).  These data were produced to conduct a study of the effects of varying the attack rate parameter.

This markdown file is a duplicate of the plain text metadata file, just for the purposes of comparison.

### Running the model:

Running the model requires specifying 7 parameters:

1. `a`: 	the attack rate
2. `r`: 	the intrinsic growth rate of prey
3. `m`: 	the intrinsic mortality rate of predators
4. `cc`: 	the conversion coefficient for turning prey consumed into predator births

5. `initPrey`: 	the initial abundance of prey at time step 1
6. `initPred`: 	the initial abundance of predators at time step 1
7. `gens`: 		the last generation of the model's calculation through time

Parameter values used to produce the results were as follows:
`a` was varied from `0.001` to `0.1` in steps of `0.001`.  
Other parameters were:
```
gens <- 1000
initPrey <- 100 
initPred <- 10 
r <- 0.2
m <- 0.05
cc <- 0.1
```

The results are stored in two data files, "PredatorDataAttackRateStudy.csv" and "PreyDataAttackRateStudy.csv".  The layout of these files is as follows:

* Column 1, `runID`, is a unique integer identifier for a given row of data.  This enables explicit cross-referencing of data between the two files.
* Columns 2-5 give the values of the following four parameters, in this respective order: `r`, `m`, `cc`, `a`.
* The remaining columns have headers "1, 2, 3, ..., 1000".  These columns store the time series data.  The value of `initPrey` or `initPred` is found in the first of these (column 6 in the prey or predator data file, respectively), and the value of `gens` is given by the header of the last column.

