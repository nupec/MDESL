library(tidyverse)
library(readxl)
library(lubridate)
library(plyr)

# Importando as matrículas do Norte (Censo escolar)

# 1) Segundo o INEP, O software R, como padrão, trabalha com as bases de dados utilizando a memória RAM do
# computador. Entretanto, o carregamento de bases muito grandes (por exemplo, mais de 1 milhão
# de linhas) utilizando a leitura tradicional (como “read.table” ou “read.csv”) pode sobrecarregar o
# computador, ou mesmo resultar em erro por falta de memória. Dessa forma, para a leitura das
# bases de MATRÍCULAS e DOCENTES, que possuem mais de 10 milhões de linhas (Brasil), faz-se
# necessário o uso de pacotes adicionais. Sugerimos o uso do pacote “ffbase” para trabalhar com
# essas bases, tendo em vista que o mesmo faz uso do disco rígido em detrimento da memória RAM.
# Evidentemente, as bases de ESCOLAS e TURMAS também podem ser carregadas utilizando esse
# pacote, sendo recomendável quando houver necessidade de cruzar informações entre as bases. O
# pacote “ffbase” armazena a base de dados no R como um objeto da classe “ffdf” - diferentemente
# da leitura tradicional, que gera um objeto da classe “data.frame”. O objeto “ffdf” também permite a
# aplicação de algumas funções – não todas – que são utilizadas com objetos da classe “data.frame”
# (por exemplo, “table”, “merge” e ”transform”). Para aplicação de filtros nas bases “ffdf”,
# recomendamos o uso da função “ffwhich”
# (veja a ajuda da função para maiores informações:
# “?ffwhich”). Além disso, para concatenar as bases de cada região (as bases Docentes e Matrículas                                                                                                            estão separadas por região), uma abaixo da outra, é necessário utilizar a função “ffdfappend” (para
#                                                                                                                                                                                                            mais informações: “?ffdfappend”). Informações adicionais estão disponíveis na ajuda do pacote
# (https://cran.r-project.org/web/packages/ffbase/ffbase.pdf).

# 2) Ainda utilizando o mesmo script, instale o pacote necessário para a manipulação de bases maiores
# (ffbase) copiando e colando os comandos abaixo. Rode os comandos pressionando Ctrl+R.
# install.packages("ffbase", dependencies = TRUE) #Instala o pacote
# require(ffbase) #Carrega o pacote

# install.packages("ffbase", dependencies = TRUE)

# library(ffbase)

# 3) Caso você tenha aberto um novo script, será necessário certificar-se novamente de que o Diretório
# de Trabalho no R corresponde ao local onde estão presentes os arquivos por meio dos mesmos
# comandos já citados anteriormente:
# getwd() #Se o caminho não estiver correto, use a função a seguir para alterá-lo:
# setwd("C:/Usuários/Fulano/Documentos/Arquivos censo") #Exemplo de caminho. Lembre-se de
# usar barra simples (“/”) ou barra invertida dupla (“\\”).

# 4) Para abrir o arquivo “MATRICULA_NORTE.csv”, por exemplo, copie o comando abaixo e cole no
# script. Rode o comando pressionando Ctrl+R. O atributo “first.rows” determina a quantidade de
# linhas utilizadas para que o programa perceba o tipo/categoria das variáveis.
# docentes_se<-read.csv2.ffdf(file="DOCENTES_SUDESTE.csv",sep="|",first.rows=100000)
# É importante que o Pipe ( | ) seja utilizado como delimitador.

# matricula_norte <-read.csv2.ffdf(file="Dados/MATRICULA_NORTE.CSV",
#                                 sep="|",first.rows=1000) # uma amostra da base de dados

# 5) Bases grandes, quando carregadas pela primeira vez, podem demorar alguns minutos para
# concluir o processamento (dependendo das configurações do computador). Sugerimos salvar a
# base no formato ‘ffdf’ para que uma nova carga inicial não seja necessária numa próxima sessão.
# save.ffdf(docentes_se, dir="./docentes_se")

# save.ffdf(matricula_norte, dir=".dados/matricula_norte")

