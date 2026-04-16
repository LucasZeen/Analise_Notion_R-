install.packages(c("dplyr", "tidyr", "stringr", "lubridate", "janitor","DataExplorer"))

library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(janitor)
library(DataExplorer)

df <- readRDS("df_organizado.rds")
table(df$disciplina)
