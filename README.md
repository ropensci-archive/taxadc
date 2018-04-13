taxadc
====



[![Build Status](https://travis-ci.org/ropenscilabs/taxadc.svg?branch=master)](https://travis-ci.org/ropenscilabs/taxadc)
[![codecov](https://codecov.io/gh/ropenscilabs/taxadc/branch/master/graph/badge.svg)](https://codecov.io/gh/ropenscilabs/taxadc)
[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/taxadc)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/taxadc)](https://cran.r-project.org/package=taxadc)

## installation


```r
remotes::install_github("ropenscilabs/taxadc")
```


```r
library("taxadc")
library("xml2")
```

## simple darwin core


```r
out <- darwin_simple(type = "PhysicalObject", 
  modified = "2009-02-12", language = "en", 
  basisOfRecord = "PreservedSpecimen", taxonID = "12345", 
  scientificName = "Poa annua")
xml_structure(out)
#> <SimpleDarwinRecordSet [schemaLocation, xmlns, xmlns:dc, xmlns:dwc, xmlns:xsi]>
#>   <SimpleDarwinRecord>
#>     <type>
#>       {text}
#>     <modified>
#>       {text}
#>     <language>
#>       {text}
#>     <basisOfRecord>
#>       {text}
#>     <taxonID>
#>       {text}
#>     <scientificName>
#>       {text}
```


```r
write_xml(out, (f <- tempfile(fileext=".xml")))
readLines(f, n = 2)
#> [1] "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"                                                                                                                                                                                                                                                                                 
#> [2] "<SimpleDarwinRecordSet xmlns=\"http://rs.tdwg.org/dwc/xsd/simpledarwincore/\" xmlns:dc=\"http://purl.org/dc/terms/\" xmlns:dwc=\"http://rs.tdwg.org/dwc/terms/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://rs.tdwg.org/dwc/xsd/simpledarwincore/ ../../xsd/tdwg_dwc_simple.xsd\">"
```

## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/taxadc/issues).
* License: MIT
* Get citation information for `taxadc` in R doing `citation(package = 'taxadc')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
