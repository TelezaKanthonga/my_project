install.packages("ggplot2")

library(ggplot2)
library(dplyr) # data manipulation
library(scales) # nicer axis scale labels
install.packages("gapminder")
library(gapminder)
if(!require(gapminder)) {install.packages("gapminder"); library(gapminder)}
str(gapminder)
gapminder
summary(gapminder)
table(gapminder$continent, gapminder$year)
with(gapminder, {table(continent, year)})#with makes variables in a data set available directly
##with(gapminder, (table(continent, year



#***************1D plots: Bar plots for discrete variables***************
ggplot(gapminder, aes(x=continent)) + geom_bar() #to see just distributions of continent,we only specify x axis and y axis will be count by default

ggplot(gapminder, aes(x=continent, fill=continent)) + geom_bar() #To make bar graph color by continent

ggplot(gapminder, aes(x=continent, fill=continent)) + 
  geom_bar(aes(y=after_stat(count)/12)) + #transform the count to count the nbr of countries
  labs(y="Number of countries") + #add a better label to y axis
  guides(fill="none") #remove the legend (redundancy)

#Display number of countries in a continent
mybar <-  ggplot(gapminder, aes(x=continent, fill=continent)) + 
  geom_bar(aes(y=..count../12)) +
  labs(y="Number of countries") +
  guides(fill="none")# record a plot for future use

mybar

mybar + coord_trans(y="sqrt") #transform the scale by sqrt
mybar + coord_flip()  #flip axis and make bar horizontal,now x ais will have number of countries and y axis continent
mybar + coord_polar() #stacked bar in polar coordinates,transform bar to polar coordinates
#mybar + coord_polar(x ="sqrt")



#***************1D plots: density plots for continuous variables***************
#density plot,we can eiyher use line chart or area chart
ggplot(data=gapminder, aes(x=lifeExp)) + #plotting the continuous variable lifeExp
  geom_density()   # calculate and plot the smoothed frequency distribution of lifeExp

ggplot(data=gapminder, aes(x=lifeExp)) + 
  geom_density(size=1.5, fill="pink", alpha=0.5) #add line thickness, fill color and set color transparency

#Distribution of life expect by continent
ggplot(data=gapminder, aes(x=lifeExp, fill=continent)) +
    geom_density(alpha=0.3)


#Histogram
ggplot(data=gapminder, aes(x=lifeExp)) + 
  geom_histogram(aes(y=..density..), binwidth=4, color="black", fill="lightblue", alpha=0.5) # using histogram,used to show frequency of variable/data

#lifeExp is a bimodal variable, the plot look weird and need more clarification
#need more aesthetic to be more clear
ggplot(data=gapminder, aes(x=lifeExp, fill=continent)) + #adding the aesthetic fill to see the difference among continent
  geom_density(alpha=0.3)



#***************boxplots and other visual summaries***************more used for statistical analysis
gap1 <- ggplot( data=gapminder, aes(x=continent, y=lifeExp, fill=continent)) #change the aesthetic to show continent on one axis, and life expectancy (lifeExp) on the other.
gap1 +
  geom_boxplot(outlier.size=2) #add a boxplot layer





#*******Challenge1**********
#1. Remove the legend from this plot
gap1 <- ggplot(data=gapminder, aes(x=continent, y=lifeExp, fill=continent)) #change the aesthetic to show continent on one axis, and life expectancy (lifeExp) on the other.
gap1 <- gap1 +
  geom_boxplot(outlier.size=2) 
  guides(fill="none")
#2. Also, make the plot horizontal
  gap1 + coord_flip()
#3. Instead of a box plot, try geom_violin
  gap2 <- gap1 + geom_violin()
  gap2
  

  
  
  

#********Effect ordering
#use the dplyr "pipe" notation (%>%) to send the gapminder data to the dplyr:;mutate() function, and within that, 
#reorder() the continents by their median life expectancy
library(dplyr) # data manipulation
gapminder %>% 
  mutate(continent = reorder(continent, lifeExp, FUN=median))

gapminder %>% #piping the result of this right into ggplot
  mutate(continent = reorder(continent, lifeExp, FUN=median)) %>%
  ggplot(aes(x=continent, y=lifeExp, fill=continent)) +
  geom_boxplot(outlier.size=2)

