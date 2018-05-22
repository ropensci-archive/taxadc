#' get tax strings
#' 
#' @export
#' @importFrom tibble as_tibble
#' @param x input, a Taxonomy object for now only
#' @examples
#' library(taxa)
#' ex_taxonomy
#' tdc_tax_strings(x = ex_taxonomy)
tdc_tax_strings <- function(x) {
  UseMethod('tdc_tax_strings')
}

#' @export
tdc_tax_strings.default <- function(x) {
  stop("no tdc_tax_strings method for ", class(x)[[1L]])
}

#' @export
tdc_tax_strings.Taxonomy <- function(x) {
  ids <- unname(vapply(x$taxa, function(x) x$get_id(), numeric(1)))
  rankz <- unname(x$taxon_ranks())
  nms <- unname(x$taxon_names())
  if (!length(unique(length(ids), length(nms), length(rankz))) == 1)
    stop('ids, names, ranks not of same length')
  tibble::as_data_frame(list(
    taxonID = paste0(ids, collapse = "|"),
    scientificName = paste0(nms, collapse = "|"),
    taxonRank = paste0(rankz, collapse = "|")
  ))
}
