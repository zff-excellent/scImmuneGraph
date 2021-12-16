
# ----------------------------------------------------------------------------------------------------------------

#' V gene abundance distribution in the sample
#'
#' @param contigList The product of BCR.ContigList().
#' @param sampleName The sample name of single cell sample.
#'
#' @return Multiple pictures in the form of a list.
#' @export
#' @import tidyr
#' @import dplyr
#' @import tibble
#' @import gtools
#' @import RColorBrewer
#' @import scales
#' @import ggplot2
#' @examples
#'
#' project_data_dir <- "F:/R_Language/data/bcr"
#' sample_name <- list.dirs(project_data_dir, full.names = FALSE, recursive = FALSE)
#' group_name <- c("A", "A", "B", "B")
#' contig_list <- BCR.ContigList(project_data_dir, sample_name, group_name)
#'
#' BasicPlot(BCR.VgeneAbundance, contig_list, sample_name)
BCR.VgeneAbundance <- function(contigList, sampleName) {
  CreateList <- function(contig_df, sampleNames) {
    # --------------------
    # TRA_TRB_VGene
    TRAB_vgene_Abun <- contig_df %>%
      dplyr::select(barcode, IGK.L_vgene, IGH_vgene) %>%
      unique() %>%
      tidyr::gather(chain, vgene, IGK.L_vgene, IGH_vgene) %>%
      dplyr::add_count(chain, vgene) %>%
      dplyr::rename(frequency = n) %>%
      dplyr::distinct(vgene, frequency, .keep_all = TRUE) %>%
      dplyr::group_by(chain) %>%
      dplyr::top_n(n = 20, wt = frequency) %>%
      dplyr::arrange(frequency, .by_group = TRUE) %>% # dplyr::arrange(chain, n)
      dplyr::mutate(vgene = factor(vgene, levels = rev(unique(vgene))))

    TRAB_vgene_Abun %>%
      ggplot(aes(x = vgene, y = frequency, fill = frequency)) +
      geom_bar(stat = "identity") +
      scale_y_continuous(expand = c(0, 0)) +
      labs(title = sampleNames, x = "IGH-IGK/IGL V Gene", y = "Barcode Frequency") +
      geom_text(aes(label = frequency), size = 4, vjust = 1.2, hjust = 0.5) +
      scale_fill_gradientn(colours = c("#ffffcc", colorRampPalette(c("#aedfb7", "#3799bb", "#3086b5", "#2a74af", "#225fa8"))(800))) +
      theme_bw() +
      theme(
        legend.position = "none",
        axis.line = element_line(),
        text = element_text(size = 12),
        axis.text.x = element_text(size = 8, angle = 90, hjust = 1, vjust = 0),
        plot.title = element_text(hjust = 0.5) # New
      )
  }

  clones_plots <- purrr::pmap(list(contigList, sampleName), CreateList)
  return(clones_plots)
}





# ----------------------------------------------------------------------------------------------------------------