#******Looking at GDP
ggplot(data=gapminder, aes(x=gdpPercap)) + 
  geom_density() #distribution of gdpPercap with the unconditional distribution

#*******Challenge2**********
#1. As we did for lifeExp plot the distributions separately for each continent

ggplot(data=gapminder, aes(x=continent)) + #plotting the continuous variable lifeExp
  geom_density()   # calculate and plot the smoothed frequency distribution of lifeExp

ggplot(data=gapminder, aes(x=continent)) + 
  geom_density(size=1.5, alpha=0.5) #add line thickness, fill color and set color transparency

ggplot(data=gapminder, aes(x=continent, fill=continent)) + #adding the aesthetic fill to see the difference among continent
  geom_density(alpha=0.3)


#2.  plot GDP on a log scale

ggplot(data=gapminder, aes(x=gdpPercap,fill=continent) + 
  geom_density(size=1.5, alpha=0.5))

ggplot(data=gapminder, aes(x=log10(gdpPercap),fill=continent)) + 
  geom_density(size=1.5, alpha=0.5)
  
  



#3. Make boxplots of gdpPercap by continent



#4. Do the same, but plot GDP on a log scale






#***************1.5D: Layers & Time series plots***************
#How life expectancy change with GDP per country?
#China for example

china <- ggplot(subset(gapminder, country =="China"), #subsetting data
                aes(x=gdpPercap, y=lifeExp))
china + geom_line()

china + geom_line() + geom_point()  #adding points to data values

china + geom_line(color="lightblue") + geom_point(color="violetred") #adding some colors to  points and the line

#what happens if we use:
china + geom_point(color="violetred") + geom_line(color="lightblue")

china + geom_line() + geom_point(aes(color=year)) #color the point by year #define the easthetics for each layer
china + geom_line() + geom_point(aes(color=year))+ scale_color_gradientn(colours = rainbow(5)) #with a rainbow
china + geom_line() + geom_point() + aes(color=year) #coloring both point and line
china + geom_line() + geom_point() + aes(color=year)+ scale_color_gradientn(colours = rainbow(5)) #both with rainbow shade


#*******Challenge3**********
#1. Make a plot of lifeExp vs gdpPercap for China and India, with both lines and points

india <- ggplot(subset(gapminder, country == "India"), aes(x=gdpPercap, y=lifeExp))

india + geom_line()
india + geom_line() + geom_point() 
china + geom_line() + geom_point() 

china_india<- ggplot(subset(gapminder, country == "China" | country == "India"),
                     aes(x=gdpPercap, y=lifeExp))

china_india + geom_line() + geom_point() 

#How has life expectancy changed over time? 
#plot line chart for each year
 

ggplot(gapminder, aes(x=year,  y=lifeExp, group=country)) +
         geom_line() 
  ggplot(gapminder, aes(x=year, y=lifeExp, group=country, color=continent)) +
           geom_line() 
  ggplot(gapminder, aes(x=year,  y=lifeExp, group=country, color=continent)) +
           geom_line(alpha = 0.5) 

#by plotting a line for each country over year


#***************Plotting a summary**************
#for a better look at trends over time

gapminder %>%
  group_by(continent, year) %>%
  summarise(lifeExp=median(lifeExp)) %>% head() #median for each year and continent

gapminder %>% #piping to ggplot
  group_by(continent, year) %>%
  summarise(lifeExp=median(lifeExp)) %>%
  ggplot(aes(x=year, y=lifeExp, color=continent)) +
  geom_line(size=1) + 
  geom_point(size=1.5)

gapminder %>% #saving in a new dataset using assignement
  group_by(continent, year) %>%
  summarise(lifeExp=median(lifeExp)) -> gapyear

ggplot(gapyear, aes(x=year, y=lifeExp, color=continent)) +  #fitting linear regression lines for each continent
  geom_point(size=1.5) +
  geom_smooth(aes(fill=continent), method="lm")

ggplot(gapyear, aes(x=year, y=lifeExp, color=continent)) +  #using a loess smooth
  geom_point(size=1.5) +
  geom_smooth(aes(fill=continent), method="loess")

