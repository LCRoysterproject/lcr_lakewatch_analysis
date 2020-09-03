library("tidyverse")

#Reading in data from data folder
lab <- read.csv("data/lakewatch.csv", header= T) 

#Removing all -999 from data frames
lab[lab == -999] <- NA

#Factoring levels of the sites
lab$Site <- factor(lab$Site, levels = c("6", "1", "5", "2", "4", "3"))


cond_color<-
  lab %>% 
  filter(Sensor_Type == "LAKEWATCH") %>% 
  mutate(reef_dev= if_else(as.Date(Date) 
                           < "2018-11-15 00:00:00", "Before Reef Dev", "After Reef Dev")) %>% 
ggplot(aes(x= Conductivity, y= Color, color= as.factor(reef_dev)))+
  labs(color= "") +
  geom_point(size= 1.5)+
  scale_colour_manual(values = c("blue", "orange"))+
  theme_bw() +
  facet_wrap(~Site, ncol=2)

ggsave("writing/figures/ cond_color.png")
