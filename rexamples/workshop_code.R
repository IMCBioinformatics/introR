#Code demo for intro to R

library(ggplot2)

weight_kg <- 55
weight_lb<-weight_kg*2.2

#functions
print(weight_kg)
print("Hello World")

a<-9
b<-sqrt(a)
round(2.324444)
round(2.324444,digit=2)

# Vectors
weight_g<-c(50,90,40,86.5)
animals<-c("cat","dog","monkey","parrot")
pets<-c(FALSE,TRUE,TRUE,TRUE)
weight_g<-c(50,90,40,86.5,"90")
pets<-c("FALSE",TRUE,TRUE,TRUE)
length(pets)

#Conditional subsetting
# Operators == ,<,>,<=,>=, !=,!,!x,|,&

idx<-animals=="cat"

animals[idx]
weight_g[weight_g < 60]

#which
weight_g[which(weight_g < 60)]

# %in%
idx<-which(animals %in% c("monkey","cat","snake"))

#Can you figure out why “four” > “five” returns TRUE?

#Missing Data NA
a<-c(10,12,14,NA,50)
a[is.na(a)]<-0
#mean(),median()
mean(a,na.rm = TRUE)

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

heights_no_na<-na.omit(heights)
median(heights_no_na)
median(heights,na.rm = T)


# read in files
metadata<-read.csv(file = "data/Ecoli_metadata.csv",stringsAsFactors =T )

head(metadata)
str(metadata)

#exercise 6.5.1
BMI <- data.frame(gender = c("male", "male", "female"),
                  height = c(152, 171.5, 165), 
                  weight = c(81, 93, 78), 
                  age = c(42, 36, 26),stringsAsFactors = F)


dim(BMI)
nrows(BMI)
ncol(BMI)
summary(BMI)
rownames(BMI)
colnames(BMI)



metadata[2,2]
metadata$generation[2]
metadata[,"strain"]
# 5th row of the genome_size column
metadata$genome_size[5]
metadata[5,7]
metadata[5,"genome_size"]
metadata["5","genome_size"]

as.factor()
as.numeric()
as.character()
as.logical()

### Tidyverse
library(tidyverse)

friends_data <- tibble(
  name = c("Nicolas", "Thierry", "Bernard", "Jerome"),
  age = c(27, 25, 29, 26),
  height = c(180, 170, 185, 169),
  married = c(TRUE, FALSE, TRUE, TRUE)
)
read.csv() -- dataframe
read_csv() --- tibble

metadata2<-read_csv("data/Ecoli_metadata.csv")



as_tibble(metadata)


as.data.frame(metadata2)
metadata2$generation[7]
str(metadata2)


#Tidy data tidyr
#gather()---> helps you convert wide data to long data
#spread()---> helps you convert logn data to wide
#separate() --> helps you separate variable

messy <- data.frame(
  name = c("Wilbur", "Petunia", "Gregory"),
  drugA = c(NA, 80, 64),
  drugB = c(NA, 90, 50),
  drugA_B=c(45,NA,NA)
)

var1<-gather(messy,key="drug",value ="heartrate",drugA:drugB )
gather(messy,key="drug",value ="heartrate", )
#name drug(key) heartrate(value)


set.seed(10)
messy <- data.frame( id = 1:4, 
        trt = sample(rep(c('control', 'treatment'), each = 2)), work.T1 = runif(4),home.T1 = runif(4),work.T2 = runif(4), home.T2 = runif(4))


va2<-separate(data = tidy,col = "location",into =c("loc","time"),sep = "\\." )
separate(data = tidy,col = "location",into =c("loc","time"),sep = 5 )

tidyr<-messy %>% gather(key = "location",value="cytokine",work.T1:home.T2) %>%
  separate(col = "location",into =c("loc","time"),sep = 5 )
  
library(tidyverse)
#mutate
metadata2<-metadata2 %>% mutate(genome_bp=genome_size*10000)
metadata_m<-metadata2 %>% mutate(genome_size=genome_size*10000)
metadata<-metadata %>% mutate(generation=generation/max(generation))

#summarize + group_by
ncounts<-metadata %>% group_by(clade) %>% summarize(n())
clade_mean_gs<-metadata %>% group_by(clade) %>% summarize(mean_gs=mean(genome_size))
metadata %>%  group_by(cit,clade,generation) %>% summarize(mean_gs=mean(genome_size))

metadata %>%  group_by(generation,cit,clade) %>% 
  summarize(mean_gs=mean(genome_size),median_gz=median(genome_size))

#ggplot2 data visualization
# read in the new file
vcf<-read.csv("data/combined_tidy_vcf.csv",stringsAsFactors = T)
#Use functions like head and str to get to know the file.

#ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()

p<-ggplot(vcf,aes(x =POS ,y =DP )) +geom_point()

ggplot(vcf,aes(x =POS ,y =DP ,color="red")) 


ggplot(vcf,aes(x =POS ,y =DP ,color="red")) + geom_point(alpha=0.5)
p<-ggplot(vcf,aes(x =POS ,y =DP ,color=sample_id)) + geom_point(alpha=0.5)

p +labs(x="SNPs",y="Depth")

#faceting

p + facet_grid(row~columns)
p+ facet_grid(sample_id ~.)
p+ facet_grid(INDEL~sample_id)

#facet_wrap
# free

p+ facet_grid(INDEL~sample_id) +theme_bw()

#barplots
ggplot(vcf,aes(x =INDEL,y=POS ,color=sample_id,fill=sample_id)) +
  geom_col() +facet_grid(.~sample_id) + 
  scale_fill_manual(values=c("pink", "yellow", "#56B4E9"))+
  scale_color_manual(values=c("pink", "yellow", "#56B4E9"))

#Histogram
ggplot(vcf,aes(x = QUAL,color="red",fill="red")) +geom_histogram(binwidth=12) +labs(color="TT",fill="TT")

#Boxplots

ggplot(vcf,aes(x=sample_id,y=log10(DP))) +geom_boxplot()

log10(vcf$DP)



