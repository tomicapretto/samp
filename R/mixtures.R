# class = FALSE to disable S3 dispatch
# cloneable = FALSE to save some memory


# 'param_list' is going to be the "input" of our Shiny app
# but it could be any list-like object that can be subsetable by
# object[["name"]]

Mixture = R6::R6Class(
  "Mixture",
  class = FALSE,
  cloneable = FALSE,
  public = list(
    components = list(),
    initialize = function() {},

    add = function(dist) {
      id = as.character(self$new_id())
      self$components[[id]] = list(id = id, dist = dist)
      return(id)
    },
    remove = function(id) {
      self$components[[id]] = NULL
    },

    new_id = function() {
      ids = as.numeric(names(self$components))
      ids_seq = seq(length(self$components))
      if (length(setdiff(ids_seq, ids)) > 0) {
        id = setdiff(ids_seq, ids)[1]
      } else {
        id = length(self$components) + 1
      }
      return(id)
    },

    count = function() {
      length(self$components)
    },

    get_params = function(param_list) {
     lapply(self$components, function(x) {
        param_names = paste0("dist_", x$id, "_param_", 1:2)
        lapply(param_names, function(x) param_list[[x]])
      })
    },

    get_dists = function() {
      vapply(self$components, function(x) x$dist, character(1))
    },

    get_weights = function(param_list) {
      wts = vapply(
        self$components,
        function(x) param_list[[paste0("weight_", x$id)]],
        numeric(1)
      )
      if (sum(wts) >= 0.99 && sum(wts) <= 1.01) {
        return(wts)
      } else {
        stop2("Weights must add up to 1.")
      }
    },

    mixture_rvs = function(param_list, wts, size, reps) {
      .l = list(self$get_dists(), self$get_params(param_list), round(wts * size))
      .f = function(x) {
        unlist(purrr::pmap(.l, self$component_rvs), use.names = FALSE)
      }
      replicate(reps, .f(), simplify = FALSE)
    },

    component_rvs = function(distribution, params, size) {
      .f = paste0("r", distribution)
      .args = c(list(size), params)
      do.call(.f, .args)
    },

    mixture_pdf = function(param_list, wts) {
      dists = self$get_dists()
      params = self$get_params(param_list)

      grid = self$mixture_grid(dists, params)

      .l = list(dists, params)
      pdf = unlist(purrr::pmap(.l, self$component_pdf, grid = grid))
      pdf = as.vector(matrix(pdf, ncol = length(wts)) %*% wts)

      # In some edge cases pdf is `Inf`
      pdf[is.infinite(pdf)] = NA

      return(list("x" = grid, "pdf" = pdf))
    },

    component_pdf = function(distribution, params, grid) {
      .f = paste0("d", distribution)
      .args = c(list(grid), params)
      do.call(.f, .args)
    },

    mixture_grid = function(distributions, params) {
      .l = list(distributions, params)
      out = unlist(purrr::pmap(.l, self$pdf_bounds))
      seq(min(out), max(out), length.out = 250)
    },

    pdf_bounds = function(distribution, params) {
      .f = pdf_bounds_list[[distribution]]
      .f(params)
    },

    get_inputs = function() {
      unlist(lapply(self$components, function(x) {
        c(paste0("weight_", x$id), paste0("dist_", x$id, c("_param_1", "_param_2")))
      }), use.names = FALSE)
    }
  )
)

pdf_bounds_list = list(
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
