
# ----------------------------------------------------------------------------------------------------------------

#' CDR3 nucleic acid length distribution in the sample
#'
#' @param contigList The product of BCR.ContigList().
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
#' project_data_dir <- "F:/R_Language/data/bcr"
#' sample_name <- list.dirs(project_data_dir, full.names = FALSE, recursive = FALSE)
#' group_name <- c("A", "A", "B", "B")
#' contig_list <- BCR.ContigList(project_data_dir, sample_name, group_name)
#'
#' BasicPlot(BCR.CDR3ntLengthDistribution, contig_list, sample_name)
BCR.CDR3ntLengthDistribution <- function(contigList, sampleName) {
  CreateList <- function(contig_df, sampleNames) {

    # --------------------
    # CDR3nt Length Distribution
    TRA_Cdr3_Length <- contig_df %>%
      dplyr::select(barcode, IGK.L_cdr3nt, IGH_cdr3nt) %>%
      dplyr::rename(IGK.L = IGK.L_cdr3nt, IGH = IGH_cdr3nt) %>%
      unique() %>%
      tidyr::gather(chain, cdr3_nt, IGK.L, IGH) %>%
      dplyr::mutate(cdr3_len = nchar(cdr3_nt)) %>%
      dplyr::add_count(chain, cdr3_len) %>%
      dplyr::rename(frequency = n) %>%
      dplyr::distinct(cdr3_len, frequency, .keep_all = TRUE) %>%
      dplyr::arrange(cdr3_len) %>%
      dplyr::mutate(cdr3_len = factor(cdr3_len), chain = factor(chain, levels = c("IGK.L", "IGH")))

    TRA_Cdr3_Length %>%
      ggplot(aes(x = cdr3_len, y = frequency, fill = chain)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_text(aes(label = frequency), size = 4, vjust = -0.5, hjust = 0.5, position = position_dodge(0.9)) +
      labs(title = sampleNames, x = "CDR3nt Length", y = "Barcode Frequency") +
      scale_fill_manual(values = c("#88CCEE", "#CC6677")) +
      theme_bw() +
      theme(
        axis.line = element_line(),
        text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5) # New
      )
  }

  clones_plots <- purrr::pmap(list(contigList, sampleName), CreateList)
  return(clones_plots)
}




# ----------------------------------------------------------------------------------------------------------------
