install.packages(c("dplyr", "tidyr", "stringr", "lubridate", "janitor","DataExplorer","ggplot2"))

library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(janitor)
library(DataExplorer)
library(ggplot2)

df <- readRDS("df_organizado.rds")
table(df$tempo)
##plot_missing(df)
df %>%
  filter(is.na(disciplina)) %>%
  count(responsavel) %>%
  ggplot(aes(x = reorder(responsavel, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Quantidade de Disciplinas não preenchidas por Responsável",
       x = "Responsável",
       y = "Total de Disciplinas Vazias")