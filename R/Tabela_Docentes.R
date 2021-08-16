library(tidyverse)
library(readxl)
library(data.table)


# Tabela Escola

# Importação da base de interesse

# MATRICULA_NORTE <- read_delim("Dados/MATRICULA_NORTE.CSV",
# "|")
# Apenas variáveis seleiconadas
variaveis_selecionadas <- c("NU_ANO_CENSO",
                            "NU_MES",
                            "NU_ANO",
                            "NU_IDADE",
                            "TP_SEXO",
                            "TP_COR_RACA",
                            "TP_NACIONALIDADE",
                            "CO_UF_NASC",
                            "CO_MUNICIPIO_NASC",
                            "CO_UF_END",
                            "TP_ZONA_RESIDENCIAL",
                            "TP_LOCAL_RESID_DIFERENCIADA",
                            "IN_NECESSIDADE_ESPECIAL",
                            "TP_ESCOLARIDADE",
                            "TP_ENSINO_MEDIO",
                            "TP_SITUACAO_CURSO_1",
                            "IN_ESPECIALIZACAO",
                            "IN_MESTRADO",
                            "IN_DOUTORADO",
                            "IN_POS_NENHUM")

docentes <- data.table::fread("Dados/Base_Docentes/docentes_norte.csv",
                            select = variaveis_selecionadas)

dplyr::glimpse(docentes)

readr::write_csv2(docentes, "Dados/Base_Docentes/docentes_nortes2020.csv")
