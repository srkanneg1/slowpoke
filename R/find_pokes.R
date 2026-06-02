#' Find Pokémon by name pattern
#'
#' @param poke_name A character string to match against Pokémon names.
#' @return A tibble of matching Pokémon card names and their flavor text.
#' @importFrom stringi stri_trans_totitle
#' @importFrom arrow read_parquet
#' @export
.pkg_env <- new.env(parent = emptyenv())

find_poke <- function(poke_name) {
  if (is.null(.pkg_env$dat)) {
    path <- system.file("extdata", "poke.parquet", package = "slowpoke")
    .pkg_env$dat <- arrow::read_parquet(path)
  }

  pattern <- stringi::stri_trans_totitle(poke_name)
  matches <- grepl(pattern, .pkg_env$dat$name)

  unique(.pkg_env$dat[matches, c("name", "flavorText")])
}

#' Find multiple Pokémon by name patterns
#'
#' @param poke_names A character vector of name patterns.
#' @return A tibble of matching Pokémon card names and flavor text.
#' @importFrom dplyr tibble
#' @export
find_many_pokes <- function(poke_names) {

  result <- dplyr::tibble()

  for (poke_name in poke_names) {

    temp <- find_poke(poke_name)

    result <- rbind(result, temp)

  }

  return(result)

}
