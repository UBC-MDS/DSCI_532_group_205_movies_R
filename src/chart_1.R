create_chart_1 <- function(df, y = NULL) {
  top_us_gross_df <- df %>%
    arrange(desc(US_Gross)) %>%
    head(10)

  p <- top_us_gross_df %>%
    ggplot(aes(x = reorder(Title, US_Gross),
               y = US_Gross_per_million,
               text = paste0("Year: ", Release_Year,
                             "<br />Title: ", Title,
                             "<br />MPAA Rating: ", MPAA_Rating,
                             "<br />US Gross (per million): ", US_Gross_per_million))) +
    geom_bar(stat = "identity",  show.legend = FALSE, fill = "#396362") +
    coord_flip() +
    labs(x = "",
         y = "Gross Revenue (million USD)",
         title = "Highest Grossing US Movies") +
    theme_bw()

  ggplotly(p, tooltip = c("text")) %>%
    layout(clickmode = 'event+select')
}
