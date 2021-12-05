
# ----------------------------------------------------------------------------------------------------------------

#' Get the 100 most abundant clonotypes
#'
#' @param contigList The product of TCR.ContigList() or BCR.ContigList().
#' @param sampleName The sample name of single cell sample.
#'
#' @return Multiple pictures in the form of a list.
#' @export
#' @import tidyr
#' @import dplyr
#' @import tibble
#' @import RColorBrewer
#' @import scales
#' @import ggplot2
#' @examples
#'
#' project_data_dir <- "F:/R_Language/data/tcr"
#' sample_name <- list.dirs(project_data_dir, full.names = FALSE, recursive = FALSE)
#' group_name <- c("A", "A", "B", "B")
#' contig_list <- TCR.ContigList(project_data_dir, sample_name, group_name)
#'
#' BasicPlot(TCR.top100ClonotypeAbundance, contig_list, sample_name)
TCR.top100ClonotypeAbundance <- function(contigList, sampleName) {
  CreateList <- function(contig_df, sampleNames) {

    # --------------------
    # clonotype abundance
    clones_data <- contig_df %>%
      dplyr::select(barcode, clonotype) %>%
      unique() %>%
      dplyr::group_by(clonotype) %>%
      dplyr::summarize(frequency = n()) %>%
      dplyr::mutate(proportion = 100 * frequency / sum(frequency)) %>%
      dplyr::arrange(-frequency)

    # 1-3 clonotype丰度分布
    n_clones <- 100
    top_clones <- clones_data[1:n_clones, ]
    top_clones$clonotype_num <- factor(rownames(top_clones), levels = mixedsort(rownames(top_clones)))

    # Plot the n most frequent clonotypes
    top_clones %>%
      ggplot(aes(x = clonotype_num, y = frequency, fill = frequency)) +
      geom_bar(stat = "identity") +
      # geom_text(aes(label=frequency), size=3, vjust=-0.5, hjust = 0.5) +
      scale_fill_gradientn(colours = c("#ffffcc", colorRampPalette(c("#aedfb7", "#3799bb", "#3086b5", "#2a74af", "#225fa8"))(800))) +
      scale_y_continuous(expand = c(0, 0)) +
      labs(title = sampleNames, x = "Clonotypes", y = "Barcode Frequency") +
      theme_bw() +
      theme(
        legend.position = "none",
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(),
        text = element_text(size = 12),
        strip.background = element_blank(),
        plot.title = element_text(hjust = 0.5) # New
      )
  }

  clones_plots <- purrr::pmap(list(contigList, sampleName), CreateList)
  return(clones_plots)
}




# ----------------------------------------------------------------------------------------------------------------
