
# ----------------------------------------------------------------------------------------------------------------

#' Distribution of clonal status of single-cell TCR clonotypes
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
#'
#' contig_list <- TCR.ContigList(project_data_dir, sample_name, group_name)
#'
#' TCR.ClonalStateDistribution(contig_list, sample_name)
#'
#' BasicPlot(TCR.ClonalStateDistribution, contig_list, sample_name)
#'
TCR.ClonalStateDistribution <- function(contigList, sampleName) {
  CreateList <- function(contig_df, sampleNames) {

    # --------------------
    # clonotype distribution
    clones_data <- contig_df %>%
      dplyr::select(barcode, clonotype) %>%
      unique() %>%
      dplyr::add_count(clonotype) %>%
      dplyr::rename(clonalState = n) %>%
      dplyr::distinct(clonotype, clonalState, .keep_all = TRUE) %>%
      dplyr::add_count(clonalState) %>%
      dplyr::rename(frequency = n) %>%
      dplyr::arrange(-frequency) %>%
      dplyr::distinct(clonalState, frequency, .keep_all = TRUE) %>%
      dplyr::arrange(clonalState) %>%
      dplyr::mutate(clonalState = factor(clonalState))

    friendly_cols <- c("#88CCEE", "#CC6677", "#DDCC77", "#117733", "#332288", "#AA4499", "#44AA99", "#999933", "#882255", "#661100", "#6699CC")
    my_color_palette <- colorRampPalette(friendly_cols)(max(as.numeric(clones_data$clonalState)))
    clones_data %>%
      ggplot(aes(x = clonalState, y = frequency, fill = clonalState)) +
      geom_bar(stat = "identity") + # my_theme
      geom_text(aes(label = frequency), size = 4, vjust = 0, hjust = 0) +
      coord_flip() +
      scale_x_discrete(limits = rev) +
      labs(title = sampleNames, x = "clonalState", y = "Barcode Frequency") +
      scale_fill_manual(values = my_color_palette) +
      theme_bw() +
      theme(
        legend.position = "none",
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
