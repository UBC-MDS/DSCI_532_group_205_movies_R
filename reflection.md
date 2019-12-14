# Reflection
We managed to accomplish our original goals for this app in that we answered our research questions and delivered an app to
handle the usage scenario that we set out to achieve. We now reflect upon our completed work. 

## Accomplishments

- Our movie selection app is successfully built-in plotly/dashR and deployed using Heroku
- The app is simple and easy to use 
- The plots are interactive. Selecting a bar in the upper plot would highlight the same movie in the lower plot
- The overplotting issue we had in the Python version of the app was successfully resolved by choosing a suitable plot
- We were able to accomplish what we proposed in milestone 3, with some minor modifications based on the feedback we received  

## Limitations

- Our app does not have the interactivity between the two plots that we proposed. This is partly due to the time constraints for the project and based on our discussion with the course instructor.  

- Apart from the movie name, the app does not provide information about the cast, story, etc. Moreover, it only shows the movies from Hollywood, which may not be useful for everyone. 

- Our app is unable to hide the plot controls that appear on the top right corner of the plot. This is apparently a known issue with the more recent versions of plotly.

- When user selection returns no movies, the app shows a blank chart instead of some useful message to the user. We tried fixing this and was making progress but the technique that we were using, that dynamically created the dccGraph chart objects, affected the ability to implement the chart-to-chart interactivity. So we reverted the changes and aborted this feature.

- Chart-to-chart interactivity limitations
When the chart is first displayed, all bars are selected; no option to start with all bars faded which will clue the user to select one.
Once a bar has been selected, the user can select that same bar to reset the chart to all bars selected. However, there is no way to communicate this to the lower chart. The event triggered is the same as when a single bar is being selected. Also, when the user updates the selection, the upper chart reset to no bars selected. However, the lower chart doesn't reset and highlights the last selected bar. 

- App deployed to Heroku is much slower than anticipated

## Future Improvements

- Make the app more visually appealing. For example, it should show the movie poster instead of its name. 

- Allow user to see more than the top 10 movies for the selected criteria

- Allow users to select between the US and worldwide gross movie income. 


## Implementation based on Feedback

This app has been modified based on the discussion we had with the course instructor and the TA for the Python version of the app. Thus, it may not reflect all the things we proposed in milestone 3. Following are the comments made by the TA for this app  with our response: 

- Your proposal looks good and interesting
- Make sure all of you are committing. I only see commits from two people. Also, remember to use issues to communicate

> We are working on committing more frequently. In milestone 3, for the R app, we were only making plots in Jupiter notebook to make the screenshots. So those works were not pushed to the GitHub repo. That is why there was no commit from one person in milestone 3. For milestone 4 we tried committing frequently.   

- Consider making the scatterplot filterable as well, with the same controls. There is too much data in this plot and it will allow the user to hover over other movies that are not in the top 10

> Based on the discussion with the course instructor, we have implemented geom_hex instead of scatter plot to avoid over-plotting. 
> The dropdown option for selecting year range has been replaced with a slide bar and it has been moved to the top of the layout. Now users can have more control over the data by adjusting the sliding bar easily. 

- Consider replacing the year Dropdowns with a slide bar

> We have implemented this suggestion in our app.

- Add a link to your data source

> The dataset was obtained from the vega-dataset. The link can be found below. The same is included in the app. 
> https://github.com/vega/vega-datasets/blob/master/data/movies.json

- I tried to filter for after 2010 and no movies appear in the bar plot. Do you know why is this happening? Try fixing this!

> This is because the dataset has no movie after 2010. This is not a bug but a limitation of the available data.  

- The course instructor suggested using one color instead of showing the top ten movies in 10 different colors. 

> We have implemented this in our app. The plots now have only one color by default. When the user clicks on a bar in the upper plot, the respective plot will be highlighted in the lower plot. So we did not have to use 10 different colors to distinguish different movies. This functionality was available in the Python app as well. However, there were not enough instructions available to the user to use this functionality. 

- Course instructor suggested labeling lower scatterplot directly with text annotations

> We implemented this feature. However, as discussed in https://github.com/UBC-MDS/DSCI_532_group_205_movies_R/issues/6, the labels were overlapping. Also, with the interactivity of upper and lower plot working, this feature seemed redundant. Hence we decided to remove this feature from our app. 

