
# ----------------------------------------------------------------------------------------------------------------

#' The composition of single-cell TCR clonotypes in the sample
#'
#' @param contigList The product of TCR.ContigList().
#' @param sampleName The sample name of single cell sample.
#'
#' @return Multiple pictures in the form of a list.
#' @export
#' @import tidyr
#' @import dplyr
#' @import tibble
#' @import forcats
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
#' BasicPlot(TCR.ClonotypeComposition, contig_list, sample_name)
TCR.ClonotypeComposition <- function(contigList, sampleName) {
  CreateList <- function(contig_df, sampleNames) {

    # --------------------
    # clonotype diversity
    ## Distinguish top1-10 and other clonotypes
    dive_clones <- contig_df %>%
      dplyr::select(barcode, clonotype) %>%
      dplyr::mutate(clonotype_id = forcats::fct_lump_n(clonotype, n = 10)) %>%
      dplyr::add_count(clonotype_id) %>%
      dplyr::rename(frequency = n) %>%
      dplyr::arrange(-frequency) %>%
      dplyr::distinct(clonotype_id, frequency, .keep_all = TRUE) %>%
      dplyr::mutate(clonotype_id = factor(c("Other", paste0("clonotype", 1:(n() - 1))), levels = c("Other", paste0("clonotype", rev(1:(n() - 1))))))


    my_color_palette <- colorRampPalette(c("#2b8cbe", "#e0f3db", "#fdbb84"))(max(as.numeric(dive_clones$clonotype_id)))
    p <- ggplot(dive_clones, aes(x = "", y = frequency, fill = clonotype_id)) +
      geom_bar(stat = "identity") +
      ggtitle(sampleNames) +
      guides(fill = guide_legend(reverse = TRUE)) +
      scale_fill_manual(values = c("grey75", my_color_palette)) +
      theme_void() +
      coord_polar("y")
    data <- ggplot_build(p)
    other_pc <- round(100 * dive_clones$frequency[1] / sum(dive_clones$frequency), 2)
    y_position <- max(data[[1]][[1]][1, c("ymin", "ymax")] %>% unname() %>% unlist()) - 200
    p + annotate("text", label = paste0(other_pc, " %"), x = 1, y = y_position)
  }

  clones_plots <- purrr::pmap(list(contigList, sampleName), CreateList)
  return(clones_plots)
}




# ----------------------------------------------------------------------------------------------------------------
