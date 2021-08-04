library(tidyverse)
library(readxl)
library(data.table)


# Tabela Escola

# Importação da base de interesse

# MATRICULA_NORTE <- read_delim("Dados/MATRICULA_NORTE.CSV",
# "|")
# Apenas variáveis seleiconadas
variaveis_selecionadas <- c("NU_ANO_CENSO",
                            "CO_ENTIDADE",
                            "NO_ENTIDADE",
                            "CO_ORGAO_REGIONAL",
                            "TP_SITUACAO_FUNCIONAMENTO",
                            "CO_REGIAO",
                            "CO_UF",
                            "CO_MUNICIPIO",
                            "TP_DEPENDENCIA",
                            "TP_LOCALIZACAO",
                            "TP_LOCALIZACAO_DIFERENCIADA",
                            "IN_VINCULO_SECRETARIA_EDUCACAO",
                            "IN_VINCULO_SEGURANCA_PUBLICA",
                            "IN_VINCULO_SECRETARIA_SAUDE",
                            "IN_VINCULO_OUTRO_ORGAO",
                            "TP_CATEGORIA_ESCOLA_PRIVADA",
                            "IN_CONVENIADA_PP",
                            "TP_CONVENIO_PODER_PUBLICO",
                            "IN_MANT_ESCOLA_PRIVADA_EMP",
                            "IN_MANT_ESCOLA_PRIVADA_ONG",
                            "IN_MANT_ESCOLA_PRIVADA_OSCIP",
                            "IN_MANT_ESCOLA_PRIV_ONG_OSCIP",
                            "IN_MANT_ESCOLA_PRIVADA_SIND",
                            "IN_MANT_ESCOLA_PRIVADA_SIST_S",
                            "IN_MANT_ESCOLA_PRIVADA_S_FINS",
                            "TP_REGULAMENTACAO",
                            "TP_RESPONSAVEL_REGULAMENTACAO",
                            "IN_LOCAL_FUNC_PREDIO_ESCOLAR",
                            "TP_OCUPACAO_PREDIO_ESCOLAR",
                            "QT_SALAS_UTILIZADAS_DENTRO",
                            "QT_SALAS_UTILIZADAS_FORA",
                            "QT_SALAS_UTILIZADAS")

escolas <- data.table::fread("Dados/escolas.csv",
                 select = variaveis_selecionadas)

dplyr::glimpse(escolas)

# Salvando o arquivo base escolas Brasil
readr::write_rds(escolas, "dados/baseEscolas2020.rds")

# Filtrando as escolas da região Norte
escolasNorte2020 <- escolas |> dplyr::filter(CO_REGIAO == 1)

readr::write_rds(escolasNorte2020, "dados/escolasNorte2020.rds")
readr::write_csv2(escolasNorte2020, "dados/escolasNorte2020.csv")
