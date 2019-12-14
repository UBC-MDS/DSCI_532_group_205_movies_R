create_chart_2 <- function(df, y, movies_df) {
  top_us_gross_df <- df %>%
    arrange(desc(US_Gross)) %>%
    head(10)

  selected_movie <- top_us_gross_df[y, ]

  p <- ggplot() +
    geom_point(aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating), top_us_gross_df, size = 2) +
    geom_point(aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating), selected_movie, size = 4, colour = "#396362")

  ggplotly(p)
}
