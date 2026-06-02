#' Load bundled Pokémon TCG dataset
#'
#' @return A tibble containing Pokémon TCG data.
#' @export
load_data <- function() {

  path <- system.file("extdata", "poke.parquet", package = "slowpoke")
  arrow::read_parquet("inst/extdata/poke.parquet")

}
