create_chart_2 <- function(df) {
  p <- df %>%
    group_by(Release_Year) %>%
    summarize(US_Gross = sum(US_Gross) / 1e6) %>%
    ggplot(aes(x = Release_Year, y = US_Gross)) +
    geom_bar(stat = "identity")

  ggplotly(p)
}
