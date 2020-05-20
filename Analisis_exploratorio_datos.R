################### ANÃLISIS EXPLORATORIO DE DATOS ######################
# David Cox: regresiÃ³n de cox: anÃ¡lisis de la supervicencia (procesos estocÃ¡sticos,
# diseÃ±os experimentales)
#"NO HAY PREGUNTAS RUTINARIAS EN ESTADÃSTICA, SINO PREGUNTAS ACERCA DE LAS RUTINAS ESTADÃSTICA"
# EN ESTADÃSTICA NO EXISTE UNA RUTINA, SINO LAS RUTINAS ESTADÃSTICAS FUNCIONAN O NO

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

#eliminar todos los valores atípicos
good_diamonds <- diamonds %>% 
  filter(between(y, 2.5, 29.5))
#es lo menos recomendable que podemos hacer.
#lo recomendable es reemplazar los valores o errores a NA

#reemplazar los valores atípicos con NA
good_diamonds <- diamonds %>% 
  mutate(y = ifelse(y<2 | y>30, NA, y))#función ifelse es una función condicionante
#los valores malos son las ys menores que 2 ó las mayores que 30 
# si esta condición es verdad yo quiero que el valor sea un NA, y si no me quedo 
#con la misma Y que tenía
#en caso que la condición booleana se satisaga se devuelve el segundo argumento 
#de la condición ifelse. y para todos los valores falsos se cumple el tercer argumento

ggplot(good_diamonds, mapping = aes(x=x, y=y))+
  geom_point()
#para eliminar esta advertencia
# *Warning message:
  # *Removed 9 rows containing missing values (geom_point). 

ggplot(good_diamonds, mapping = aes(x=x, y=y))+
  geom_point(na.rm = T)

nyflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100, #para que me de la hora
    sched_min = sched_dep_time %% 100, #para que me de los minutos
    sched_dep_time =sched_hour + sched_min /60
    )
ggplot(mapping = aes(sched_dep_time)) +
  geom_freqpoly(mapping = aes(color = cancelled), binwidth = 1/4)
install.packages("nyflights13")
### nyflights13 no está disponible en la versión 4.0

view(diamonds)
diamonds %>% 
  count(x, y, z)
ggplot(good_diamonds, mapping = aes(x=x))+
  geom_histogram()

ggplot(good_diamonds, mapping = aes(x=y))+
  geom_histogram()

ggplot(good_diamonds, mapping = aes(x=z))+
  geom_histogram()

###################creación de varios gráficos en uno##############

#desactivamos todas las ventanas gráficas o dispositivos
dev.off()

#abrimos el primer dispositivo
x11()

#creamos un diseño de matriz en el dispoistivo creado
matrix(c(1:4), nrow = 2, byrow = FALSE)

#hacemos el diseño de la matriz
layout(matrix(c(1:4), nrow = 2, byrow = FALSE))

#mostrar las cuatro particiones
layout.show(4)

#creamos el objeto de la matriz
config2x2 = matrix(c(1:4), nrow = 2, byrow = FALSE)
config2x2

#otros ejemplos de configuraciones
config3x2 = matrix(c(1:6), nrow = 2, byrow = FALSE)
config3x2

layout(config3x2)
layout.show(6)


#asignamos los gráficos creados anteriormente a cada uno de los cuadrantes
#para obtener la vista de una sola salida

fig.width = 3, out.width = "50%", fig.align = "default"
ggplot(good_diamonds, mapping = aes(x=x))+
  geom_histogram()
ggplot(good_diamonds, mapping = aes(x=y))+
  geom_histogram()
ggplot(good_diamonds, mapping = aes(x=z))+
  geom_histogram()

install.packages("vegan")
library (vegan)
data(dune)
data(dune.env)
pool <- with(dune.env, specpool(dune, Management))
pool
op <- par(mfrow=c(1,2))
boxplot(specnumber(dune) ~ Management, data = dune.env,
        col = "hotpink", border = "cyan3")
boxplot(specnumber(dune)/specpool2vect(pool) ~ Management,
        data = dune.env, col = "hotpink", border = "cyan3")
par(op)
data(BCI)
## Accumulation model
pool <- poolaccum(BCI)
summary(pool, display = "chao")
plot(pool)
## Quantitative model
estimateR(BCI[1:5,])

