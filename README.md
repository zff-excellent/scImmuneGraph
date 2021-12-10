# scImmuneGraph
**A toolkit to count and visualize the basic properties of the single-cell immune repertoire**

## Introduction
scImmuneGraph was built to process data derived from the 10x Genomics Chromium Immune Profiling for both T-cell receptor (TCR) and immunoglobulin (Ig) enrichment workflows. This package mainly counts and visualizes the distribution, diversity and composition of clonotypes, the abundance and length distribution of CDR3, the respective abundance distribution of V and J genes, and the abundance of V-J gene pair, from which measure immune group attribution.

## Installation Package

The scImmuneGraph is available on [CRAN](https://cran.r-project.org/web/packages/scImmuneGraph/index.html) and can be installed via
```
install.packages('scImmuneGraph')
library(scImmuneGraph)
```
To install the development version of the package from GitHub
```
library(devtools)
devtools::install_github('zff-excellent/scImmuneGraph')
library(scImmuneGraph)
```

**Other installation way**
```
install.packages('F:/R_Language/scImmuneGraph_0.1.0.tar.gz', repos = NULL, type="source")
library(scImmuneGraph)
```

## Getting Data
tcontig_list : TCR dataset from the 10x Genomics Chromium Immune Profiling.   
bcontig_list : BCR dataset from the 10x Genomics Chromium Immune Profiling.
```
data(tcontig_list)
data(bcontig_list)
```

## Learning To Use scRepertoire
Vignette available [here](https://zff-excellent.github.io/vignettes/scImmuneGraph-tutorial.html), includes TCR and BCR data of four single-cell samples.

## Please Cite
Feel free to use, edit, modify scRepertoire, but if you do, please cite the manuscript.
