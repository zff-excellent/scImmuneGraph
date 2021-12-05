---
author: "Introduction to scImmuneGraph"
date: "2021-12-05"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteEngine{knitr::knitr}
  %\VignetteIndexEntry{Title of your vignette}
  %\usepackage[UTF-8]{inputenc}
  %\VignetteEncoding{UTF-8}
---

***
## Installation Package
```r
rm(list=ls())
library(devtools)
devtools::install_github('zff-excellent/scImmuneGraph')
library(scImmuneGraph)
```

## Converting 10X genomics produced B cell contigs file(s) as a list outputed
- For TCR 

```
project_data_dir <- "F:/R_Language/data/tcr"
sample_name <- list.dirs(project_data_dir, full.names = FALSE, recursive = FALSE)
group_name <- c("A", "A", "B", "B")

contig_list <- TCR.ContigList(project_data_dir, sample_name, group_name)
```
- For BCR
```
project_data_dir <- "F:/R_Language/data/bcr"
sample_name <- list.dirs(project_data_dir, full.names = FALSE, recursive = FALSE)
group_name <- c("A", "A", "B", "B")

contig_list <- BCR.ContigList(project_data_dir, sample_name, group_name)
```

## Getting Data
- tcontig_list : A dataset with TCR data from the 10x Genomics Chromium Immune Profiling.
- bcontig_list : A dataset with BCR data from the 10x Genomics Chromium Immune Profiling.
```r
data(tcontig_list)
data(bcontig_list)
```

## TCR basic information statistics

```r
contig_list <- tcontig_list
sample_name <- names(contig_list)

multi_plots <- TCR.ClonalStateDistribution(contig_list, sample_name)
cowplot::plot_grid(plotlist=multi_plots)
```

```r

# Or all functions as the same call way
multi_plots <- BasicPlot(TCR.ClonalStateDistribution, contig_list, sample_name) 
multi_plots <- BasicPlot(TCR.top100ClonotypeAbundance, contig_list, sample_name)
multi_plots <- BasicPlot(TCR.ClonotypeComposition, contig_list, sample_name) # Diversity 
multi_plots <- BasicPlot(TCR.top100CDR3Abundance, contig_list, sample_name) 
multi_plots <- BasicPlot(TCR.CDR3ntLengthDistribution, contig_list, sample_name) 
multi_plots <- BasicPlot(TCR.VgeneAbundance, contig_list, sample_name) 
multi_plots <- BasicPlot(TCR.JgeneAbundance, contig_list, sample_name) 
multi_plots <- BasicPlot(TCR.VJgenePair, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-2.png)

***

## BCR basic information statistics


```r
# contig_list <- BCR.ContigList(project_data_dir, sample_name, group_name)
contig_list <- bcontig_list
sample_name <- names(contig_list)
multi_plots <- BasicPlot(BCR.ClonalStateDistribution, contig_list, sample_name) 
multi_plots <- BasicPlot(BCR.top100ClonotypeAbundance, contig_list, sample_name) 
multi_plots <- BasicPlot(BCR.ClonotypeComposition, contig_list, sample_name) 
multi_plots <- BasicPlot(BCR.top100CDR3Abundance, contig_list, sample_name)
multi_plots <- BasicPlot(BCR.CDR3ntLengthDistribution, contig_list, sample_name)
multi_plots <- BasicPlot(BCR.VgeneAbundance, contig_list, sample_name)
multi_plots <- BasicPlot(BCR.JgeneAbundance, contig_list, sample_name) 
multi_plots <- BasicPlot(BCR.VJgenePair, contig_list, sample_name) 
```

***
