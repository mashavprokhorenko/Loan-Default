# Loan-Default
Data: Freddie Mac

Objective:
To determine who will most likely default on loans and what interest rate should be charged for individual borrowers.

Background:
Wall Street Journal speculates that risky mortgages, similar to those that caused the 2008 housing crisis, are making a comeback. Mortgage lenders then had improper incentives and originated risky loans that had a high incidence of default. My tool would decide if a mortgage is made based on objective factors that accurately predict low default potential by a borrower and what their interest rate should be.

Conclusions for determining interest rate:
I used a total of five methods to create five different model to estimate interest rate(Linear Regression with Best Subset Selection, Linear Regression with Validation Method, Regression Tree, Bagging, Random Forest). The Best Subset Selection and Validation Method each produced similar results; however, Best Subset Selection uses fewer variables and has the lowest MSE of 6.17.


Conclusions for predicting default:
I used a total of three different types of models (Neural Network, Support Vector Machine Radial, and Support Vector Machine Linear) and fitted with different parameters. The Support Vector Machine with gamma equaling 0.5 and cost parameter equaling 1 produced higher accuracy. The model was able to predict with 80.14% accuracy.

![RPlot7](https://user-images.githubusercontent.com/46301113/64989454-90a87380-d89b-11e9-975f-b107b317fcc8.jpg)
