#' Construct a simple darwin core list
#' 
#' @export
#' @param ...,.list Either named params or a named list, not both
#' @return a list of class `darwin_simple`
#' @examples
#' # just dublin core
#' out <- darwin_simple(type = "PhysicalObject", 
#'   modified = "2009-02-12", language = "en")
#' out
#' 
#' # add some darwin core
#' out <- darwin_simple(basisOfRecord = "PreservedSpecimen", 
#'   taxonID = "12345", scientificName = "Poa annua")
#' out
#' 
#' # together
#' out <- darwin_simple(type = "PhysicalObject", 
#'   modified = "2009-02-12", language = "en", 
#'   basisOfRecord = "PreservedSpecimen", taxonID = "12345", 
#'   scientificName = "Poa annua")
#' out
darwin_simple <- function(..., .list = list()) {
  dots <- list(...)
  stopifnot(xor(length(dots) == 0, length(.list) == 0))
  .list <- Filter(function(x) length(x) > 0, list(dots, .list))[[1]]
  for (i in seq_along(.list)) {
    nm <- names(.list)[i]
    if (!nm %in% dc_terms && !nm %in% dwc_terms) {
      stop(sprintf("'%s' not in known set of dc or dwc terms", nm))
    }
  }
  structure(.list, class = "darwin_simple")
}
