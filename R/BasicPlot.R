
# ----------------------------------------------------------------------------------------------------------------
#' Draw a variety of diagrams
#'
#' @param plot_fun Drawing function.
#' @param contigList List which produced by TCR.ContigList() or BCR.ContigList().
#' @param sampleName The sample name of single cell sample.
#'
#' @return Multiple pictures in the form of a list.
#' @export
#' @import RColorBrewer
#' @import scales
#' @import ggplot2
#' @examples
#' project_data_dir <- "F:/R_Language/data/tcr"
#' sample_name <- list.dirs(project_data_dir, full.names = FALSE, recursive = FALSE)
#' group_name <- c("A", "A", "B", "B")
#'
#' contig_list <- TCR.ContigList(project_data_dir, sample_name, group_name)
#' BasicPlot(TCR.ClonalStateDistribution, contig_list, sample_name)
BasicPlot <- function(plot_fun, contigList, sampleName) {
  plot_fun(contigList, sampleName)
}
# ----------------------------------------------------------------------------------------------------------------
