library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)

# Load assets
app <- Dash$new(assets_folder = "assets")

movies_df <- read_csv("data/movies.csv")

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
                          value = (year_options %>% first())$label,
                          className="app-main--dropdown",
                          clearable = FALSE)
            ), className="app-main--dropdown-wrapper"),
            htmlDiv(list(
              htmlP("to", className="app-main--dropdown-title"),
              dccDropdown(id="dd-year-to",
                          options = year_options,
                          value = (year_options %>% last())$label,
                          className="app-main--dropdown",
                          clearable = FALSE)
            ), className="app-main--dropdown-wrapper")
          ), className="app-main--year-selector")
        ), className = "app-main--year-container app-main--filter-panel")
      ), className = "app-main--panel-left"),
      # Right Panel
      htmlDiv(list(
        htmlP('charts go here')
      ), className = "app-main--panel-right")
    ), className = "app-main--container")
  ), className = "wrapper")
)

app$run_server()
