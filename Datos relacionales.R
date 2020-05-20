################ bases de datos relacionales#############
library(tidyverse)
nycflights13::airlines
airports
planes
weather
#se debe observar las variables entre las distintas bases
#lo primero que se debe detectar las claves primarias y foráneas
#clave: variable o conjunto de variables que de forma unívoca identifica la observación.
#una sola variable identifica una sola observación. otra variable necesitará mas de una variable para identiicar

#clave primaria: identifica de forma unívoca una observación de su propia tabla.
#por ejemplo: tailnum (número de cola), es la clave primaria de aviones 
#porque identifica de forma unívoca el avión.El carrier con las aerolíneas, el aeropuerto con el faa
#que identifica en forma unívoca dicho aeropuerto.NO existen dos aeropuertos con el mismo identificador.

#clave foránea:identifica unicamente la observación en otra tabla. 
#Ej: en la tabla vuelos, el número de cola (tailnum) no identifica al vuelo, PERO 
#identifica al avión. por lo tanto, flisghts tailnum es la clave foránea porque aparece 
#en la tabla de vuelos y coincide con el único avión existente de la tabla de aviones.
#Otro ej: origin es clave primaria de weather y clave foránea de flights.

#lo mas importante es identificar las claves primarias
#se pude utilizar la función count para ver que tienen una sola observación

planes %>% 
  count(tailnum) %>% 
  filter(n>1)

weather %>% 
  count(year, month, day, hour) %>% 
  filter(n>1)

weather %>% 
  count(year, month, day, hour, origin) %>% 
  filter(n>1)

flights %>% 
  count(year, month, day, hour, flight) %>% 
  filter(n>1)

flights %>% 
  count(year, month, day, hour, tailnum) %>% 
  filter(n>1)

#si no hay clave... inventamos un sustituto
#una relación: es una relación de uno a uno o uno a muchos 
#ej: cada vuelo tiene un solo avión, pero cada avión tiene muchos vuelos.
## relación de uno a muchos: cada vuelo tiene una sola compañía aérea, pero cada compañía áerea puede tener muchos vuelos.
##relación de uno a uno
## relación de muchos a muchos:  aeropuerto y aerolíneas, pero muchas convergen unicamente en un vuelo a la vez

################# mutating joing############
#¿como combinar un par de tablas a través de un mutating join?
#permite combinar variables de dos tablas
#1°buscar observaciones que coincidan por clave
#2°hacer copias de las variables de una tabla hacia la otra

#es similar la mutate que ya se conoce y se agraga la viariable a la derecha. 
#se debe utilizar el view para ver sus efectos porque no se ve por consola

flights_new <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)

flights_new

#left join permite ahorrar mucha programación del paquete base, simplifica la programación
flights_new %>% 
  left_join(airlines, by ="carrier")

#programación con el paquete base

flights_new %>% 
  mutate(name = airlines$name [match(carrier, airlines$carrier)])

x <- tribble(
  ~key, ~value_x,
     1, "x1",
     2, "x2",
     3, "x3",
)

y <- tribble(
  ~key, ~value_y,
  1, "y1",
  2, "y2",
  4, "y3",
)

#un join es una forma establecida de juntar filas de un primer y segundo dataset

##########################INNER JOIN####################
#SE ENCARGA DE BUSCAR COINCIDENCIAS EXACTAS DE LAS OBSERVACIONES A TRAVÉS DE LAS CLAVES,
#NO EXISTIRÍA UN INNER JÓIN SI NO HUBIERAN CLAVES REPETIDAS EN EL PRIMER Y SEGUNDO DATAFRAME
#se suele llamar un equijoin porque es un join de igualdades (solo selecciona los valores de claves repetidas)
#con dplyr podemos decirle con "by" para señalar la clave que se repite
#por lo tanto se tiene que tener cuidado porque se pierden los datos que no se repiten

x %>% 
  inner_join(y, by="key")
