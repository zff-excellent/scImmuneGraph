# scImmuneGraph
**A toolkit to count and visualize the basic properties of the single-cell immune repertoire**

## Introduction
scImmuneGraph was built to process data derived from the 10x Genomics Chromium Immune Profiling for both T-cell receptor (TCR) and immunoglobulin (Ig) enrichment workflows. This package mainly counts and visualizes the distribution, diversity and composition of clonotypes, the abundance and length distribution of CDR3, the respective abundance distribution of V and J genes, and the abundance of V-J gene pair, from which measure immune group attribution.

## Installation Package
```
library(devtools)
devtools::install_github('zff-excellent/scImmuneGraph')
library(scImmuneGraph)
```

**Other installation way**
```
install.packages('F:/R_Language/R_Practice/R_Packages/scImmuneGraph_0.1.0.tar.gz', repos = NULL, type="source")
library(scImmuneGraph)
```

## Getting Data
tcontig_list : A dataset with TCR data from the 10x Genomics Chromium Immune Profiling.
bcontig_list : A dataset with BCR data from the 10x Genomics Chromium Immune Profiling.
```
data(tcontig_list)
data(bcontig_list)
```

## Learning To Use scRepertoire
Vignette available [here](https://github.com/zff-excellent/scImmuneGraph/blob/master/vignettes/scImmuneGraph-tutorial.md), includes TCR and BCR data of four single-cell samples.

## Please Cite
Feel free to use, edit, modify scRepertoire, but if you do, please cite the manuscript.
