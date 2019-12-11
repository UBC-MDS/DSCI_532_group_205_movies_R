library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)

# Load assets
app <- Dash$new(assets_folder = "assets")

# Prepare data
movies_df <- read_csv("data/movies.csv",
                      col_types = cols(MPAA_Rating = col_factor(),
                                       Major_Genre = col_factor(),
                                       Release_Year = col_integer())) %>%
  mutate(Rotten_Tomatoes_Rating = as.integer(Rotten_Tomatoes_Rating))

#
# Set up options for filter controls
#

make_checklist_options <- function(values) {
  values %>%
    map(~ (list(label = ., value = .)))
}

genre_options <- movies_df %>%
  select("Major_Genre") %>%
  na.omit() %>%
  unique() %>%
  pull("Major_Genre") %>%
  sort() %>%
  make_checklist_options()

ratings_options <- c("G", "PG", "PG-13", "R", "NC-17") %>%
  make_checklist_options()

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

filter_data <- function(genres, ratings, year_from, year_to) {
  movies_df %>%
    filter(Major_Genre %in% genres,
           MPAA_Rating %in% ratings,
           Release_Year >= year_from,
           Release_Year <= year_to)
}

create_upper_chart <- function(df) {
  p <- df %>%
    group_by(Release_Year) %>%
    summarize(US_Gross = sum(US_Gross) / 1e6) %>%
    ggplot(aes(x = Release_Year, y = US_Gross)) +
    geom_bar(stat = "identity")

  ggplotly(p)
}

create_lower_chart <- function(df) {
  p <- df %>%
    group_by(Release_Year) %>%
    summarize(US_Gross = sum(US_Gross) / 1e6) %>%
    ggplot(aes(x = Release_Year, y = US_Gross)) +
    geom_bar(stat = "identity")

  ggplotly(p)
}

app$layout(
  htmlDiv(list(
    # App Banner
    htmlDiv(list(
      htmlH1("Seek-a-Movie", className = "display-3"),
      htmlP("Interactive Movie Selector", className = "lead"),
      htmlP("Displays the top 10 highest grossing US movies based on your taste.",
            className = "lead"),
      htmlP("Compare the IMDB and Rotten Tomaties ratings to help you decide what to watch!",
            className = "lead")
    ), className = "app-main--first-title row"),

    # Main Container
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
        ), className = "app-main--rating-container app-main--filter-panel"),
        htmlDiv(list(
          htmlP("Release Year", className="app-main--container-title"),
          htmlDiv(list(
            htmlDiv(list(
              htmlP("from", className="app-main--dropdown-title"),
              dccDropdown(id="dd-year-from",
                          options = year_options,
                          value = default_from,
                          className="app-main--dropdown",
                          clearable = FALSE)
            ), className="app-main--dropdown-wrapper"),
            htmlDiv(list(
              htmlP("to", className="app-main--dropdown-title"),
              dccDropdown(id="dd-year-to",
                          options = year_options,
                          value = default_to,
                          className="app-main--dropdown",
                          clearable = FALSE)
            ), className="app-main--dropdown-wrapper")
          ), className="app-main--year-selector")
        ), className = "app-main--year-container app-main--filter-panel")
      ), className = "app-main--panel-left"),
      # Right Panel
      htmlDiv(list(
        htmlDiv(list(
          dccGraph(id = "upper-graph")
        ), className = "app-main--panel-right-upper"),
        htmlDiv(list(
          dccGraph(id = 'lower-graph')
        ), className = "app-main--panel-right-lower")
      ), className = "app-main--panel-right")
    ), className = "app-main--container")
  ), className = "wrapper")
)

app$callback(
  output=list(id = "upper-graph", property="figure"),

  params=list(input(id = "cb-genres", property = "value"),
              input(id = "cb-ratings", property = "value"),
              input(id = "dd-year-from", property = "value"),
              input(id = "dd-year-to", property = "value")),

  function(genres, ratings, year_from, year_to) {
    df <- filter_data(genres, ratings, year_from, year_to)
    create_upper_chart(df)
  })

app$callback(
  output=list(id = "lower-graph", property="figure"),

  params=list(input(id = "cb-genres", property = "value"),
              input(id = "cb-ratings", property = "value"),
              input(id = "dd-year-from", property = "value"),
              input(id = "dd-year-to", property = "value")),

  function(genres, ratings, year_from, year_to) {
    df <- filter_data(genres, ratings, year_from, year_to)
    create_upper_chart(df)
  })

app$run_server()
