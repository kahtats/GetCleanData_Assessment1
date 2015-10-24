# Getting and Cleaning Data: Peer Assessment 1
Seah Kah Tat

## Introduction
This repository is created as part of a project for a course in Getting and Cleaning Data to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The data used for this project were collected from the accelerometers from the Samsung Galaxy S smartphone. [A full description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is available at the site where the data was obtained. Data for this project can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

This repository contains the following files:
* "README.md".
* "run_analysis.R": script to download the data, process it and output a tidy data set "tidydataset.txt".
* "tidydataset.txt": a tidy data set created by running "run_analysis.R" script to clean up the data.
* "CodeBook.md": code book that describes the variables, the data, and any transformations performed to clean up the data.

## Instructions
Run the R script "run_analysis.R" works on an R-programming console. The script will download and extract the data from the zip file and then process the data before it outputs a tidy data set "tidydataset.txt" in text format.