ggplot(gapyear, aes(x=year, y=lifeExp, color=continent)) +  #using a loess smooth
  geom_point(size=1.5) +
  theme(                
    legend.position = c(0.99, 0.03),
    legend.justification = c("right", "bottom") #placing the legend inside the plot
  )+
  geom_smooth(aes(fill=continent), method="loess")




#***************2D: Scatterplots***************

#explore relationshp of life expentancy by continent
gm_2007 <- subset(gapminder, year==2007) #filtering data by picking those of 2007 
ggplot(gm_2007, aes(y=lifeExp, x=continent)) + geom_point()
ggplot(gm_2007, aes(y=lifeExp, x=continent)) +
  geom_point(position=position_jitter(width=0.1, height=0)) #changing scale by jittering 


#explore the relationship between life expectancy and GDP with a scatterplot
plt <- ggplot(data=gapminder,
              aes(x=gdpPercap, y=lifeExp))
plt + geom_point()

plt + geom_point(aes(color=continent)) #adding color by continent

plt + geom_point(aes(color=continent)) +
  geom_smooth(method="loess")  #adding a smoothed curve for all the data

plt + geom_point(aes(color=continent)) +
  geom_smooth(method="loess") +
  scale_x_log10()     #plotting on a log scale

plt + geom_point(aes(color=continent)) +
  geom_smooth(method="loess") +
  scale_x_log10(labels=scales::comma)    #adjusting scale

plt + geom_point(aes(color=continent)) +
  geom_smooth(method="loess") +
  scale_x_log10(labels=scales::comma) +
  theme(legend.position = c(0.8, 0.2)) # putting the legend inside the plot

plt + geom_point(aes(color=continent)) +
  geom_smooth(method="loess") +
  scale_x_log10(labels=scales::comma) +
  theme_bw()   #changing the theme of the plot

plt + geom_point(aes(color=continent)) +
  geom_smooth(method="lm") +
  scale_x_log10(labels=scales::comma) +
  theme_bw()     #smoothing by a regression line for each continent

plt <- ggplot(data=gapminder,
              aes(x=gdpPercap, y=lifeExp, color = continent))
plt + geom_point(aes(size = pop)) +  #making a bubble plot by mapping the size of each point to population
  geom_smooth(method="lm") +
  scale_x_log10(labels=scales::comma) +
  theme_bw()
plt + geom_point(aes(size = pop), alpha = 0.5) +  #changing colors shade
  geom_smooth(method="lm") +
  scale_x_log10(labels=scales::comma) +
  theme_bw()





#***********GOING FURTHER1*************
#Explorinf gdp versus life expectancy in 2007 with highlighting the larger countries

ggplot(gm_2007) +
  geom_point(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop),# add scatter points
             alpha = 0.5) +
  geom_text(aes(x = gdpPercap, y = lifeExp + 3, label = country), # add some text annotations for the very large countries
            color = "grey50",
            data = filter(gm_2007, pop > 1000000000 | country %in% c("Nigeria", "United States"))) +
  scale_x_log10(limits = c(200, 60000)) + # clean the axes names and breaks
  labs(title = "GDP versus life expectancy in 2007", # change labels
       x = "GDP per capita (log scale)",
       y = "Life expectancy",
       size = "Population",
       color = "Continent") +
  scale_size(range = c(0.1, 10), # change the size scale
             guide = "none") + # remove size legend
  theme_classic() +   # add a nicer theme
  theme(legend.position = "top",  # place legend at top and grey axis lines
        axis.line = element_line(color = "grey85"),
        axis.ticks = element_line(color = "grey85"))





#***********GOING FURTHER2*************
#exploring the relationship between life expectancy and GDP over time

install.packages('plotly')
library(plotly) # adds a frame aesthetic to ggplot, and allows interactive, linked views of a series of frames over time

g <- crosstalk::SharedData$new(gapminder, ~continent)
gg <- ggplot(g, aes(gdpPercap, lifeExp, color = continent, frame = year)) +
  geom_point(aes(size = pop, ids = country)) +
  geom_smooth(se = FALSE, method = "lm") +
  scale_x_log10()
ggplotly(gg) %>% 
  highlight("plotly_hover")



