samp_file = function(...) {
  system.file(..., package = "samp", mustWork = TRUE)
}

stop2 = function(message, call = NULL, ...) {
  err = structure(
    list(
      message = message,
      call = call,
      ...
    ),
    class = c("samp.error", "error", "condition")
  )
  stop(err)
}

appHandler = function(expr) {
  tryCatch({
    expr
  },
  shiny.silent.error = function(cnd) NULL,
  samp.error = function(cnd) {
    shiny::showNotification(cnd$message, type = "error")
  },
  error = function(cnd) {
    shiny::showNotification("Unexpected error ocurred.", type = "error")
  })
}
