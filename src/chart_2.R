#' Chart 2 - Lower movie ratings scatterplot
#'
#' @param df Filtered dataframe of movies based on user criteria
#' @param y The movie that was selected by the user
#' @param movies_df The unfiltered dataframe
#'
#' @return Plotly chart
#'
create_chart_2 <- function(df, y, movies_df) {
  top_us_gross_df <- df %>%
    arrange(desc(US_Gross)) %>%
    head(10)

  selected_movie <- top_us_gross_df[y, ]

  p1 <- ggplot() +
    geom_hex(data = movies_df, aes(x = IMDB_Rating,
                              y = Rotten_Tomatoes_Rating),
              alpha = 0.5,
              bins = 20) +
    scale_fill_distiller(palette ="Purples", direction = -1) +
    geom_point(aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating), top_us_gross_df, size = 4, colour = "#396362") +
    geom_point(aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating), selected_movie, size = 6, colour = "red") +
    theme_minimal() +
    labs(x = "IMDB Rating",
         y = "Rotten Tomatoes Rating") +
    ggtitle("Movie Ratings")


  ggplotly(p1)
}

