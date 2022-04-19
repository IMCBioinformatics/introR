library(tidyverse)
raw<-read.csv("../../introR2020/rworkshop/data/Brauer2008_DataSet1.csv",stringsAsFactors = T)
dim(raw)

clean<-raw %>%
  separate(NAME,c("gene","BP", "MP", "gene_id", "number"),sep="\\|\\|") %>%
  select(-GID,-YORF,-GWEIGHT)%>% 
  gather(key = variable,value = expression,G0.05:U0.3)%>% 
  separate(variable,c("nutrient","growth_rate"),sep=1)%>%
  mutate_at(vars(gene:gene_id),str_trim)

clean %>% mutate_at(vars(gene:gene_id),str_trim)


## Plots

leu<-clean %>% filter(gene=="LEU1") %>% ggplot()


leu %>% ggplot(aes(x=growth_rate,y=expression,color=nutrient)) +geom_line(aes(group=nutrient)) +geom_point()

lbs<-clean %>% filter(BP=="leucine biosynthesis")


lbs %>% ggplot(aes(x=growth_rate,y=expression,color=nutrient))+geom_line(aes(group=nutrient)) +geom_point() +facet_wrap(~gene)


## Heatmaps

library(pheatmap)



