# Loan-Default
Data: Freddie Mac

Objective:
To determine who will most likely default on loans and what interest rate should be charged for individual borrowers.

Background:
Wall Street Journal speculates that risky mortgages, similar to those that caused the 2008 housing crisis, are making a comeback. Mortgage lenders then had improper incentives and originated risky loans that had a high incidence of default. My tool would decide if a mortgage is made based on objective factors that accurately predict low default potential by a borrower and what their interest rate should be.

Conclusions for determining interest rate:
I used a total of five methods to create five different model to estimate interest rate(Linear Regression with Best Subset Selection, Linear Regression with Validation Method, Regression Tree, Bagging, Random Forest). The Best Subset Selection and Validation Method each produced similar results; however, Best Subset Selection uses fewer variables and has the lowest MSE of 6.17.

Therefore, the equation to predict the interest rate is
$\hat{y} = 8.533913944+ -2.493757087*default-0.004593636*credit_sc+0.007856611*insur_perc+0.234221106*num_units-1.093213175*conforming$

Conclusions for predicting default:
I used a total of three different types of models (Neural Network, Support Vector Machine Radial, and Support Vector Machine Linear) and fitted with different parameters. The Support Vector Machine with gamma equaling 0.5 and cost parameter equaling 1 produced higher accuracy. The model was able to predict with 80.14% accuracy.

