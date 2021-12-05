
# ----------------------------------------------------------------------------------------------------------------

#' Converting 10X genomics produced T cell contigs file(s) as a list outputed
#'
#' @param datasetDir The single-cell samples' directory containing file filtered_contig_annotations.csv.
#' @param sampleName The sample name of single cell sample.
#' @param groupName The group name of single cell sample.
#'
#' @return List of clonotypes for individual cell barcodes.
#' @export
#' @import tidyr
#' @import dplyr
#' @import tibble
#' @examples
#'
#' project_data_dir <- "F:/R_Language/data/tcr"
#' sample_name <- list.dirs(project_data_dir, full.names = FALSE, recursive = FALSE)
#' group_name <- c("A", "A", "B", "B")
#'
#' TCR.ContigList(project_data_dir, sample_name, group_name)
TCR.ContigList <- function(datasetDir, sampleName, groupName) {
  CreateList <- function(datasetDir, sampleNames, groupNames) {
    # Reading in multiple samples with a for loop
    # Barcode at least has one productive TRA and TRB
    filtered_contigs_tb <- read.delim(file = file.path(datasetDir, sampleNames, "filtered_contig_annotations.csv"), header = TRUE, sep = ",", stringsAsFactors = FALSE) %>%
      subset(chain %in% c("TRA", "TRB") & toupper(high_confidence) == "TRUE" & toupper(productive) == "TRUE" & toupper(full_length) == "TRUE") %>%
      dplyr::arrange(barcode, factor(chain, levels = c("TRA", "TRB")))

    # just keep one TRA-TRB pair
    keep_barcode <- filtered_contigs_tb %>%
      dplyr::select(barcode, chain) %>%
      dplyr::group_by(barcode, chain) %>%
      dplyr::summarise(frequency = n(), .groups = "drop") %>%
      tidyr::spread(chain, frequency, fill = 0) %>%
      subset(TRA != 0) %>%
      subset(TRB != 0) %>%
      dplyr::select(barcode) %>%
      unlist(., use.names = FALSE)
    length(keep_barcode) * 2

    filtered_contigs_sub <- filtered_contigs_tb[filtered_contigs_tb$barcode %in% keep_barcode, ] %>%
      dplyr::distinct(barcode, chain, .keep_all = TRUE)

    # Defined by gene + nt
    clonotypes_tb <- filtered_contigs_sub %>%
      dplyr::group_by(barcode) %>%
      dplyr::summarise(clonotype = paste(v_gene, d_gene, j_gene, c_gene, cdr3, cdr3_nt, sep = "_", collapse = ":")) %>%
      tidyr::separate(clonotype, c("TCRA", "TCRB"), sep = "\\:", remove = F) %>%
      tidyr::separate(TCRA, paste0("TCRA_", c("vgene", "dgene", "jgene", "cgene", "cdr3aa", "cdr3nt")), sep = "_", remove = T) %>%
      tidyr::separate(TCRB, paste0("TCRB_", c("vgene", "dgene", "jgene", "cgene", "cdr3aa", "cdr3nt")), sep = "_", remove = T) %>%
      tibble::add_column(sampleID = sampleNames, groupID = groupNames, .after = "barcode") # sampleID=sample_name,
    return(clonotypes_tb)
  }

  contigList <- purrr::pmap(list(datasetDir, sampleName, groupName), CreateList) %>%
    purrr::set_names(sampleName)
  return(contigList)
}



# ----------------------------------------------------------------------------------------------------------------
