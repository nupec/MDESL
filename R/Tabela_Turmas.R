library(tidyverse)
library(readxl)
library(data.table)


# Tabela Escola

# Importação da base de interesse

# MATRICULA_NORTE <- read_delim("Dados/MATRICULA_NORTE.CSV",
# "|")
# Apenas variáveis seleiconadas
variaveis_selecionadas <- c("NU_ANO_CENSO",
                            "ID_TURMA",
                            "NO_TURMA",
                            "TP_MEDIACAO_DIDATICO_PEDAGO",
                            "NU_DIAS_ATIVIDADE",
                            "TP_TIPO_ATENDIMENTO_TURMA",
                            "TP_TIPO_LOCAL_TURMA",
                            "TP_ETAPA_ENSINO",
                            "IN_ESPECIAL_EXCLUSIVA",
                            "IN_REGULAR",
                            "IN_EJA",
                            "IN_PROFISSIONALIZANTE",
                            "QT_MATRICULAS",
                            "IN_DISC_LINGUA_PORTUGUESA",
                            "IN_DISC_EDUCACAO_FISICA",
                            "IN_DISC_ARTES",
                            "IN_DISC_LINGUA_INGLES",
                            "IN_DISC_LINGUA_ESPANHOL",
                            "IN_DISC_LINGUA_FRANCES",
                            "IN_DISC_LINGUA_OUTRA",
                            "IN_DISC_LIBRAS",
                            "IN_DISC_LINGUA_INDIGENA",
                            "IN_DISC_PORT_SEGUNDA_LINGUA",
                            "IN_DISC_MATEMATICA",
                            "IN_DISC_CIENCIAS",
                            "IN_DISC_FISICA",
                            "IN_DISC_QUIMICA",
                            "IN_DISC_BIOLOGIA",
                            "IN_DISC_HISTORIA",
                            "IN_DISC_GEOGRAFIA",
                            "IN_DISC_SOCIOLOGIA",
                            "IN_DISC_FILOSOFIA",
                            "IN_DISC_ESTUDOS_SOCIAIS",
                            "IN_DISC_EST_SOCIAIS_SOCIOLOGIA",
                            "IN_DISC_INFORMATICA_COMPUTACAO",
                            "IN_DISC_ENSINO_RELIGIOSO",
                            "IN_DISC_PROFISSIONALIZANTE",
                            "IN_DISC_ESTAGIO_SUPERVISIONADO",
                            "IN_DISC_PEDAGOGICAS",
                            "IN_DISC_OUTRAS")

turmas <- data.table::fread("Dados/Base_Turmas/turmas.csv",
                            select = variaveis_selecionadas)

dplyr::glimpse(turmas)


readr::write_csv2(turmas, "Dados/Base_Turmas/turmas2020.csv")