#####################COVARIACIÓN###############
#es la variación entre 2 o mas datos
#la visualización depende del tipo de dato o variable
#variable continua en diferentes categorías (lo mas común): con polígono de frecuencias
#categorias v/s continuas
#variables continuas
ggplot(diamonds, aes(x=price))+
  geom_freqpoly(aes(color=cut), binwidth =500)

#variables categóricas
ggplot(diamonds)+
  geom_bar(aes(x=cut))

#que mida la densidad: en vez de mostrar las ferecuencuas absolutas (count)
# mostrar la densidad. Es decir, conteo standarizado de modo que el área
# debajo de cada uno de los polígonos de frecuencia sume 1.
# Es decir, los que tienen mayor número serán divididos por 
# por un denominador mucho mas grande porque serán ponderados por el máximo.
#el truco está en que todas las áreas debajo de los polígonos
#sumarán lo mismo: tendrán área 1. La integral de la curva por debajo
#la misma tendría área 1 y la densidad en lugar de la representación standard
#serán comparables

ggplot(diamonds, aes(x=price, y = ..density..))+
  geom_freqpoly(aes(color=cut), binwidth =500)
#densidad:conteo estandarizado para medir variables continuas

################## BOXPLOT ############
ggplot(diamonds, aes(x=cut, y=price))+
  geom_boxplot()

#cuando no hay un orden intrínseco en la variable categórica
# es útil utilizar la función de reorden

ggplot(mpg, aes(x=class, y=hwy ))+
  geom_boxplot()
#se pueden reordenar las medianas

ggplot(mpg, aes(x= reorder(class,hwy, FUN=median),
                y=hwy ))+
  geom_boxplot()+
  coord_flip() #para cambiar el orden de los ejes para ver mejor la información

#categoría v/s categoría
ggplot(diamonds)+
  geom_count(aes(x=cut, y= color))

diamonds %>% 
  count(color, cut)
#para visualizar

diamonds %>% 
  count(color, cut) %>% 
  ggplot(aes(x=cut, y=color))+
  geom_tile(aes(fill=n))

#otros paquetes de visualización 3D e interactivos
#d3heatmap
#heatmaply

#continua v/s continua

ggplot(diamonds)+
  geom_point(aes(x=carat, y=price), alpha= 0.01)

#otra forma de visualizar para mapear la información es con las bins
#geomtry bins 2d

install.packages("hexbin")
library(hexbin)

ggplot(data=diamonds)+
  geom_bin2d(mapping=aes(x=carat, y=price))

ggplot(data = diamonds) +
  geom_hex(mmapping = aes(x=carat, y=price))

ggplot(data = diamonds, mapping = aes(x=carat, y=price))+
  geom_boxplot(aes(group = cut_width(carat, 0.01)))

#para que el gráfico se vea mas limpio

diamonds %>% 
  filter(carat <3) %>% 
  ggplot(mapping = aes(x=carat, y=price))+
  geom_boxplot(aes(group = cut_width(carat, 0.1)), varwidth = T)

diamonds %>% 
  filter(carat <3) %>% 
  ggplot(mapping = aes(x=carat, y=price))+
  geom_boxplot(aes(group = cut_number(carat, 20)))

############### VISUALIZACIÓN DE PATRONES#############

# * ¿Coincidencia?
# * ¿Relaciones que implica el patrón?
# * ¿Fuerza de la relación?
# * ¿Otras variables afectadas?
# * ¿Subgrupos?

ggplot (faithful) +
  geom_point(aes(x=eruptions, y=waiting))

library(modelr) 

mod <- lm(log(price) ~ log(carat), data = diamonds)
mod

diamonds_pred <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(res=exp(resid))
view(diamonds_pred)

ggplot(diamonds_pred)+
  geom_point(mapping = aes(x=carat, y=resid))

ggplot(diamonds_pred)+
  geom_boxplot(mapping = aes(x=cut, y=resid))

############ reflexiones de sintaxia###########

diamonds %>% 
  count(aes(clarity, cut, fill = n))+
  geom_tile()

############### DATA WRANLING ###########

# * IMPORTACIÓN
# * LIMPIEZA
# * TRANSFORMACIÓN DEL DATO


