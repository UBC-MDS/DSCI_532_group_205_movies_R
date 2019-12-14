#
# The data
#
movies_df <- read_csv("data/movies.csv",
                      col_types = cols(MPAA_Rating = col_factor(),
                                       Major_Genre = col_factor(),
                                       Release_Year = col_integer())) %>%
  mutate(Rotten_Tomatoes_Rating = as.integer(Rotten_Tomatoes_Rating),
         US_Gross_per_million = round(US_Gross / 1e6, 2)) %>%
         select(Title,
                MPAA_Rating,
                Major_Genre,
                Release_Year,
                US_Gross,
                US_Gross_per_million,
                Rotten_Tomatoes_Rating,
                IMDB_Rating) %>%
         drop_na()

#' Filter movies data based on genres, ratings and release year
#'
#' @param genres A vector of genre strings
#' @param ratings A vector of rating strings
#' @param year_range A vector with starting and ending year
#'
#' @return Filtered tibble of movies data
#'
filter_data <- function(genres, ratings, year_range) {
  movies_df %>%
    filter(Major_Genre %in% genres,
           MPAA_Rating %in% ratings,
           Release_Year >= year_range[1],
           Release_Year <= year_range[2])
}

#' Helper function for creating options data for DashR controls
#'
#' @param values A vector of values for the control.
#' @param labels A optional vector of labels that the user sees.
#'
#' If labels is NULL, the values are used as labels.
#'
#' @return A list of label/value list pairs
#'
make_checklist_options <- function(values, labels = NULL) {
  if (is_null(labels))
    labels <- values

  map2(labels, values, ~ (list(label = .x, value = .y)))
}

#' Get the unfiltered dataset
#'
#' @return unfiltered dataset
#'
get_full_data <- function() {
   movies_df
}

#
# Global filter controls data
#

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
