all_equal_length = function(...) {
  length(unique(vapply(list(...), length, 1L))) == 1
}

pdf_bounds = list(
  "norm" = function(params) {
    width = 3 * params[[2]]
    c(params[[1]] - width, params[[1]] + width)
  },
  "t" = function(params) {
    qt(c(0.005, 0.995), params[[1]], params[[2]])
  },
  "gamma" = function(params) {
    c(0, qgamma(0.995, params[[1]], params[[2]]))
  },
  "exp" = function(params) {
    c(0, qexp(0.995, params[[1]]))
  },
  "beta" = function(params) {
    c(0, 1)
  },
  "lnorm" = function(params) {
    c(0, qlnorm(0.995, params[[1]], params[[2]]))
  },
  "weibull" = function(params) {
    c(0, qweibull(0.995, params[[1]], params[[2]]))
  },
  "unif" = function(params) {
    c(params[[1]], params[[2]])
  }
)

component_rvs = function(distribution, params, size) {
  .f = paste0("r", distribution)
  .args = c(list(size), params)
  do.call(.f, .args)
}

mixture_rvs = function(distributions, params, size, wts = NULL) {
  
  if (is.null(wts)) {
    wts = rep(1 / length(distributions), length(distributions))
  }
  
  stopifnot(length(distributions) == length(params), length(params) == length(wts))
  stopifnot(all.equal(sum(wts), 1, tolerance = 0.011))
  
  .l = list(distributions, params, round(wts * size))
  unlist(purrr::pmap(.l, component_rvs))
}

component_pdf = function(distribution, params, grid) {
  .f = paste0("d", distribution)
  .args = c(list(grid), params)
  do.call(.f, .args)
}

pdf_bounds = function(distribution, params) {
  .f = pdf_bounds[[distribution]]
  .f(params)
}

mixture_grid = function(distributions, params) {
  .l = list(distributions, params)
  out = unlist(purrr::pmap(.l, pdf_bounds))
  seq(min(out), max(out), length.out = 250)
}

mixture_pdf = function(distributions, params, wts = NULL) {
  if (is.null(wts)) {
    wts = rep(1 / length(distributions), length(distributions))
  }
  stopifnot(length(distributions) == length(params), length(params) == length(wts))
  stopifnot(all.equal(sum(wts), 1, tolerance = 0.011))
  
  grid = mixture_grid(distributions, params)
  
  .l = list(distributions, params)
  pdf = unlist(purrr::pmap(.l, component_pdf, grid = grid))
  pdf = as.vector(matrix(pdf, ncol = length(wts)) %*% wts)
  
  # In some edge cases pdf is `Inf`
  pdf[is.infinite(pdf)] = NA 
  
  return(list("x" = grid, "pdf" = pdf))
}