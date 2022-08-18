---
output:
  html_document: default
  pdf_document: default
---

---
# ColeOR: R package for automating more effective and efficient processing of OR gene models. Developed with beetle genomes in mind :)
**NOTE See the file https://github.com/radamsRHA/ColeOR/blob/master/ColeOR.pdf for detailed instructions**

## Installing R package ColeOR from github
The R package ColeOR is freely available to download and distribute from github <https://github.com/radamsRHA/ColeOR/>. To install and load ColeOR, you must first install the R package `devtools`, 

```
install.packages("devtools")
```
Now using devtools we can install `ColeOR` from github:

```
library(devtools)
install_github("radamsRHA/ColeOR")
library(ColeOR) # Load package 
```
`ColeOR` also requires the following dependencies to be installed:

```
install.packages('seqinr')  
```

`ColeOR` also requires the following dependencies to be installed and available on your path `$PATH`:

* DeepTMHMM: https://biolib.com/DTU/DeepTMHMM/ (`biolib` must be in your path)
* Brief instructions for installing DeepTMHMM (from https://biolib.com/DTU/DeepTMHMM/)

```
# you can install DeepTMHMM directly from the terminal
pip3 install pybiolib
biolib run DTU/DeepTMHMM --fasta input.fasta  
```


To begin using `ColeOR` try using the examples associated with each function. 


## Example: Run `Function.RunDeepTMHMM_Pipeline` on a large fasta file

We can use `Function.RunDeepTMHMM_Pipeline` with option specified for the working directory (in this case: the Desktop) and a input file (in this case: ExampleModelsORs.fasta that is included with the ColeOR install)

```
################
# Load depends #
################
library(ColeOR)
library(seqinr)

#############################################################################################################
# get path to fasta file. 																					#
# This fasta file represents amino acid sequences for predicted OR gene models. 							#
# This file can be located on your Desktop, and we include an example fasta file with the install of ColeOR #
#############################################################################################################

#####################################
# Read example chromosome alignment #
#####################################
String.Path_ExampleModels <-  system.file("extdata", "ExampleModelsORs.fasta", package="ColeOR") # path to example file included with ColeOR

#######################
# run TMD predictions #
#######################
handle.RESULTS <- Function.RunDeepTMHMM_Pipeline(string.PathDir = '~/Desktop/', 
                                                 string.FastaFile = String.Path_ExampleModels)

```

`Function.RunDeepTMHMM_Pipeline` will run DeepTMHMM for each of the amino acid sequences provided in the given file (in this case, we used the example fasta file provided with the install)
The results will be logged in a TempFile in the working directly that `Function.RunDeepTMHMM_Pipeline` creates (on the Desktop, in this case)
Also, the results will be logged in the `handle.RESULTS` object created by `Function.RunDeepTMHMM_Pipeline`.
