#load package
library(tidyverse)

#Challenge 2
gapminder <-read.csv("data/gapminder.csv")
gapminder
gapminder_1977 <- filter(gapminder, year == 1977)

#a plot of gapminder)1977
#basic structure: ggplot(<DATA>, <AESTHETIC MAPPING>) + <GEOMETRY FUNCTION>
ggplot(
  data = gapminder_1977,
  mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)
) +
  geom_point() +
  scale_x_log10()

#challenge 4_plotting different combinations
# ggplot(gapminder_1977, aes(x = <VAR1>, y = <VAR2>, colour = <VAR3>)) + geom_point()
ggplot(
  data = gapminder_1977,
  mapping = aes(x = country, y = lifeExp, colour = pop, size = gdpPercap)
) +
  geom_point()

#
ggplot(
  data = gapminder_1977,
  mapping = aes(x = country, y = lifeExp, colour = pop)
) +
  geom_point()

#
ggplot(
  data = gapminder_1977,
  mapping = aes(x = lifeExp, y = continent, colour = gdpPercap, size = pop)
) +
  geom_point()

# alternative method using pipe
gapminder_1977 %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)) +
  geom_point() +
  scale_x_log10()

#challenge 5: aesthetics mapped to a geom
?geom_point()
#x, y, alpha, colour, fill, group, shape, size, stroke

#challenge 6
gapminder_1977 %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)) +
  geom_point(stroke = 2, shape = 11, alpha = 0.5, fill = 'orange') +
  scale_x_log10()

gapminder_1977 %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, shape = continent, size = pop)) +
  geom_point(alpha = 0.4) +
  scale_x_log10()
#challenge_7: Create a scatterplot using gapminder that shows life expectancy
# has changed over time.
gapminder %>% 
  ggplot(mapping = aes(x = year, y = lifeExp, colour = continent, group = country)) +
  geom_line() + 
  geom_point()

#challenge 8: lines are coloured and the points remain black
#then swap the order of geom_line() and geom_point()

gapminder %>% 
  ggplot(mapping = aes(x = year, y = lifeExp, group = country)) +
  geom_line(mapping = aes(colour = continent)) + 
  geom_point()


gapminder %>% 
  ggplot(mapping = aes(x = year, y = lifeExp, group = country, colour = continent)) +
  geom_line() + 
  geom_point(colour = "black")

#swapping the order
gapminder %>% 
  ggplot(mapping = aes(x = year, y = lifeExp, group = country, colour = continent)) +
  geom_point(colour = "black") +
  geom_line() 
  
gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  geom_smooth(method = "lm", size = 2)

#Challenge 9: Modify the color and size of the points on the point layer in the previous example
gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(size = 1.0, colour = "red", alpha = 0.3) +
  scale_x_log10() +
  geom_smooth(method = "lm", size = 0.5)

#Challenge 10: Modify your solution to Challenge 9 so that the points are now a different 
#shape and are colored by continent with new trendlines. Hint: The color argument can
#be used inside the aesthetic.
gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, colour = continent)) +
  geom_point(size = 2.0, alpha = 0.5, shape = "triangle") +
  scale_x_log10() +
  geom_smooth(method = "lm", size = 0.5)

gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(mapping = aes (colour = continent), size = 2.0, alpha = 0.5, shape = "triangle") +
  scale_x_log10() +
  geom_smooth(mapping = aes(colour = continent), method = "lm", size = 0.5) +
  geom_smooth(method = "lm") #no colour by continent

#Scales
gapminder %>% 
  ggplot(mapping = aes(x = year, y = lifeExp, colour = continent)) +
  geom_point() +
  scale_colour_manual(values = c("red", "green", "blue", "purple", "black"))

#Challenge 11: Try modifying the plot above by changing some colours in the scale
#to see if you can find a pleasing combination. Run the colours() function if you want to see
#a list of colour names R can use.  
gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10() +
  scale_colour_brewer(palette = "Dark2")

gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10() +
  scale_colour_manual(values = c("thistle", "tan2", "steelblue4", "springgreen2", "whitesmoke"))  

colours()
scale_colour_brewer()

#Separating plots
a_countries <- filter(gapminder, str_starts(country, "A"))

