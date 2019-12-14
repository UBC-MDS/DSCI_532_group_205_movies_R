# Reflection

## Accomplishments

- Our app runs very fast, which helps in selecting the movies you want to see. 
- The UI of our is very simple and easily understood. 
- Our app was able to accomplish what we proposed in milestone 3, with minor modifications based on the feedback we received from the course instructor.  

## Limitations

- Our app does not have the interactivity between the two plots that we proposed. This is partly due to the time constraints for the project, and based on our discussion with the course instructor.  

- Apart from the movie name, the app does not provide information about the cast, story, etc. Moreover, it only shows the movies from Hollywood, which may not be useful for everyone. 

- Our app is unable to hide the plot controls that appear on the top right corner of the plot. 

## Future Improvements

- The app should have more interactivity between the two plots. For example, if you click on the movie from the first chart then the second chart should highlight the ratings of the selected movie. 

- The app should include movies outside of Hollywood to make it more useful for people around the world.

- To make the app more visually appealing, it should show the movie poster instead of its name. 

## Implementation based on Feedback

This app has been modified based on the discussion we had with had with the course instructor and the TA for the Python version of the app. Thus, it may not reflect all the things we proposed in milestone 3. Following are the comments made by the TA for this app  with our response: 

- Your proposal looks good and interesting
- Make sure all of you are committing. I only see commits from two people. Also, remember to use issues to communicate

> We are working on committing more frequently. Also, our team tends to work more close to the deadlines, which means more commits by everyone. 

- Consider making the scatterplot filterable as well, with the same controls. There is too much data in this plot and it will allow the user to hover over other movies that are not in the top 10

> Based on the discussion with the course instructor, we have implemented geom_hex instead of scatter plot to avoid over-plotting. 

- Consider replacing the year Dropdowns with a slide bar

> We have implemented this suggestion in our app.

- Add a link to your data source

> The dataset was obtained from the vega-dataset. The link can be found below. 
> https://github.com/vega/vega-datasets/blob/master/data/movies.json

- I tried to filter for after 2010 and no movies appear in the bar plot. Do you know why is this happening? Try fixing this!

> It happened due to a bug in the data wrangling. We have fixed this bug in the R version of the app.

