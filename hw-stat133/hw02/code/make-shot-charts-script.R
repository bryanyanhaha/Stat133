#title:make-shot-charts-script
#description: the creation of shot charts
#inputs: curry,klay,igudala, green, durant
#outputs:nab-court.jpg
#        andre-igudala-shot-chart.pdf
#        draymond-green-shot-chart.pdf
#        kevin-durant-shot-chart.pdf
#        klay-thompson-shot-chats.pdf
#        stephen-curry-shot-charts.pdf

library(ggplot2)
#setup
court_file <- ("hw-stat133/hw02/images/nba-court.jpg")
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1,"npc"),
  height = unit(1, "npc"))


#create shot charts for each player and save the plots in pdf format
 ggplot(data = igudala)+annotation_custom(court_image, -250,250,-50,420) +
  geom_point(aes(x=x,y=y, color = shot_made_flag))+ylim(-50,420)+ggtitle('shot chart : andre iguodala (2016 season)')+theme_minimal()
ggsave('hw-stat133/hw02/images/andre-iguodala-shot-chart.pdf',width = 6.5, height = 5, units = "in")


ggplot(data = curry)+annotation_custom(court_image, -250,250,-50,420) +
  geom_point(aes(x=x,y=y, color = shot_made_flag))+ylim(-50,420)+ggtitle('shot chart : stephen curry (2016 season)')+theme_minimal()
ggsave('hw-stat133/hw02/images/stephen-curry-shot-chart.pdf',width = 6.5, height = 5, units = "in")

ggplot(data = thompson)+annotation_custom(court_image, -250,250,-50,420) +
  geom_point(aes(x=x,y=y, color = shot_made_flag))+ylim(-50,420)+ggtitle('shot chart : klay thompson (2016 season)')+theme_minimal()
ggsave('hw-stat133/hw02/images/klay-thompson-shot-chart.pdf',width = 6.5, height = 5, units = "in")

ggplot(data = green)+annotation_custom(court_image, -250,250,-50,420) +
  geom_point(aes(x=x,y=y, color = shot_made_flag))+ylim(-50,420)+ggtitle('shot chart : draymond green (2016 season)')+theme_minimal()
ggsave('hw-stat133/hw02/images/draymond-green-shot-chart.pdf',width = 6.5, height = 5, units = "in")

ggplot(data = durant)+annotation_custom(court_image, -250,250,-50,420) +
  geom_point(aes(x=x,y=y, color = shot_made_flag))+ylim(-50,420)+ggtitle('shot chart : kevin durant (2016 season)')+theme_minimal()
ggsave('hw-stat133/hw02/images/kevin-durant-shot-chart.pdf',width = 6.5, height = 5, units = "in")

#create one graph to show all the shot charts in one image

ggplot(data = a)+annotation_custom(court_image, -250,250,-50,420) +
  geom_point(aes(x=x,y=y, color = shot_made_flag))+ylim(-50,420)+ggtitle('shot chart : gsw (2016 season)')+theme_minimal()+facet_wrap(~name)
ggsave('hw-stat133/hw02/images/gsw-shot-chart.pdf',width = 8, height = 7, units = "in")








