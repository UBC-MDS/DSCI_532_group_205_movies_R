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

  top_us_gross_df <- df %>%
    arrange(desc(US_Gross)) %>%
    head(10)

  p <- ggplot(top_us_gross_df,aes(x = reorder(Title, US_Gross), y = US_Gross/1e6)) +
     geom_bar(stat = "identity",  show.legend = FALSE, fill="chocolate4") +
     coord_flip() +
     labs(x = "",
           y = "Gross Revenue (millions of USD)", 
           title = "Highest Grossing US Movies") +
     theme_bw()

  ggplotly(p)
}
