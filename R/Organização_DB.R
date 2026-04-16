library(httr2)

# Limpa a memoria antes de rodar o script
rm(list = ls())


# Carrega as credenciais do .Renviron
token <- Sys.getenv("NOTION_TOKEN")
database_id <- Sys.getenv("NOTION_DATABASE_ID")

# Operador auxiliar para lidar com valores nulos
`%||%` <- function(a, b) if (!is.null(a)) a else b

# Busca os dados da API
resposta <- request("https://api.notion.com/v1/databases/") |>
  req_url_path_append(database_id, "query") |>
  req_headers(
    Authorization = paste("Bearer", token),
    "Notion-Version" = "2022-06-28",
    "Content-Type" = "application/json"
  ) |>
  req_body_raw('{}') |>
  req_perform()

dados <- resp_body_json(resposta)

# Transforma o JSON em data.frame
library(httr2)

token <- Sys.getenv("NOTION_TOKEN")
database_id <- Sys.getenv("NOTION_DATABASE_ID")

resposta <- request("https://api.notion.com/v1/databases/") |>
  req_url_path_append(database_id, "query") |>
  req_headers(
    Authorization = paste("Bearer", token),
    "Notion-Version" = "2022-06-28",
    "Content-Type" = "application/json"
  ) |>
  req_body_raw('{}') |>
  req_perform()

dados <- resp_body_json(resposta)

# Funções auxiliares
get_select <- function(x) if(!is.null(x$select$name)) x$select$name else NA
get_date   <- function(x) if(!is.null(x$date$start)) x$date$start else NA
get_number <- function(x) if(!is.null(x$number)) x$number else NA

# Transforma em data.frame
library(httr2)

token <- Sys.getenv("NOTION_TOKEN")
database_id <- Sys.getenv("NOTION_DATABASE_ID")

resposta <- request("https://api.notion.com/v1/databases/") |>
  req_url_path_append(database_id, "query") |>
  req_headers(
    Authorization = paste("Bearer", token),
    "Notion-Version" = "2022-06-28",
    "Content-Type" = "application/json"
  ) |>
  req_body_raw('{}') |>
  req_perform()

dados <- resp_body_json(resposta)

df <- do.call(rbind, lapply(dados$results, function(row) {
  props <- row$properties
  
  get_select <- function(x) if(!is.null(x$select$name)) x$select$name else NA
  get_date   <- function(x) if(!is.null(x$date$start)) x$date$start else NA
  get_number <- function(x) if(!is.null(x$number)) x$number else NA
  
  data.frame(
    Projeto     = get_select(props$Projeto),
    responsavel = get_select(props$Responsavel),
    data        = get_date(props$Data),
    tempo       = get_number(props$Tempo),
    disciplina  = get_select(props$Disciplina),
    atividade   = get_select(props$Atividade),
    stringsAsFactors = FALSE
  )
}))

df$data <- as.Date(df$data)

print(df)


