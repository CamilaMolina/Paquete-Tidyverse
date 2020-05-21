################ bases de datos relacionales#############
library(tidyverse)
install.packages ("nycflights13")
nycflights13
airlines
airports

planes
weather
nycflights13::flights
#se debe observar las variables entre las distintas bases
#lo primero que se debe detectar las claves primarias y for?neas
#clave: variable o conjunto de variables que de forma un?voca identifica la observaci?n.
#una sola variable identifica una sola observaci?n. otra variable necesitar? mas de una variable para identiicar

#clave primaria: identifica de forma un?voca una observaci?n de su propia tabla.
#por ejemplo: tailnum (n?mero de cola), es la clave primaria de aviones 
#porque identifica de forma un?voca el avi?n.El carrier con las aerol?neas, el aeropuerto con el faa
#que identifica en forma un?voca dicho aeropuerto.NO existen dos aeropuertos con el mismo identificador.

#clave for?nea:identifica unicamente la observaci?n en otra tabla. 
#Ej: en la tabla vuelos, el n?mero de cola (tailnum) no identifica al vuelo, PERO 
#identifica al avi?n. por lo tanto, flisghts tailnum es la clave for?nea porque aparece 
#en la tabla de vuelos y coincide con el ?nico avi?n existente de la tabla de aviones.
#Otro ej: origin es clave primaria de weather y clave for?nea de flights.

#lo mas importante es identificar las claves primarias
#se pude utilizar la funci?n count para ver que tienen una sola observaci?n

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
#una relaci?n: es una relaci?n de uno a uno o uno a muchos 
#ej: cada vuelo tiene un solo avi?n, pero cada avi?n tiene muchos vuelos.
## relaci?n de uno a muchos: cada vuelo tiene una sola compa??a a?rea, pero cada compa??a ?erea puede tener muchos vuelos.
##relaci?n de uno a uno
## relaci?n de muchos a muchos:  aeropuerto y aerol?neas, pero muchas convergen unicamente en un vuelo a la vez

################# mutating joing############
#?como combinar un par de tablas a trav?s de un mutating join?
#permite combinar variables de dos tablas
#1?buscar observaciones que coincidan por clave
#2?hacer copias de las variables de una tabla hacia la otra

#es similar la mutate que ya se conoce y se agraga la viariable a la derecha. 
#se debe utilizar el view para ver sus efectos porque no se ve por consola

flights_new <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)

flights_new

#left join permite ahorrar mucha programaci?n del paquete base, simplifica la programaci?n
flights_new %>% 
  left_join(airlines, by ="carrier")

#programaci?n con el paquete base

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
#SE ENCARGA DE BUSCAR COINCIDENCIAS EXACTAS DE LAS OBSERVACIONES A TRAV?S DE LAS CLAVES,
#NO EXISTIR?A UN INNER J?IN SI NO HUBIERAN CLAVES REPETIDAS EN EL PRIMER Y SEGUNDO DATAFRAME
#se suele llamar un equijoin porque es un join de igualdades (solo selecciona los valores de claves repetidas)
#con dplyr podemos decirle con "by" para se?alar la clave que se repite
#por lo tanto se tiene que tener cuidado porque se pierden los datos que no se repiten

x %>% 
  inner_join(y, by="key")

##################outer_join################################
#el outer join sobrepasa el problema de los datos no repetidos
#con tres tipos:

# * left join: se queda con todas las observaciones que aparecen en el primer dataset
#independientemente si aparecen o no en el segundo. 

# * right join: se queda con todas las observaciones que aparecen en el segundo dataset
#independientemente si aparecen o no en el primero. 

# * full join: que se queda con las observaciones tanto del primero como del segundo dataset

x %>% left_join(y, by="key")
x %>% right_join(y, by="key")
x %>% full_join(y, by="key")

############problemas de las claves duplicadas#############
#claves duplicadas en una tabla y la otra no
#un mismo avión vuela dos veces un mismo día.
x <- tribble(
  ~key, ~value_x,
     1, "X1",
     2, "X2",
     2, "x3",
     1, "x4",
)

y <- tribble(
  ~key, ~value_y,
     1, "y1",
     2, "y2",
)

x %>% left_join(y, by="key")

