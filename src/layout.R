#
# Default values for filters
#
default_genres = c("Action", "Adventure", "Comedy", "Drama", "Horror", "Romantic Comedy", "Thriller/Suspense")
default_ratings = c("PG", "PG-13", "R")
default_from = 2000
default_to = 2011

#' The DashR layout for the app
#'
#' @return DashR layout
#'
get_layout <- function() {
  htmlDiv(list(
    # App Banner
    htmlDiv(list(
      htmlH1("Seek-a-Movie", className = "display-3"),
      htmlP("Interactive Movie Selector", className = "lead"),
      htmlP("Displays the top 10 highest grossing US movies based on your taste.",
            className = "lead"),
      htmlP("Compare the IMDB and Rotten Tomatoes ratings to help you decide what to watch!",
            className = "lead")
    ), className = "app-main--first-title row"),

    # Main Container
    htmlDiv(list(
      htmlDiv(list(
        htmlDiv(list(
          htmlUl(list(
            htmlLi(htmlP("Select a range for the release year of the movies using the Release Year range slider below.")),
            htmlLi(htmlP("Adjust the Genres and the MPAA Ratings that you are interested in.")),
            htmlLi(htmlP("The upper chart will show you the top 10 movies based on your selection criteria.")),
            htmlLi(htmlP("The lower chart will show you how their IMDB and Rotten Tomatoes scores compare to all movies in the database.")),
            htmlLi(htmlP("Select a movie from the barchart to help you find it in the Movie Ratings scatter plot.", className = "italic"))
          ))
        ), className = "app-main--instructions"),
        htmlDiv(list(
          htmlP("Release Year"),
          htmlDiv(list(
            dccRangeSlider(
              id="release-year-range",
              min = 1915,
              max = 2011,
              step = 1,
              marks = seq(1915, 2011, 5) %>% as.list() %>% set_names(seq(1915, 2011, 5)),
              value = c(2000, 2011)
            )
          ), className = "app-main--panel-bottom-inset")
        ), className = "app-main--panel-bottom-inset")
      ), className = "app-main--upper-controls"),
      htmlDiv(list(
        # Left Panel
        htmlDiv(list(
          htmlDiv(list(
            htmlP("Genres", className="app-main--container-title"),
            dccChecklist(id="cb-genres",
                         className="app-main--genre-cb-container",
                         inputClassName="app-main--cb-input",
                         labelClassName="app-main--cb-label",
                         options = genre_options,
                         value = default_genres)
          ), className = "app-main--genre-container app-main--filter-panel"),
          htmlDiv(list(
            htmlP("MPAA Ratings", className="app-main--container-title"),
            dccChecklist(
              id="cb-ratings",
              className="app-main--rating-cb-container",
              inputClassName="app-main--cb-input",
              labelClassName="app-main--cb-label",
              options = ratings_options,
              value = default_ratings
            )
          ), className = "app-main--rating-container app-main--filter-panel")
        ), className = "app-main--panel-left"),
        # Right Panel
        htmlDiv(list(
          htmlDiv(list(
            dccGraph(id = 'upper-graph')
          ), className = "app-main--panel-right-upper"),
          htmlDiv(list(
            dccGraph(id = 'lower-graph')
          ), className = "app-main--panel-right-lower")
        ), className = "app-main--panel-right")
      ), className = "app-main--lower-content")
    ), className = "app-main--container"),
    htmlA(htmlP("The data for this app comes from the Vega datasets project at github.com/vega/vega-datasets"),
          href = "https://github.com/vega/vega-datasets")
  ), className = "wrapper")
}
