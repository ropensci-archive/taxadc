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
