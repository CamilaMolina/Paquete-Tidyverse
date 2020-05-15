<<<<<<< HEAD
################### ANÃLISIS EXPLORATORIO DE DATOS ######################
# David Cox: regresiÃ³n de cox: anÃ¡lisis de la supervicencia (procesos estocÃ¡sticos,
# diseÃ±os experimentales)
#"NO HAY PREGUNTAS RUTINARIAS EN ESTADÃSTICA, SINO PREGUNTAS ACERCA DE LAS RUTINAS ESTADÃSTICA"
# EN ESTADÃSTICA NO EXISTE UNA RUTINA, SINO LAS RUTINAS ESTADÃSTICAS FUNCIONAN O NO
<<<<<<< HEAD

# Â¿ QuÃ© tipos de variaciones sufren las variables?
# Â¿QuÃ© tipÃ³ de covariaciones sufren las variables?

# variable: cantidad, factor o propiedad medible
# valor: estado de una variable al ser medida
# observaciÃ³n: conjunto de medidas tomadas en condiciones similares
# data point: conjunto de valores tomados para cada variable
# datos tabulares: conjunto de valores, asociado a cada variable y observaciÃ³n 
# de los datos estÃ¡n limpios, cada valor tiene su propia celda cada variable
# tiene su columna, y cada observaciÃ³n su fila.

################## VISUALIZACIÃ“N VARIABLE CONTINUA O CATEGÃ“RICA ############
library(tidyverse)
#Variable categÃ³rica o discreta: factor o vector de caracteres
ggplot(data=diamonds) +
  geom_bar(mapping = aes (x=cut))
ggsave("Gráficos/Conteo_variable_categórica.pdf")
diamonds %>% 
  count(cut)
#histograma divide el eje x en zonas x espaciadas que
#variable continua: conjunto infinito de valores ordenados
#por ejemplo nÃºmeros o fechas
#histograma de frecuencia
ggplot(diamonds)+
  geom_histogram(aes(x=carat), binwidth = 0.5)# binwith=anbchura
ggsave("Gráficos/histograma_carat_diamantes.pdf")
diamonds %>% 
  count(cut_width(carat, 0.5))
rlang::last_error()#para ver donde ocurre el último error
??rlang
diamond_filter <- diamonds %>% 
  filter(carat<3)
ggplot(diamond_filter) +
  geom_histogram(aes(x=carat), binwidth = 0.01)
#polígono de frecuencia (usa líneas y sirve para evitar la sobreposición)
ggplot(diamond_filter, mapping = aes(x=carat, color=cut)) +
  geom_freqpoly(binwidth = 0.1)
ggsave("Gráficos/polígono_frecuencia_carat_cut_diamonds.pdf")

########## * ¿Cuáles son los valores mas comunes y porqué? * ############

#¿Cuáles son los valores mas raros? ¿Porqué? ¿Cumple con lo que esperábamos?
#¿Vemos algún patrón característico o inusual?

################ ENCONTRANDO SUBGRUPOS EN LOS DATOS#################
# * Que determina que elementos de un cluster(grupos) sean similares entre si¡
# * Qué determina que clusters separados sean diferentes entre si
# * Describir y explicar cada uno de los clasters
# * Porqué algunas observaciones pueden ser clasificadas en el cluster erróneo
 view(faithful)
?faithfuld

ggplot (faithful, aes(x=eruptions)) +
  geom_histogram(binwidth = 0.2)

################# OUTLIERS #######################
ggplot(diamonds) +
  geom_histogram(mapping = aes(x=y), binwidth = 0.5)
#se observa mucho espacio vacío en el histograma ¿Qué pasara?
#¿Pueden haber outliers?
#Para comprobar esto: vamos a hacer un zoom al gráfico
ggplot(diamonds) +
  geom_histogram(mapping = aes(x=y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0,100))#ylim es para cambair los límites. También hat xlim
#podemos individualizar estos outliers
unusual_diamonds <- diamonds %>% 
  filter(y<2 | y>30) %>% 
  select(price, x,y,z) %>% 
  arrange(y)
view(unusual_diamonds)
#Se sospecha que los datos están malos, porque hay valores bastante atípicos.
#es muy útil analizar con o sin outliers para ver lo que pasa
#porque los outliers pueden trastocar todo lo que puedo llevar a cabo
#por tanto los outliers hay que saber que causan esos valores que se escapan
#al comportamiento: Detectar si son amigos o enemigos

