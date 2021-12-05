
# ----------------------------------------------------------------------------------------------------------------

#' VJ gene pair abundance distribution in the sample
#'
#' @param contigList The product of TCR.ContigList().
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
#' project_data_dir <- "F:/R_Language/data/tcr"
#' sample_name <- list.dirs(project_data_dir, full.names = FALSE, recursive = FALSE)
#' group_name <- c("A", "A", "B", "B")
#' contig_list <- TCR.ContigList(project_data_dir, sample_name, group_name)
#'
#' BasicPlot(TCR.VJgenePair, contig_list, sample_name)
TCR.VJgenePair <- function(contigList, sampleName) {
  CreateList <- function(contig_df, sampleNames) {
    # --------------------
    # 3-2: V-J基因对特征分析
    TRA_vjgene_usage <- contig_df %>%
      dplyr::select(barcode, TCRA_vgene, TCRA_jgene) %>%
      dplyr::rename(v_gene = TCRA_vgene, j_gene = TCRA_jgene)

    TRB_vjgene_usage <- contig_df %>%
      dplyr::select(barcode, TCRB_vgene, TCRB_jgene) %>%
      dplyr::rename(v_gene = TCRB_vgene, j_gene = TCRB_jgene)

    TRAB_vjgene_usage <- dplyr::bind_rows(TRA_vjgene_usage, TRB_vjgene_usage) %>%
      dplyr::add_count(v_gene, j_gene) %>%
      dplyr::distinct(v_gene, j_gene, .keep_all = TRUE) %>%
      dplyr::mutate(v_gene = factor(v_gene, levels = mixedsort(unique(v_gene)))) %>%
      dplyr::mutate(j_gene = factor(j_gene, levels = rev(mixedsort(unique(j_gene))))) %>%
      dplyr::mutate(chain = factor(substr(v_gene, 1, 3))) %>%
      dplyr::group_by(chain) %>%
      dplyr::top_n(n = 30, wt = n)

    ggplot(TRAB_vjgene_usage, aes(x = v_gene, y = j_gene, fill = n)) +
      geom_raster(hjust = 0, vjust = 0) +
      theme_bw() +
      scale_y_discrete(position = "right", expand = c(0, 0)) +
      scale_x_discrete(expand = c(0, 0)) +
      theme(
        axis.title.x       = element_blank(),
        axis.title.y       = element_blank(),
        axis.ticks         = element_blank(),
        axis.text.x        = element_text(angle = 90, hjust = 1, vjust = -0.5),
        plot.title         = element_text(hjust = 0.5),
        legend.position    = "right"
      ) +
      labs(title = sampleNames, x = "", y = "") +
      scale_fill_gradientn(
        name = "",
        labels = c("low", "high"),
        breaks = c(min(TRAB_vjgene_usage$n), max(TRAB_vjgene_usage$n)),
        colours = c("#ffffcc", colorRampPalette(c("#aedfb7", "#3799bb", "#3086b5", "#2a74af", "#225fa8"))(800))
      )
  }

  clones_plots <- purrr::pmap(list(contigList, sampleName), CreateList)
  return(clones_plots)
}


# ----------------------------------------------------------------------------------------------------------------
