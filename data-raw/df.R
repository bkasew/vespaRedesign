## code to prepare `df` dataset goes here

df <- tibble::tibble(
  Variance = c(rep(c("Variance A", "Variance B", "Variance C"), 3), rep("NONE", 18)),
  SFC = c(rep("NONE", 9), rep(c("SFC A", "SFC B", "SFC C"), 3), rep("NONE", 9)),
  Segment = c(rep("NONE", 18), rep(c("Segment A", "Segment B", "Segment C"), 3)),
  Lender = rep(c(rep("Lender A", 3), rep("Lender B", 3), rep("Lender C", 3)), 3)
)

usethis::use_data(df, overwrite = TRUE)
