library(tidyverse)
library(readxl)
library(data.table)


# Tabela Escola

# Importação da base de interesse

# MATRICULA_NORTE <- read_delim("Dados/MATRICULA_NORTE.CSV",
# "|")
# Apenas variáveis seleiconadas
variaveis_selecionadas <- c("NU_ANO_CENSO",
                            "ID_ALUNO",
                            "ID_MATRICULA",
                            "NU_MES",
                            "NU_ANO",
                            "NU_IDADE_REFERENCIA",
                            "NU_IDADE",
                            "TP_SEXO",
                            "TP_COR_RACA",
                            "TP_NACIONALIDADE",
                            "CO_PAIS_ORIGEM",
                            "CO_UF_NASC",
                            "CO_MUNICIPIO_NASC",
                            "CO_UF_END",
                            "CO_MUNICIPIO_END",
                            "TP_ZONA_RESIDENCIAL",
                            "TP_LOCAL_RESID_DIFERENCIADA",
                            "IN_NECESSIDADE_ESPECIAL",
                            "TP_OUTRO_LOCAL_AULA",
                            "IN_TRANSPORTE_PUBLICO",
                            "TP_RESPONSAVEL_TRANSPORTE",
                            "IN_TRANSP_BICICLETA",
                            "IN_TRANSP_MICRO_ONIBUS",
                            "IN_TRANSP_ONIBUS",
                            "IN_TRANSP_TR_ANIMAL",
                            "IN_TRANSP_VANS_KOMBI",
                            "IN_TRANSP_OUTRO_VEICULO",
                            "IN_TRANSP_EMBAR_ATE5",
                            "IN_TRANSP_EMBAR_5A15",
                            "IN_TRANSP_EMBAR_15A35",
                            "IN_TRANSP_EMBAR_35")

matricula <- data.table::fread("Dados/Base_Matricula/matricula_norte.csv",
                             select = variaveis_selecionadas)

dplyr::glimpse(matricula)

readr::write_csv2(matricula, "Dados/Base_Matricula/matriculaNorte2020.csv")
