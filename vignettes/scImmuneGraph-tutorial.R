## ---- echo=FALSE, results="hide", message=FALSE-------------------------------
knitr::opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)
library(BiocStyle)

## -----------------------------------------------------------------------------
suppressMessages(library(scImmuneGraph))

## -----------------------------------------------------------------------------
data(tcontig_list)
data(bcontig_list)

## -----------------------------------------------------------------------------
contig_list <- tcontig_list
sample_name <- names(contig_list)

multi_plots <- TCR.ClonalStateDistribution(contig_list, sample_name)
cowplot::plot_grid(plotlist=multi_plots)

## -----------------------------------------------------------------------------
# Or all functions as the same call way
multi_plots <- BasicPlot(TCR.ClonalStateDistribution, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(TCR.top100ClonotypeAbundance, contig_list, sample_name)
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(TCR.ClonotypeComposition, contig_list, sample_name) # Diversity 
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(TCR.top100CDR3Abundance, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(TCR.CDR3ntLengthDistribution, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(TCR.VgeneAbundance, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(TCR.JgeneAbundance, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(TCR.VJgenePair, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)

## -----------------------------------------------------------------------------
# contig_list <- BCR.ContigList(project_data_dir, sample_name, group_name)
contig_list <- bcontig_list
sample_name <- names(contig_list)
multi_plots <- BasicPlot(BCR.ClonalStateDistribution, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(BCR.top100ClonotypeAbundance, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(BCR.ClonotypeComposition, contig_list, sample_name) 
# cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(BCR.top100CDR3Abundance, contig_list, sample_name)
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(BCR.CDR3ntLengthDistribution, contig_list, sample_name)
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(BCR.VgeneAbundance, contig_list, sample_name)
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(BCR.JgeneAbundance, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)
multi_plots <- BasicPlot(BCR.VJgenePair, contig_list, sample_name) 
cowplot::plot_grid(plotlist=multi_plots)

## -----------------------------------------------------------------------------
sessionInfo()