ggplot(a_countries, aes(x = year, y = lifeExp, colour = continent, group = country)) +
  geom_line() +
  facet_wrap(~country)

#Challenge 12: When discussing the gapminder video, we decided to ignore the animation component. 
#Facets provide an option for achieving a similar effect in a static image.
#Take our original plot

ggplot(
  data = gapminder_1977,
  mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)
) +
  geom_point() +
  scale_x_log10()

ggplot(
  data = gapminder,
  mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)
) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~year)

#Preparing plots for display
rough_plot <- ggplot(data = a_countries, aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  facet_wrap( ~ country)

rough_plot

#Modifying text
rough_plot +
  labs(
    title = "Figure 1", # main title of figure
    x = "Year", # x axis title
    y = "Life Expectancy", # y axis title
    color = "Continent" # title of legend
  )

#challenge: “Figure 1” is not a very useful title.
#Modify the code above so that the title is more descriptive
#Let’s also make sure we acknowledge our sources. Add a caption reading “Data source: Gapminder”

rough_plot +
  labs(
    title = "Growth in life expectancy for 'A' countries", # main title of figure
    x = "Year", # x axis title
    y = "Life Expectancy", # y axis title
    color = "Continent",
    caption = "Data source: Gapminder"# title of legend
  ) +
  theme_bw() +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold")
  )

#Modifying looks

rough_plot +
  labs(
    title = "Growth in life expectancy for 'A' countries", # main title of figure
    x = "Year", # x axis title
    y = "Life Expectancy", # y axis title
    color = "Continent",
    caption = "Data source: Gapminder"# title of legend
  ) +
  theme_bw() +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold")
  )

#challenge
#What would you pass to the theme() function to make the following changes?
#1) Remove the grey boxes behind the country names (controlled by the strip.background parameter).
#2) Increase the size of the major gridlines ( panel.grid.major ) to 1 (need to use element_line() )
#3) Change the axis titles to be shrunk to size 10 and coloured blue
#4) Position the legend at the bottom of the plot.

rough_plot +
  labs(
    title = "Growth in life expectancy for 'A' countries", # main title of figure
    x = "Year", # x axis title
    y = "Life Expectancy", # y axis title
    color = "Continent",
    caption = "Data source: Gapminder"# title of legend
  ) +
  theme_bw() +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"), 
    strip.background.x = element_blank(), 
    panel.grid.major = element_line(size = 1),
    axis.title = element_text(size = 10, colour = "blue"),
    legend.position = "bottom"
  )

#export your image for publication

lifeExp_plot <- rough_plot +
  labs(
    title = "Growth in life expectancy for 'A' countries", # main title of figure
    x = "Year", # x axis title
    y = "Life Expectancy", # y axis title
    color = "Continent",
    caption = "Data source: Gapminder"# title of legend
  ) +
  theme_bw() +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"), 
    strip.background.x = element_blank(), 
    panel.grid.major = element_line(size = 1),
    axis.title = element_text(size = 10, colour = "blue"),
    legend.position = "bottom"
  )

lifeExp_plot

#to save the plot
ggsave(filename = "results/lifeExp_plot.png", plot = lifeExp_plot, 
       width = 20, height = 15, dpi = 300, units = "cm")

#multi-panel figures
install.packages("cowplot")
library(cowplot)

plot1 <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point()
plot2 <- ggplot(gapminder, aes(x = continent, y = lifeExp)) + geom_boxplot()
plot3 <- ggplot(gapminder, aes(x = gdpPercap, y = pop)) + geom_point()
plot4 <- ggplot(gapminder, aes(x = lifeExp, y = pop)) + geom_point()

#combine them into one plot
plot_grid(plot1, plot2, plot3, plot4)

plot_grid(plot1, plot2, plot3, plot4, rel_heights = c(1, 2))

plot_grid(plot1, plot2, plot3, plot4, labels = "AUTO")

#challenge

board_games <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-12/board_games.csv")

board_ga

#knitr challenge
gapminder_oz <- filter(gapminder, country == "Australia")
ggplot(gapminder_oz, aes(x = year, y = pop)) +
  geom_point()

