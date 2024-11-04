# setwd("../../montesmariana/r-best-practices-exercises/data")
install.packages("here",
        "tidyverse", 
        "renv", 
        "reprex",
        "readr",
        "dplyr"
        )
library("here",
        "tidyverse", 
        "renv", 
        "reprex",
        "readr",
        "dplyr")
# start ####
## read file data ####
some_flight_data<-read.csv(here("exercises", "data", "Flight Subset 2013.csv"))
df2 <- readr::read_csv(here("exercises", "data", "Flight Subset 2013.csv"))
## categorize #### 
some_flight_data$month_name <- month.name[some_flight_data$month]
some_flight_data$carrier <- as.factor(some_flight_data$carrier)
some_flight_data$tailnum <- as.factor(some_flight_data$tailnum)
some_flight_data$origin <- as.factor(some_flight_data$origin)

# work #### 
## define ####
delay_categories <- c("Early", "Kind of on time", "Late")

# calculate ####
for(i in 1:length(some_flight_data$dep_delay)){
if(is.na(some_flight_data$dep_delay[[i]])){
some_flight_data[i, "dep_delay_cat"] <- NA
}else if(some_flight_data$dep_delay[[i]] < -30){
    some_flight_data[i, "dep_delay_cat"] <- delay_categories[[1]]
       }else if(some_flight_data$dep_delay[[i]] < 30){
    some_flight_data[i, "dep_delay_cat"] <- delay_categories[[2]]
  } else {
    some_flight_data[i, "dep_delay_cat"] <- delay_categories[[3]]
  }
}
some_flight_data$dep_delay_cat <- as.factor(some_flight_data$dep_delay_cat)

# rename ####
df_delay <- some_flight_data
# of gebruik 'ctrl+F' EN GEBRUIK 'whole word'!!!

# better form: ####
library(here)
i_am("index.qmd")
some_flights <- read.csv(here("exercises", "data", "nycflights13_random2000.csv"))

# better work with pipe operator ####
# pipe magrittr %>% or R base: |> or ctrl+shift+m . Native pipe is universal
some_flights_raw <- readr::read_csv(here("exercises", "data", "nycflights13_random2000.csv"))
some_flights <- some_flights_raw |>
  mutate(across(where(is.character), as.factor))
some_flights |> select(where(is.factor))

# month names ####

month.name # old r: this variable already exists in R

some_flights |>
  mutate(month_name = month.name[month]) |> 
  select(month_name, month)

# improved ####
# across ends_with = alle kolommen die op 'delay' eindigen. .x is een vervanging voor die kolomnamen
some_flights |> 
  mutate(
    across(ends_with("delay"),
           ~ case_when(
             is.na(.x) ~ NA,
             .x < -30 ~ "Early",
             .x < 30 ~ "Kind of on time",
             TRUE ~ "Late"
           ) |> as.factor(),
           .names = "{.col}_category"
    ))

# comma separated values ##### 