# 6) Dados salvos no formato ‘ffdf’ podem ser carregados em um outro momento utilizando o comando
# abaixo. O carregamento da base com a função abaixo é praticamente instantâneo.
# load.ffdf(dir="./docentes_se")

# 7) Após esses procedimentos, a base de dados já estará aberta, permitindo sua análise. Para conferir
# se a base foi lida corretamente, é possível visualizar algumas linhas copiando o comando abaixo e
# colando no script. Rode o comando pressionando Ctrl+R. Nesse exemplo, são visualizadas as
# cinco primeiras linhas de cada coluna.
# matricula_noirte[1:5,]

# matricula_norte[1:5,]

# Fonte: Microdados do Censo da Educação Básica 2018 Manual do Usuário INEP

# Outra forma de trabalhar com essas grandes bases é selecionado as variáveis de
# de interesse

# Variávies disponíveis para análise

# - attr(*, "spec")=
#   .. cols(
#     ..   NU_ANO_CENSO = col_double(),
#     ..   ID_ALUNO = col_character(),
#     ..   ID_MATRICULA = col_double(),
#     ..   NU_DIA = col_double(),
#     ..   NU_MES = col_double(),
#     ..   NU_ANO = col_double(),
#     ..   NU_IDADE_REFERENCIA = col_double(),
#     ..   NU_IDADE = col_double(),
#     ..   NU_DURACAO_TURMA = col_double(),
#     ..   NU_DUR_ATIV_COMP_MESMA_REDE = col_double(),
#     ..   NU_DUR_ATIV_COMP_OUTRAS_REDES = col_double(),
#     ..   NU_DUR_AEE_MESMA_REDE = col_double(),
#     ..   NU_DUR_AEE_OUTRAS_REDES = col_double(),
#     ..   NU_DIAS_ATIVIDADE = col_double(),
#     ..   TP_SEXO = col_double(),
#     ..   TP_COR_RACA = col_double(),
#     ..   TP_NACIONALIDADE = col_double(),
#     ..   CO_PAIS_ORIGEM = col_double(),
#     ..   CO_UF_NASC = col_double(),
#     ..   CO_MUNICIPIO_NASC = col_double(),
#     ..   CO_UF_END = col_double(),
#     ..   CO_MUNICIPIO_END = col_double(),
#     ..   TP_ZONA_RESIDENCIAL = col_double(),
#     ..   TP_OUTRO_LOCAL_AULA = col_double(),
#     ..   IN_TRANSPORTE_PUBLICO = col_double(),
#     ..   TP_RESPONSAVEL_TRANSPORTE = col_double(),
#     ..   IN_TRANSP_VANS_KOMBI = col_double(),
#     ..   IN_TRANSP_MICRO_ONIBUS = col_double(),
#     ..   IN_TRANSP_ONIBUS = col_double(),
#     ..   IN_TRANSP_BICICLETA = col_double(),
#     ..   IN_TRANSP_TR_ANIMAL = col_double(),
#     ..   IN_TRANSP_OUTRO_VEICULO = col_double(),
#     ..   IN_TRANSP_EMBAR_ATE5 = col_double(),
#     ..   IN_TRANSP_EMBAR_5A15 = col_double(),
#     ..   IN_TRANSP_EMBAR_15A35 = col_double(),
#     ..   IN_TRANSP_EMBAR_35 = col_double(),
#     ..   IN_TRANSP_TREM_METRO = col_double(),
#     ..   IN_NECESSIDADE_ESPECIAL = col_double(),
#     ..   IN_CEGUEIRA = col_double(),
#     ..   IN_BAIXA_VISAO = col_double(),
#     ..   IN_SURDEZ = col_double(),
#     ..   IN_DEF_AUDITIVA = col_double(),
#     ..   IN_SURDOCEGUEIRA = col_double(),
#     ..   IN_DEF_FISICA = col_double(),
#     ..   IN_DEF_INTELECTUAL = col_double(),
#     ..   IN_DEF_MULTIPLA = col_double(),
#     ..   IN_AUTISMO = col_double(),
#     ..   IN_SINDROME_ASPERGER = col_double(),
#     ..   IN_SINDROME_RETT = col_double(),
#     ..   IN_TRANSTORNO_DI = col_double(),
#     ..   IN_SUPERDOTACAO = col_double(),
#     ..   IN_RECURSO_LEDOR = col_double(),
#     ..   IN_RECURSO_TRANSCRICAO = col_double(),
#     ..   IN_RECURSO_INTERPRETE = col_double(),
#     ..   IN_RECURSO_LIBRAS = col_double(),
#     ..   IN_RECURSO_LABIAL = col_double(),
#     ..   IN_RECURSO_BRAILLE = col_double(),
#     ..   IN_RECURSO_AMPLIADA_16 = col_double(),
#     ..   IN_RECURSO_AMPLIADA_20 = col_double(),
#     ..   IN_RECURSO_AMPLIADA_24 = col_double(),
#     ..   IN_RECURSO_NENHUM = col_double(),
#     ..   TP_INGRESSO_FEDERAIS = col_double(),
#     ..   TP_MEDIACAO_DIDATICO_PEDAGO = col_double(),
#     ..   IN_ESPECIAL_EXCLUSIVA = col_double(),
#     ..   IN_REGULAR = col_double(),
#     ..   IN_EJA = col_double(),
#     ..   IN_PROFISSIONALIZANTE = col_double(),
#     ..   TP_ETAPA_ENSINO = col_double(),
#     ..   ID_TURMA = col_double(),
#     ..   CO_CURSO_EDUC_PROFISSIONAL = col_double(),
#     ..   TP_UNIFICADA = col_double(),
#     ..   TP_TIPO_TURMA = col_double(),
#     ..   CO_ENTIDADE = col_double(),
#     ..   CO_REGIAO = col_double(),
#     ..   CO_MESORREGIAO = col_double(),
#     ..   CO_MICRORREGIAO = col_double(),
#     ..   CO_UF = col_double(),
#     ..   CO_MUNICIPIO = col_double(),
#     ..   CO_DISTRITO = col_double(),
#     ..   TP_DEPENDENCIA = col_double(),
#     ..   TP_LOCALIZACAO = col_double(),
#     ..   TP_CATEGORIA_ESCOLA_PRIVADA = col_double(),
#     ..   IN_CONVENIADA_PP = col_double(),
#     ..   TP_CONVENIO_PODER_PUBLICO = col_double(),
#     ..   IN_MANT_ESCOLA_PRIVADA_EMP = col_double(),
#     ..   IN_MANT_ESCOLA_PRIVADA_ONG = col_double(),
#     ..   IN_MANT_ESCOLA_PRIVADA_SIND = col_double(),
#     ..   IN_MANT_ESCOLA_PRIVADA_SIST_S = col_double(),
#     ..   IN_MANT_ESCOLA_PRIVADA_S_FINS = col_double(),
#     ..   TP_REGULAMENTACAO = col_double(),
#     ..   TP_LOCALIZACAO_DIFERENCIADA = col_double(),
#     ..   IN_EDUCACAO_INDIGENA = col_double()
#     .. )



# A partir dessa base de dados, alguma variáveis serão selecionadas. Para o
# cálculo dos indicadores 1A e 1B da Meta 1 do PNE, precisamos apenas de:


# Importação da base de interesse

# MATRICULA_NORTE <- read_delim("Dados/MATRICULA_NORTE.CSV",
                              # "|")
# Apenas variáveis seleiconadas

variaveis_selecionadas <- c("NU_IDADE_REFERENCIA",
                            "CO_MUNICIPIO_END",
                            "CO_UF_END",
                            "CO_MUNICIPIO_END",
                            "TP_DEPENDENCIA",
                            "TP_ETAPA_ENSINO",
                            "CO_REGIAO",
                            "CO_MESORREGIAO",
                            "CO_UF",
                            "CO_MUNICIPIO",
                            "CO_DISTRITO")

MATRICULA_NORTE <- read_delim("Dados/MATRICULA_NORTE.CSV",
                              "|", escape_double = FALSE,
                              trim_ws = TRUE,
                              col_names = variaveis_selecionadas)

glimpse(MATRICULA_NORTE)

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
