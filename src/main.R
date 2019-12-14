# Load assets
app <- Dash$new(assets_folder = "assets")

movies_df = read_csv("data/movies.csv",
                     col_types = cols(MPAA_Rating = col_factor(),
                                      Major_Genre = col_factor(),
                                      Release_Year = col_integer())) %>%
  mutate(Rotten_Tomatoes_Rating = as.integer(Rotten_Tomatoes_Rating),
         US_Gross_per_million = round(US_Gross / 1e6, 2))

#
# Set up options for filter controls
#

make_checklist_options <- function(values, labels = NULL) {
  if (is_null(labels))
    labels <- values

  map2(labels, values, ~ (list(label = .x, value = .y)))
}

genre_options <- movies_df %>%
  select("Major_Genre") %>%
  na.omit() %>%
  unique() %>%
  pull("Major_Genre") %>%
  sort() %>%
  make_checklist_options()

ratings_options <- make_checklist_options(c("G", "PG", "PG-13", "R", "NC-17"),
                                          c("G: General Audience",
                                            "PG: Parental Guidance",
                                            "PG-13: Parents Strongly Cautioned",
                                            "R: Restricted",
                                            "NC-17: Adults Only"))

year_options <- movies_df %>%
  select("Release_Year") %>%
  na.omit() %>%
  unique() %>%
  pull("Release_Year") %>%
  sort() %>%
  make_checklist_options()

#
# Default values for filters
#
default_genres = c("Action", "Adventure", "Comedy", "Drama", "Horror", "Romantic Comedy", "Thriller/Suspense")
default_ratings = c("PG", "PG-13", "R")
default_from = 2000
default_to = 2011

filter_data <- function(genres, ratings, year_range) {
  movies_df %>%
    filter(Major_Genre %in% genres,
           MPAA_Rating %in% ratings,
           Release_Year >= year_range[1],
           Release_Year <= year_range[2])
}

app$layout(
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
          htmlP(paste("Select a range for the release year of the movies using the Release Year range slider below.",
                      "Then, adjust the Genres and the MPAA Ratings that you are interested in.")),
          htmlP(paste("The upper chart will then show you the top 10 movies based on your selection criteria.",
                      "The lower chart will show you how their IMDB and Rotten Tomatoes scores compare to all movies in the database."))
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
    ), className = "app-main--container")
  ), className = "wrapper")
)

app$callback(
  output=list(id = "upper-graph", property="figure"),

  params=list(input(id = "cb-genres", property = "value"),
              input(id = "cb-ratings", property = "value"),
              input(id = "release-year-range", property = "value")),

  function(genres, ratings, year_range) {
    df <- filter_data(genres, ratings, year_range)
    create_chart_1(df)
  })

app$callback(
  output=list(id = "lower-graph", property="figure"),

  params=list(input(id = "cb-genres", property = "value"),
              input(id = "cb-ratings", property = "value"),
              input(id = "release-year-range", property = "value")),

  function(genres, ratings, year_range) {
    df <- filter_data(genres, ratings, year_range)
    create_chart_2(df)
  })
