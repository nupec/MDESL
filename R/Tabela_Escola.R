library(plyr)
library(tidyverse)
library(readxl)
library(lubridate)


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

ESCOLAS <- read_delim("Dados/escolas.csv",
                      "|", escape_double = FALSE,
                      trim_ws = TRUE,
                      col_names = variaveis_selecionadas)

glimpse(ESCOLAS)

# Seleção do município para cálculo da matricula da educação infantil

nome_da_cidade_escolhida <- "Itacoatiara"
cod_cidade_escolhida     <- 1301902

filtro_por_cidade <- MATRICULA_NORTE[MATRICULA_NORTE$CO_MUNICIPIO == cod_cidade_escolhida,
                                     variaveis_selecionadas]
#como salvar a base no computador

write.csv2(filtro_por_cidade, "output/filtro_por_cidade.csv")

# O Código acima apresenta a base de dados do CENSO ESCOLAR para a cidade de
# interesse. A partir dessa base, é possível agregar as matrículas por faixa-etária
# e série

# 1 - Educação Infantil - Creche
# 2 - Educação Infantil - Pré-escola

# A seguir, a quantidade de alunos de 0 a 3 anos
qtde_alunos_0a3 <- sum(filtro_por_cidade$TP_ETAPA_ENSINO == 1, na.rm = T)

# Qauntidade de alunos com 4 e 5 anos
qtde_alunos_4a5 <- sum(filtro_por_cidade$TP_ETAPA_ENSINO == 2, na.rm = T)

faixa_etaria <- matrix(c(qtde_alunos_0a3, qtde_alunos_4a5),
                       ncol = 2,
                       byrow = T)


colnames(faixa_etaria) <- c("Alunos de 0 a 3 anos",
                            "Alunos de 4 a 5 anos")

# Meta 1: Indicador 1B

indicador_1B <- qtde_alunos_0a3/faixaEtaria0a3

mensagem1 <- paste0("O indicador 1B, da Meta 1 do Plano Nacional de Educação do",
                    " município ", nome_da_cidade_escolhida, ", que mede o percetual",
                    " de crianças de 0 a 3 anos matriculados",
                    " em creches é de ", round(indicador_1B, 2), ".")

print(mensagem1)

# Meta 1: Indicador 1A
indicador_1A <- faixaEtaria4a5/qtde_alunos_4a5

mensagem2 <- paste0("O indicador 1A, da Meta 1 do Plano Nacional de Educação do",
                    " município ", nome_da_cidade_escolhida, " que mede o percetual",
                    " de crianças de 4 a 5 anos matriculados",
                    " em creches é de ", round(indicador_1A, 2), ".")

print(mensagem2)


Meta_1 <- (qtde_alunos_0a3 + qtde_alunos_4a5)/(faixaEtaria0a3  + faixaEtaria4a5)

mensagem3 <- paste0("O município de ", cidade, " alcançou ",
                    round(Meta_1, 2), " referente à Meta 1 do Plano Nacional de Educação",
                    " no ano de 2018")

print(mensagem3)
