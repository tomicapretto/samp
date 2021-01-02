.onLoad = function(libname, pkgname) {
  shiny::addResourcePath(
    prefix = "www",
    directoryPath = samp_file("www")
  )
}

.onUnload = function(libname, pkgname) {
  shiny::removeResourcePath("www")
}
