create_chart_1 <- function(df) {
  # df <- movies_df %>%
  #   group_by(Release_Year) %>%
  #   summarize(US_Gross = sum(US_Gross) / 1e6)
  #
  # sd <- highlight_key(df, ~Release_Year, "Select a year")
  #
  # p <- sd %>%
  #   ggplot(aes(x = Release_Year, y = US_Gross, group = Release_Year)) +
  #   geom_bar(stat = "identity")
  #
  # ggplotly(p, tooltip = "Release_Year") %>%
  #   layout(title = "Click on a line to highlight a year") %>%
  #   highlight(dynamic = TRUE, selectize = TRUE)

  p <- df %>%
    group_by(Release_Year) %>%
    summarize(US_Gross = sum(US_Gross) / 1e6) %>%
    ggplot(aes(x = Release_Year, y = US_Gross)) +
    geom_bar(stat = "identity")

  ggplotly(p)
}
