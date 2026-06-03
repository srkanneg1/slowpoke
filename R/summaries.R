#' Count card rarity by grouping variable
#'
#' @param grouping_var A column to group by (unquoted).
#' @return A tibble with counts of each rarity by group.
#' @importFrom dplyr group_by mutate summarise n
#' @importFrom tidyr pivot_wider
#' @export
rarity_by_release <- function(grouping_var) {

  dat <- load_data()

  dat |>
    group_by({{grouping_var}}, rarity) |>
    summarise(n = n(), .groups = "drop_last") |>
    mutate(pct = n / sum(n)) |>
    pivot_wider(
      names_from = rarity,
      values_from = pct,
      values_fill = 0
    )
}
