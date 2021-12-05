
# ----------------------------------------------------------------------------------------------------------------

#' #' Get the 100 most abundant CDR3
#'
#' @param contigList The product of TCR.ContigList().
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
#' BasicPlot(TCR.top100CDR3Abundance, contig_list, sample_name)
TCR.top100CDR3Abundance <- function(contigList, sampleName) {
  CreateList <- function(contig_df, sampleNames) {

    # --------------------
    # clonotype diversity
    ## Distinguish top1-10 and others clonotypes
    # step3: CDR3 abundance distribution
    n_clones <- 100
    TRAB_Cdr3_Abun <- contig_df %>%
      dplyr::select(barcode, TCRA_cdr3nt, TCRB_cdr3nt) %>%
      dplyr::rename(TCRA = TCRA_cdr3nt, TCRB = TCRB_cdr3nt) %>%
      unique() %>%
      tidyr::gather(chain, cdr3_nt, TCRA, TCRB) %>%
      dplyr::group_by(chain, cdr3_nt) %>%
      dplyr::summarise(frequency = n(), .groups = "drop") %>%
      dplyr::group_by(chain) %>%
      dplyr::arrange(-frequency) %>%
      slice(1:n_clones) %>%
      dplyr::mutate(cdr3_num = as.factor(1:n()))

    TRAB_Cdr3_Abun %>%
      ggplot(aes(x = cdr3_num, y = frequency, fill = frequency)) +
      geom_bar(stat = "identity") +
      scale_fill_gradientn(colours = c("#ffffcc", colorRampPalette(c("#aedfb7", "#3799bb", "#3086b5", "#2a74af", "#225fa8"))(800))) +
      scale_y_continuous(expand = c(0, 0)) +
      labs(title = sampleNames, x = "TRAB CDR3s", y = "Barcode Frequency") +
      facet_grid(chain ~ .) +
      theme_bw() +
      theme(
        legend.position = "none",
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5) # New
      )
  }

  clones_plots <- purrr::pmap(list(contigList, sampleName), CreateList)
  return(clones_plots)
}



# ----------------------------------------------------------------------------------------------------------------
