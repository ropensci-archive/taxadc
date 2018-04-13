#' Construct simple darwin core
#' 
#' @export
#' @param x an object of class `darwin_simple`, the output from 
#' the function [darwin_simple()]
#' @return an `xml_document` 
#' @examples
#' library(xml2)
#' # just dublin core
#' out <- darwin_simple(type = "PhysicalObject", 
#'   modified = "2009-02-12", language = "en")
#' out
#' xml <- darwin_as_xml(out)
#' xml_structure(xml)
#' write_xml(xml, (f <- tempfile(fileext=".xml")))
#' 
#' # add some darwin core
#' out <- darwin_simple(basisOfRecord = "PreservedSpecimen", 
#'   taxonID = "12345", scientificName = "Poa annua")
#' out
#' xml <- darwin_as_xml(out)
#' xml_structure(xml)
#' write_xml(xml, (f <- tempfile(fileext=".xml")))
#' 
#' # together
#' out <- darwin_simple(type = "PhysicalObject", 
#'   modified = "2009-02-12", language = "en", 
#'   basisOfRecord = "PreservedSpecimen", taxonID = "12345", 
#'   scientificName = "Poa annua")
#' out
#' xml <- darwin_as_xml(out)
#' xml_structure(xml)
#' write_xml(xml, (f <- tempfile(fileext=".xml")))
darwin_as_xml <- function(x) {
  stopifnot(inherits(x, "darwin_simple"))
  xml <- simple_prep()
  xml_add_child(xml, "SimpleDarwinRecord")
  sdr <- xml_find_first(xml, "SimpleDarwinRecord")
  for (i in seq_along(x)) {
    nm <- names(x)[i]
    xml_add_child(sdr, paste0(toggle_ns(nm), nm), x[[i]])
  }
  return(xml)
}

# dublin_core <- function(..., .list = list()) {
#   dots <- list(...)
#   stopifnot(xor(length(dots) == 0, length(.list) == 0))
#   .list <- Filter(function(x) length(x) > 0, list(dots, .list))[[1]]
#   x <- simple_prep()
#   xml_add_child(x, "SimpleDarwinRecord")
#   sdr <- xml_find_first(x, "SimpleDarwinRecord")
#   for (i in seq_along(.list)) {
#     nm <- names(.list)[i]
#     xml_add_child(sdr, paste0("dc:", nm), .list[[i]])
#   }
#   return(x)
# }

simple_prep <- function() {
  x <- read_xml("<SimpleDarwinRecordSet></SimpleDarwinRecordSet>")
  xml_attr(x, "xmlns") <- "http://rs.tdwg.org/dwc/xsd/simpledarwincore/"
  xml_attr(x, "xmlns:dc") <- "http://purl.org/dc/terms/"
  xml_attr(x, "xmlns:dwc") <- "http://rs.tdwg.org/dwc/terms/"
  xml_attr(x, "xmlns:xsi") <- "http://www.w3.org/2001/XMLSchema-instance"
  xml_attr(x, "xsi:schemaLocation") <- "http://rs.tdwg.org/dwc/xsd/simpledarwincore/ ../../xsd/tdwg_dwc_simple.xsd"
  return(x)
}

# (f <- tempfile(fileext = ".xml"))
# write_xml(x, f)
# cat(readLines(f), "\n")