#claves duplicadas en las dos tablas. Normalmente no debería pasar 
#porque significa un error. Pero, aún puede pasar.

x <- tribble(
  ~key, ~value_x,
  1, "x1",
  2, "x2",
  2, "x3",
  3, "x4",
)

y <- tribble(
  ~key, ~value_y,
  1, "y1",
  2, "y2",
  2, "y3",
  3, "y4",
)

left_join(x,y, by="key")# producto cartesiano se une todo con todo

#################### definir las columnas claves de los join##########
#cuando tenemos los mimso nombre de varibles en diferentes tablas
#las ocupamos como claves.
#NATURAL JOIN (SE UNEN TODAS LAS COLUMNAS CON EL MISMO NOMBRE)

flights_new

flights_new %>% left_join(weather)

#esto naturalemente une las mismas columnas con el mismo nombre, 
#pero puede dejar informacion fuera de una de las columnas repetidas
#para evitar eso agregamos la siguiente funcion 

flights_new %>% left_join(weather)

flights_new

planes

?airports

flights_new %>% left_join(planes, by = 'tailnum')#especificar el no mbre igual de una variable

#especificar un vector entero de variables
#misma variable pero con distinto nombre en el data set
airports
flights_new %>% left_join (airports, by = c("dest" = "faa"))
flights_new %>% left_join (airports, by = c("origin" = "faa"))

#################funciones para SQL MERGE#####################

#Funcion merge
?base::merge
#    dplyr           <->        base
#inner_join (x, y)   <-> merge (x, y)
#left_join  (x, y)   <-> merge (x, y, all.x = TRUE)
#right_join (x, y)   <-> merge (x, y, all.y = TRUE)
#full_join  (x, y)   <-> merge (z, y, all.x = TRUE, all.y = TRUE)

#    dplyr                   <->            SQL
#inner_join (x, y, by ="z")  <-> SELECT * FROM x [INNER] JOIN y USING (z)
#                                SELECT * FROM x [INNER] JOIN y ON x.key = y.key
#left_join  (x, y) by ="z")  <-> SELECT * FROM x LEFT [OUTER] JOIN y USING (z)
#                                SELECT * FROM x LEFT [OUTER] JOIN y ON x.key = y.key
#right_join (x, y) by ="z")  <-> SELECT * FROM x RIGHT [OUTER] JOIN y USING (z)
#                                SELECT * FROM x RIGHT [OUTER] JOIN y ON x.key = y.key
#full_join  (x, y) by ="z")  <-> SELECT * FROM x FULL [OUTER] JOIN y USING (z)
#                                SELECT * FROM x FULL [OUTER] JOIN y ON x.key = y.key

################ FILTERING JOIN###############

# semi_join(x,y) -> se queda con las observaciones de x que tienen correspondencia en Y
# anti_join(x,y) -> elimina todas las observaciones de x que tienen correspondencia en Y

#obtener el top ten de los destinos mas visitados

flights %>% 
  count(dest, sort=TRUE) %>% 
  head(10)

#para cada vuelo cuales de ellos fueron a uno o mas de estos destinosflights %>% 
flights %>% 
  count(dest, sort=TRUE) %>% 
  head(10) -> top_dest

flights %>%
  filter(dest %in% top_dest$dest)

#imaginar que hemos encontrado se eleva el promedio del retraso
# como construir un filtro para encontrar los vuelos que se han retrasado
#podemos ocupar un semi_join

flights %>% semi_join(top_dest)

#cuantos de los vuelos de aeropuerto de EEUU no tienen ninguno de los aviones que estan en la lista de aviones
#con anti_join de dplr

flights %>% anti_join(planes, by ="tailnum") %>% 
  count (tailnum, sort = TRUE)

################## OPERACIONES ENTRE CONJUNTOS #######################

# * intersect (x,y): observaciones comunes entre x e y (x intersección y)(deben ser iguales iguales)
# * union     (x,y): observaciones únicas en x e y     (x unión y)
# * setdiff   (x,y): observaciones en x pero no en y   (x - y= x intersección y)

x <-  tribble(
  ~a, ~b,
   1, 1,
   2, 1,
)

y <- tribble(
  ~a, ~b,
   1,  1,
   1,  2,
)

intersect(x, y)
union(x,y)
setdiff(x,y)
setdiff(y, x)




