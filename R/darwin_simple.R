#' Construct simple darwin core
#' 
#' @export
#' @param ...,.list Either named params or a named list, not both
#' @return an `xml_document` 
#' @examples
#' library(xml2)
#' # just dublin core
#' out <- darwin_simple(type = "PhysicalObject", modified = "2009-02-12T14:22:00Z", language = "en")
#' out
#' xml_structure(out)
#' write_xml(out, (f <- tempfile(fileext=".xml")))
#' 
#' # add some darwin core
#' out <- darwin_simple(basisOfRecord = "PreservedSpecimen", taxonID = "12345", scientificName = "Poa annua")
#' out
#' xml_structure(out)
#' write_xml(out, (f <- tempfile(fileext=".xml")))
#' 
#' # together
#' out <- darwin_simple(type = "PhysicalObject", 
#'   modified = "2009-02-12", language = "en", 
#'   basisOfRecord = "PreservedSpecimen", taxonID = "12345", 
#'   scientificName = "Poa annua")
#' out
#' xml_structure(out)
#' write_xml(out, (f <- tempfile(fileext=".xml")))
darwin_simple <- function(..., .list = list()) {
  dots <- list(...)
  stopifnot(xor(length(dots) == 0, length(.list) == 0))
  .list <- Filter(function(x) length(x) > 0, list(dots, .list))[[1]]
  x <- simple_prep()
  xml_add_child(x, "SimpleDarwinRecord")
  sdr <- xml_find_first(x, "SimpleDarwinRecord")
  for (i in seq_along(.list)) {
    nm <- names(.list)[i]
    xml_add_child(sdr, paste0(toggle_ns(nm), nm), .list[[i]])
  }
  return(x)
}

dc_terms <- c("type", "modified", "language", "license", "rightsHolder", 
  "accessRights", "bibliographicCitation", "references")
dwc_terms <- c("institutionID", "collectionID", "datasetID", "institutionCode", "collectionCode", "datasetName", "ownerInstitutionCode", "basisOfRecord", "informationWithheld", "dataGeneralizations", "dynamicProperties", "occurrenceID", "catalogNumber", "recordNumber", "recordedBy", "individualCount", "sex", "lifeStage", "reproductiveCondition", "behavior", "establishmentMeans", "occurrenceStatus", "preparations", "disposition", "associatedMedia", "associatedReferences", "associatedSequences", "associatedTaxa", "otherCatalogNumbers", "occurrenceRemarks", "organismID", "organismName", "organismScope", "associatedOccurrences", "associatedOrganisms", "previousIdentifications", "organismRemarks", "eventID", "fieldNumber", "eventDate", "eventTime", "startDayOfYear", "endDayOfYear", "year", "month", "day", "verbatimEventDate", "habitat", "samplingProtocol", "samplingEffort", "fieldNotes", "eventRemarks", "locationID", "higherGeographyID", "higherGeography", "continent", "waterbody", "islandGroup", "island", "country", "countryCode", "stateProvince", "county", "municipality", "locality", "verbatimLocality", "minimumElevationInMeters", "maximumElevationInMeters", "verbatimElevation", "minimumDepthInMeters", "maximumDepthInMeters", "verbatimDepth", "minimumDistanceAboveSurfaceInMeters", "maximumDistanceAboveSurfaceInMeters", "locationAccordingTo", "locationRemarks", "decimalLatitude", "decimalLongitude", "geodeticDatum", "coordinateUncertaintyInMeters", "coordinatePrecision", "pointRadiusSpatialFit", "verbatimCoordinates", "verbatimLatitude", "verbatimLongitude", "verbatimCoordinateSystem", "verbatimSRS", "footprintWKT", "footprintSRS", "footprintSpatialFit", "georeferencedBy", "georeferencedDate", "georeferenceProtocol", "georeferenceSources", "georeferenceVerificationStatus", "georeferenceRemarks", "geologicalContextID", "earliestEonOrLowestEonothem", "latestEonOrHighestEonothem", "earliestEraOrLowestErathem", "latestEraOrHighestErathem", "earliestPeriodOrLowestSystem", "latestPeriodOrHighestSystem", "earliestEpochOrLowestSeries", "latestEpochOrHighestSeries", "earliestAgeOrLowestStage", "latestAgeOrHighestStage", "lowestBiostratigraphicZone", "highestBiostratigraphicZone", "lithostratigraphicTerms", "group", "formation", "bed", "identificationID", "identificationQualifier", "typeStatus", "identifiedBy", "dateIdentified", "identificationReferences", "identificationVerificationStatus", "identificationRemarks", "taxonID", "scientificNameID", "acceptedNameUsageID", "parentNameUsageID", "originalNameUsageID", "nameAccordingToID", "namePublishedInID", "taxonConceptID", "scientificName", "acceptedNameUsage", "parentNameUsage", "originalNameUsage", "nameAccordingTo", "namePublishedIn", "namePublishedInYear", "higherClassification", "kingdom", "phylum", "class", "order", "family", "genus", "subgenus", "specificEpithet", "infraspecificEpithet", "taxonRank", "verbatimTaxonRank", "scientificNameAuthorship", "vernacularName", "nomenclaturalCode", "taxonomicStatus", "nomenclaturalStatus", "taxonRemarks")

toggle_ns <- function(x) {
  if (x %in% dc_terms) return("dc:")
  if (x %in% dwc_terms) return("dwc:")
  stop("term not found in 'dc' or 'dwc' namespaces")
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
