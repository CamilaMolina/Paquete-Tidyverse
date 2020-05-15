#para manejar y dominar los datos es necesario utilizar el 
#paquet dplyr
#cargamos la libreria de tidyverse
library(tidyverse)
library(nycflights13)

nycflights13::flights
?flights
write_csv()#completar este código. poner el tibble en el archivo 

#para ver el tibble en R hacer la función view()
view(flights)

#hay dos complicaciones con dplyr que arroja la indicación de la consola
#la función filter() y lag().


#un tibble es un df mejorado para tidyverse
#sus tipos de datos básicos son
## * int -> números enteros
## * dbl -> números reales (double)
## * chr -> vector de caracteres o strings
## * dttm -> date + time
## * lgl -> logical, contiene valores booleanos (T o F)
## * fctr -> factor, variables categóricas
## * date -> fecha (día, mes y año)

####################dplyr tiene 5 funciones claves#################### 

## * filter () -> filtrar observaciones a partir de valores concretos
## * arrange() -> reordenar las filas
## * select() -> seleccionar variables con sus nombres
## * mutate() -> crear nuevas variables con funciones a partir de las existentes
## * sumarise() -> colapsa varios valores para dar un resumen de los mismos (media, rango, mediana, etc)
## * group_by() -> opera la función a la que acompaña grupo a grupo

## ARGUMENTOS##
## 1 - data frame 
## 2 - operaciones que queremos hacer a las variables del data frame
## 2 - resultado en un nuevo dataframe


######################## OPERACIÓN DE FILTER()#####################

# obtener todos los vuelos que salieron el 1 de enero
jan1 <- filter(flights, month == 1, day == 1)
view(jan1) #tambien puedes abrir el df creado en objetos y 
#aparece como pestaña arriba de la ventana de scripts
#aparece solo en la consola
filter(flights, month == 1, day== 1)

# vuelos en el día de mi cumpleaños
dic28 <- filter(flights, month == 12, day == 28)#resultado del data frame
#construido desde 0

# hay mas vuelos el 1 de enero o el 25 de diciembre
#verlo en consola y en objetos
(dic25 <- filter(flights, month == 12, day==25))
#se observa en ventana de global enviroment que
# el dic25 es de 7189 y en jan1 es de 842. 
#Por tanto, hay mas vuelos en jan1

#comparaciones: calculos numéricos aproximados
 2 == 2
sqrt(2)^2 == 2
near(sqrt(2)^2, 2)
1/pi * pi == 1
1/49 * 49 == 1
near(1/49 * 49, 1)

#combinar filtrados de forma correcta con operaciones booleanas

######################## álgebra booleana####################


#condiciones 1 y condición 2 AND OR
#Para otras operaciones se utilizan operaciones booleans
#operador ampersand: 
#$ -> and
#| -> or
#no -> !

#filtrar vuelos del mes 5 ó el mes 6
filter(flights, month == 5 | month == 6)
filter(flights, month == 5 |  6)# esto no funciona

#sintaxis heredada de magritte %in%
may_june <- filter(flights, month %in% c(5,6))#es el mismo resultado
#que el mismo filtrado de la linea 84
view(may_june)

#ley de morgan
#!(x&y) == (!x)|(!y) negar x y y es lo mismo que negar x o negar Y
#!(x|y) == (!x)&(!y) negar x o y es lo mismo que negar x y negar y

#ejercicio
#si quiero encontrat vuelo que no se retrasen con mas de una hora de retraso
filter(flights, !(arr_delay >60 | dep_delay > 60))
#con morgan es mas simple y es lo mismo
filter(flights, arr_delay <= 60, dep_delay <= 60)


############ ausencia de datos o NA (not available) CONTAGIOSO###########

#cualquier valor valor que involucre NA va a dar resultado NA
10==NA
  
NA>0
NA + 5
NA/5
NA == NA
#SI TENGO UNA BASE Y QUIERO SACAR UN PROMEDIO Y ENTRE LOS DATOS HAY
#UN NA (AUNQUE SEA UNO SOLO) EL RESULTADO PROMEDIO SERÁ NA
#POR ESO ES CONTAGIOSO Y COMPLICADO
#CUALQUIER OPERACIÓN QUE HAGA CON NA, DARÁ COMO RESULTADO UN NA

#EJEMPLO
#la tía mery tiene una edad desconocida.
age.mery <- NA
#tío john hace muchos años que no lo veo y no sé cuantos años tiene ahora
age.john <- NA
#deben tener la misma edad maery y john
age.mery == age.john

#PARA SOLUCIONAR ESTO usamo las función is.na() del paquete en base de stat
is.na(age.mery)#ahora devuelve TRUE y no NA
#otro ejemplo

df <- tibble(x = c(1,2,NA,4,5))
filter(df, x>2)#arroja 4 y 5 y no ha detectado el NA
filter(df, is.na(x) | x>2 )# si arroja el dato NA OJO CON ESTO

######################ORDENAR LAS FILAS CON ARRANGE########################################################################################

#para obserbar los primero datos del data set (6)


head(flights)

#si quiero observar mas de 6 puedo agregar el número que quiera
head(flights, 10)

#si quiero ver los últimos datos
tail(flights, 10)

#estos resulta interesante cuando tenemos los datos ordenados por algún parámetro en particular
#pero cuando esté desordeandos necesitaremos la función de arrange()

arrange(flights, year) #ordenar por año
arrange(flights, year, month, day)
sorted_date <- arrange(flights, year, month, day)
tail(sorted_date)# para ver los de diciembre


#ordenar de mayor a menor ocn función desc()
arrange(flights, desc(arr_delay))
#veamos los primeros 6 datos en orden descendente
head(arrange(flights, desc(arr_delay)))


#que pasa con los NA
arrange(df, desc(x))#los NA siempre quedan al final

#hacer un view de los carrier
view(arrange(flights, carrier))

#cual serían los vuelos que recorrieron menos
view(arrange(flights, distance))

#vuelo que mas distancia recorrió
view(arrange(flights, desc(distance)))



###################ejercicios######################



#los vuelos que LLEGARON mas de una hora tarde prevista
view(filter(flights, arr_delay >= 60))

#encuentre todos los vuelos que volarona a san francisco (aeropueros SFO Y OAK)
view(filter(flights, dest %in% c("SFO", "OAK")))


#encuentra todos los vuelos operados por por United American (UA) o por
#American Airlines
view(filter(flights, carrier %in% c("UA", "AA")))


#Encuentra todos los vuelos que salieron los meses de primavera
view(filter(flights, month %in% c(4,5,6)))

#encuentra vuelos que llegaron con mas de una hora tarde pero salieron 
#con menos un hora de retraso
view(filter(flights, arr_delay > 60, dep_delay <= 60))

#Encuentra todos los vuelos que salieron con más de una hora de 
#retraso pero consiguieron llegar 
#con menos de 30 minutos de retraso (el avión aceleró en el aire)

View(filter(flights, dep_delay >60, arr_delay <=30 ))

#Encuentra todos los vuelos que salen entre media noche y las 7 de la mañana (vuelos nocturnos)
filter(flights, hour >= 0, hour < 7)
filter(flights, between(hour, 0,6))#lo mismo con between()

#cuantos vuelos tienen un valor desconocido de dep_time?
filter(flights, is.na(dep_time))



filter(flights, arr_delay>=60 & dep_delay<60)





NA^0
NA|TRUE#true es un absorbente de la unión 
FALSE$NA#false es un absorvente de la interacción 



##################select()#######################

#solo ver la primera fila y todas las columnas
view(sorted_date[1,])
view(sorted_date[1:3,])
view(sorted_date[1024:1068, ])

View(select(sorted_date[1024:1068, ], dep_delay, arr_delay))

view(select(flights, year, month, day))

#de hasta donde
select(flights, dep_time:arr_delay)

#quiero todas las columnas menos año, mes y día
select(flights, -(year:day))

#seleccionar todas las columnas que comiencen con la palabra dep
select(flights, starts_with("dep"))

#seleccionar las columnas con las palabras que terminen con 
select(flights, ends_with("delay"))

#seleccionar todas las columnas que contengan una s
select(flights, contains("s"))

select(flights, contains("st"))

#expresiones regulares
select(flights, matches("(.)//1"))# seleccion de expresiones 
#con caracteres repetidos (2 mínimos)

select(flights, num_range("x", 1:5))#selecciona variables que contenga n y un número del 1 al 5
?select

############## renombrar variables con select ##################
rename(flights, deptime = dep_time)
rename(flights, deptime = dep_time, 
       año = year, mes = month, dia = day)

select(flights, deptime = dep_time)

#función helper de everything()
select(flights, time_hour, distance, air_time, everything())

####### EJERCICIOS#################
#1-Piensa cómo podrías usar la función arrange() 
#para colocar todos los valores NA al inicio. 
#Pisa: puedes la función is.na() en lugar de la función desc() como argumento de arrange.

arrange(flights, is.na (everything()))
#para ver donde ocurrió el error
rlang::last_error()
#para ver todo el contexto 
rlang::last_trace()


arrange(flights, !is.na(dep_time))
        
      


#2-Ordena los vuelos de flights para encontrar los vuelos más 
#retrasados en la salida. ¿Qué vuelos fueron los que 
#salieron los primeros antes de lo previsto?
view(flights)
#el mas retrasado fue
arrange(flights, desc(dep_delay ))[1,]
#el menos retrasado fue 
arrange(flights, dep_delay)[1,]

#Ordena los vuelos de flights para encontrar 
#los vuelos más rápidos. Usa el concepto de rapidez que consideres. 
view(arrange(flights, desc(distance/air_time)))

#¿Qué vuelos tienen los trayectos más largos? Busca 
#en Wikipedia qué dos aeropuertos del dataset alojan los 
#vuelos más largos. 

#Vuelos entre el JFK de Nueva York y el HNL, aeropuerto 
#internacional de Honolulu en Hawaii

#¿Qué vuelos tienen los trayectos más cortos? 
#Busca en Wikipedia qué dos aeropuertos del dataset 
#alojan los vuelos más largos. 

#Dale al coco para pensar cuantas más maneras posibles de 
#seleccionar los campos dep_time, dep_delay, arr_time y arr_delay 
#del dataset de flights. 


#Vuelos entre el EWR, Aeropuerto Internacional Libertad de Newark  
#y LGA, Aeropuerto de La Guardia, ambos situados en el estado 
#de Nueva York

select(flights,dep_time, dep_delay, arr_time, arr_delay)
select(flights,starts_with("dep"), starts_with("arr"))
select(flights,ends_with("time"), ends_with("delay") -starts_with("sched"),-starts_with("air") )

#¿Qué ocurre si pones el nombre de una misma variable varias 
#veces en una select()?
select(flights, distance, distance)

#Investiga el uso de la función one_of() de dplyr. 
arrange(flights, one_of(c("year", "month", "day", "dep_delay", "arr_delay")))
view(flights)

select(flights, contains("time"))

################ TRANSFORMACIONES DE VARIABLES #####################

########################## MUTATE #########################
#AÑADE NUEVAS COLUMNAS EN EL FINAL DEL DATASET
flightS_new <- select(flights, 
                      year : day,
                      ends_with ("delay"),
                      distance,
                      air_time)
view(flightS_new)
library(tidyverse)

### para ver la ganacia del tiempo 
view(mutate (flightS_new,
        time_gain = arr_delay - dep_delay, #diferencia de tiempo en minutos
        flight_speed = distance/(air_time/60) # v=s/T (km/h)
        ))
### ahora ver retraso por cada hora de vuelo
view (mutate (flightS_new,
        time_gain = arr_delay - dep_delay, #diferencia de tiempo en minutos
        air_time_hour = air_time/60,
        flight_speed = distance/air_time_hour,
        time_gain_per_hour= time_gain / air_time_hour))

#### si me quiero quedar con le nuevo dataset
### lo agrago al nuevo data set de esta manera
view (mutate (flightS_new,
              time_gain = arr_delay - dep_delay, #diferencia de tiempo en minutos
              air_time_hour = air_time/60,
              flight_speed = distance/air_time_hour,
              time_gain_per_hour= time_gain / air_time_hour)) -> flightS_new
### con transmutate también se puede hacer y lo dejamos en un pequeño y específico dataset
transmute (flightS_new,
        time_gain = arr_delay - dep_delay, #diferencia de tiempo en minutos
        air_time_hour = air_time/60,
        flight_speed = distance/air_time_hour,
        time_gain_per_hour= time_gain / air_time_hour) -> data_from_flightS
#para verlo en una nueva ventana
view(data_from_flightS)



############# resumen de las operaciones hasta el momento ########################


# *operaciones aritméticas: +, -, *, /, ^ (hours + 60 * minutes)
# * Agregados de funciones: x/sum (x) : proporción sobre le total
#                           x - mean(x): distancia respecto a la media
#                           (x - mean(x))/sd(x): tipificación
#                           (x - min(x))/(max(x) - min(x)): estandarizar entre [0,1]
# * Aritmética modular:     %/% -> cociente de la división entera, %% -> resto de la división entera
#                            x == y * (x%/%y) + (x%%Y) #algoritmo de euclídes

transmute(flights,
          air_time,
          hour_air = air_time %/% 60,
          minite_air = air_time %% 60)

# * Logaritmis: log() -> logaritmo en base e, log2(), log10()
# * Offsets: lead(), lag() se usan con la función group_by o sola
# el mas fácil de interpretar es el logaritmo en base 2 porque una diferencia de 1 del logaritmo corresponde
# siempre al doble. Y una diferencia de -1 en el logaritmo corresponde siempre a la mitad
df <- 1:12
df
lag(df)#mueve hacia la derecha
lag(lag(df))
lead(df)#mueve hacia la izquierda

# * Funciones acumulativas: del paquete stats y dlyr: cumsum(), cumprod(), cumin(), cummean()#Este último del paquete dplyr
cumsum(df)
cumprod(df)
cummin(df)
cummax(df)
cummean(df)

# * comparaciones lógicas: >, >=, <, <=, ==, !=
transmute(flightS, 
          dep_delay,
          has_been_delayed = (dep_delay >0))

tidyverse::flights

# * Rakings:min_rank()
df <- c(7,1,2,5,3,3,8,NA,3,4,-2)
df
min_rank(df)
min_rank(desc(df))

# * row_ number
row_number(df)
df
dense_rank(df)

percent_rank(df)

cume_dist(df) #porcentaje rank acumulado
ntile(df, n=4) #ordena por percentiles del paquete dplyr en este caso 4

transmute(flights,
          dep_delay,
          ntile(dep_delay, n=100)) #del primer al 100 cuantil

############### ejercicios ###############################################
library(tidyverse)
view(flights)
#El dataset de vuelos tiene dos variables, dep_time y sched_dep_time 
#muy útiles pero difíciles de usar por cómo vienen dadas al no ser variables 
#contínuas. Fíjate que cuando pone 559, se refiere a que el vuelo salió a las 
#5:59... 

#Convierte este dato en otro más útil que represente el número de minutos 
#que horas desde media noche. 

view(transmute(flights,
           dep_time, sched_dep_time,
           new_dep_time = 60*dep_time %/% + dep_time %% 100,
           new_sched_dep_time = 60*sched_dep_time %/% 100 + sched_dep_time %% 100))

mutate(flights,
       
       dep_time = 60 * floor(dep_time/100) + (dep_time - floor(dep_time/100) * 100),
       
       sched_dep_time  = 60 * floor(sched_dep_time /100) + (sched_dep_time  - floor(sched_dep_time /100)*100))



#Compara las variables air_time contra arr_time - dep_time. 

#¿Qué esperas ver?
  #¿Qué ves realmente?
  #¿Se te ocurre algo para mejorarlo y corregirlo?


transmute(flights,
          air_time,
          new_dep_time = 60*dep_time %/% 100 + dep_time %% 100,
          new_arr_time = 60*arr_time %/% 100 + arr_time %% 100,
          new_air_time = new_arr_time - new_dep_time)


Air time y el resultado de la resta deben ser iguales.

diff_Dep_Arr_time <- transmute(flights,
                               
                               (arr_time  = 60 * floor(arr_time /100) + (arr_time  - floor(arr_time /100)*100)) -
                                 
                                 (dep_time = 60 * floor(dep_time/100) + (dep_time - floor(dep_time/100) * 100))
                               
)

select(flights,
       
       air_time)



Deberia incluir atrasos y adelantos.

flights %>%
  
  mutate(dep_time = (dep_time %/% 100) * 60 + (dep_time %% 100),
         
         sched_dep_time = (sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100),
         
         arr_time = (arr_time %/% 100) * 60 + (arr_time %% 100),
         
         sched_arr_time = (sched_arr_time %/% 100) * 60 + (sched_arr_time %% 100)) %>%
  
  transmute((arr_time - dep_time) %% (60*24) - air_time)

  #Compara los valores de dep_time, sched_dep_time y dep_delay. Cómo deberían 
#relacionarse estos tres números? Compruébalo y haz las correcciones numéricas 
#que necesitas.

transmute (flights,
           new_dep_time = 60*dep_time %/% 100 + dep_time %% 100,
           new_sched_dep_time = 60*sched_dep_time %/% 100 + sched_dep_time %% 100,
           new_delay = new_dep_time - new_sched_dep_time,
           dep_delay,
           new_delay == dep_delay)

time2mins <- function(x) {
  
  (x%%100 * 60 + x %% 100) %% 1440 #%% es para obtener el residuo
  
}



flights_time <- mutate(flights,
                       
                       dep_time_mins = time2mins(dep_time),
                       
                       sched_dep_time_mins = time2mins(sched_dep_time)
                       
)



#Air time debe ser la diferencia de las salidas (arr_time) con las llegadas (dep_time)

#Transformamos los datos a una base arimetica

#Usa una de las funciones de ranking para quedarte con los 10 vuelos más 
#retrasados de todos. 
arrange(mutate(flights,
               r_delay = min_rank(dep_delay)),
        r_delay
        )[1:10]

flights_delayed <- mutate(flights,
                          
                          dep_delay_min_rank = min_rank(desc(dep_delay))
                          
)



flights_delayed <- filter(flights_delayed,
                          
                          !(dep_delay_min_rank > 10)
                          
)



flights_delayed <- arrange(flights_delayed, dep_delay_min_rank)


#Aunque la ejecución te de una advertencia, qué resultado te da la operación

#1:6 + 1:20

1:6 + 1:20

#Además de todas las funciones que hemos dicho, las trigonométricas también 
#son funciones vectoriales que podemos usar para hacer transformaciones con mutate. Investiga cuales trae R y cual es la sintaxis de cada una de ellas.

?floor

cos(x)

sin(x)

tan(x)



acos(x)

asin(x)

atan(x)

atan2(y, x)



cospi(x)

sinpi(x)

tanpi(x)



################# summarise #############################

summarise(flights, delay = mean (dep_delay, na.rm =T )) #para eliminar los na

by_month_group <- group_by (flights, year, month)
summarise(by_month_group, delay = mean (dep_delay, na.rm = T))

by_day_group <- group_by(flights, year, month, day)
summarise(by_day_group, delay = mean(dep_delay, na.rm = T))

by_day_group <- group_by(flights, year, month, day)
summarise(by_day_group, 
          delay = mean(dep_delay, na.rm = T),
          median = median (dep_delay, na.rm = T),
          min = min(dep_delay, na.rm = T)
          )
summarise(group_by(flights, carrier),
          delay = mean(dep_delay, na.rm = T))


transmute(summarise(group_by(flights, carrier),#mutate no pierde los datos originales ya transformados
          delay = mean(dep_delay, na.rm = T)),
          sorted = min_rank (delay)
          )
mutate(summarise(group_by(flights, carrier),#mutate no pierde los datos originales ya transformados
                  delay = mean(dep_delay, na.rm = T)),
        sorted = min_rank (delay)
      )         
 #siempre que usemos estadísticos utilizar la sintaxis na.rm = T
#donde rm significa remove


################ PIPES #################################################

group_by_dest <- group_by(flights, dest)
delay <- summarise(group_by_dest,
                   count= n(), #para contar la cantidad de observaciones en la variable
                   dist= mean(distance, na.rm = T),
                   delay = mean (arr_delay, na.rm = T)
                   )
view(delay)

delay <- filter(delay, count >100, dest != "HNL")

ggplot(data=delay, mapping= aes(x=dist, y=delay)) +
  geom_point(aes(size = count), alpha =0.2) +
  geom_smooth()+
  geom_label(aes(label = dest))

ggplot(data=delay, mapping= aes(x=dist, y=delay)) +
  geom_point(aes(size = count), alpha =0.2) +
  geom_smooth()+
  geom_text(aes(label = dest))

ggplot(data=delay, mapping= aes(x=dist, y=delay)) +
  geom_point(aes(size = count), alpha =0.2) +
  geom_smooth(se = F)+
  geom_text(aes(label = dest), alpha = 0.3)

delay <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist= mean (distance, na.rm = T),
    delay = mean (arr_delay, na.rm = T)
  ) %>% 
  fiter (count >100, dest!="HML")

# x %>%  f(y) <-> f(x,y)
# x %>% f(y) %>%  g(z) <-> g(f(x,y), z)
# x %>% f(y) %>%  g(z) %>% h(t) <-> h(f(x,y),g(z), y)

#ggvis <-> ggplot2


#################### NA ############################

flights %>% 
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay),
            median = median (dep_delay)
            )

#si la entrada tiene un NA su resultado tendrá un NA. esto se aplica 
# para estadísticos... solo no tiene NA los conteos

flights %>% 
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay),
            median = median (dep_delay),
            sd= sd(dep_delay),
            count = n()
  )

# entonces hay que eliminar los NA de con comando na.rm T

flights %>% 
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay, na.rm = T),
            median = median (dep_delay, na.rm = T),
            sd= sd(dep_delay, na.rm = T),
            count = n()
  )

# cuando tiene el NA un significado particular. En este caso los NA 
#aquí significa vuelo cancelado

not_cancelled <-  flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))
  
not_cancelled %>% 
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay, na.rm = T),
            median = median (dep_delay, na.rm = T),
            sd= sd(dep_delay, na.rm = T),
            count = n()
  ) 

flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay)) %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay, na.rm = T),
            median = median (dep_delay, na.rm = T),
            sd= sd(dep_delay, na.rm = T),
            count = n()
  ) 

flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay)) %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay),
            median = median (dep_delay),
            sd= sd(dep_delay),
            count = n()
  ) 

############# contar y visualizar resúmenes correctamente #################

delay_tailnum <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(delay = mean(arr_delay))

ggplot(data=delay_tailnum, mapping = aes(x=delay)) +
  geom_freqpoly(binwidth = 5) #binwidth es el ancho del conteo.
#para datos continuos es menjor el polígono de frecuencia

ggplot(data=delay_tailnum, mapping = aes(x=delay)) +
  geom_histogram(binwidth = 5)

delay_tailnum <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(delay = mean(arr_delay),
            count = n()
            )

ggplot(data=delay_tailnum, mapping = aes(x=count, y= delay)) +
  geom_point(alpha = 0.2)

delay_tailnum %>% 
  filter (count >30) %>% 
  ggplot(mapping = aes (x=count, y=delay)) +
  geom_point (alpha = 0.2)

#ahorro de tiempo con ctrl + shift + p <- esto es para cambiar 
#solo los valores y correr el último script completo en esta misma ventana.


################ El Ejemplo del baseball####################################
install.packages("Lahman")
view(Lahman::Batting)
?Lahman::Batting
batting <- as_tibble(Lahman::Batting)#para transformar una base a tibble

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise (hits = sum(H, na.rm = T),#sum = para sacar sumatoria total
            bats = sum (AB, na.rm = T),
            bat.average = hits / bats
  )

batters %>% 
  filter (bats >50) %>% 
  ggplot ( mapping = aes (x=bats, y = bat.average))+
    geom_point(alpha = 0.2) +
    geom_smooth(se = F)

batters %>% 
  arrange (desc(bat.average))

batters %>% 
  filter(bats > 100) %>% 
  arrange (desc(bat.average))


########### Funciones estadísticas útiles #############################

# .* Medidas de centralización
#SUMMARISE
not_cancelled %>% 
  group_by(carrier) %>% 
  summarise(
    mean =mean(arr_delay),
    mean2 = mean (arr_delay[arr_delay>0]),
    median = median(arr_delay)
  )

#.* Medidas de dispersión   

# desvaición standard media: medida standard (del error)de la dispersión de los datos

# rango intercuartílico: desvaición absoluta de la mediana. Es la distancia entre el percentiil número 25 
#y el número 75, por lo tanto agrupa el 50% de los valores

#la función mat: equivalente bastante robusto s y útil si tenemos outliers por allí en medio


not_cancelled %>% 
  group_by(carrier) %>% 
  summarise(
    sd = sd(arr_delay),
    iqr = IQR(arr_delay),
    mad = mad (arr_delay),
    
  ) %>% 
  arrange (desc(sd))

?mad #desvaición absoluta respecto de la mediana

# * Medidas de orden 

#Cuantiles para obtener diferentes valores.
#El cuantil es la generalización de la mediana. 
#El cuantil de orden 0.5 es la mediana.

#Cuantil 0.25, busca los valores que son mas grandes que el 25 % de los datos
#Por tanto, queda mas del 75% del dato por encima

#Cuantil 0.75 busca valores que son mas grandes que el 75% dejando 
#el 25 % de los valores por arriba 


not_cancelled %>% 
  group_by(carrier) %>%
  summarise(
    first = min (arr_delay),
    q1 = quantile(arr_delay, 0.25),
    median = quantile(arr_delay, 0.5), ##median()
    q3 = quantile(arr_delay, 0.75),
    last = max(arr_delay)
    )

# * Medidas de posición 
not_cancelled %>% 
  group_by(carrier) %>% 
  summarise(
    first_dep = first(dep_time),
    second_dep= nth(dep_time, 2),
    third_dep = nth(dep_time, 3),
    last_dep = last (dep_time)
  )


not_cancelled %>% 
  group_by(carrier) %>% 
  mutate(rank = min_rank(desc(dep_time))) %>% 
  filter(rank%in% range (rank))


not_cancelled %>% 
  group_by(carrier) %>% 
  mutate(rank = min_rank(dep_time)) %>% 
  filter(rank%in% range (rank)) -> temp

view(temp)

# Funciones de Conteo

flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    carriers = n_distinct(carrier),
    arrivals = sum(!is.na(arr_delay))
  ) %>% 
  arrange(desc(carriers))

not_cancelled %>% count(dest)

not_cancelled %>% count(tailnum, wt=distance)

#proporciones: cuantos n cumplen una determinada condición

##sum /mean de valores lógicos
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_prior_5 = sum(dep_time < 500))

not_cancelled %>% 
  group_by(carrier) %>% 
  summarise(more_than_hour_delay = mean(arr_delay>60)) %>% 
  arrange(desc(more_than_hour_delay))



############## Agrupaciones Multiples y Desagrupaciones##########################

# número de vuelos por día
daily <- group_by(flights, year, month, day)
(per_day <- summarise(daily, n_fl =n()))
(per_month <- summarise(per_day, n_fl = sum(n_fl)))
(per_year <- summarise(per_month, n_fl =sum(n_fl)))

business <- group_by(flights, carrier, dest, origin)
summarise(business, n_fl = n()) %>% 
  summarise(n_fl = sum (n_fl)) %>% 
  summarise(n_fl = sum(n_fl))

daily %>% 
  ungroup() %>% 
  summarise(n_fl = n())

business %>% 
  ungroup() %>% 
  summarise(n_fl = n())


#################### MUTATES Y FILTERS POR SEGMENTO ###############


#cuales son los peores, mas retrasados
flights %>% 
  group_by(year, month, day) %>% 
  filter(rank(desc(arr_delay))<10) -> temp
view(temp)
 # cuales son los destinos mas populares
popular_dest <- flights %>% 
  group_by(dest) %>% 
  filter(n()>365)

view(popular_dest)

popular_dest %>% 
  filter(arr_delay >0) %>% 
  mutate(prop_delay= arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)

#esto funciona mejor sobre agrupaciones previas.
#es mejor con group_by con summarise función.

#################### WHEN_CASE ########################
nombres %>% 
  filter(nombre=="Sara" | nombre=="Sarah") %>% 
  group_by(anio) %>% 
  summarise(total_saras = sum(n),
            prop_saras  = sum(prop)) %>% 
  mutate(boom = case_when(prop_saras <= 0.012 ~ "No Boom",
                          prop_saras > 0.012 ~ "Sara Boom")) 

####################### EJERCICIOS############################
#Preguntas de esta tarea
#Intenta describir con frases entendibles el conjunto de vuelos 
#retrasados. Intenta dar afirmaciones como por ejemplo:
  
  #- Un vuelo tiende a salir unos 20 minutos antes el 50% 
#de las veces y a salir tarde el 50% de las veces restantes.

#- Los vuelos de la compañía XX llegan siempre 20 minutos tarde

#- El 95% de los vuelos a HNL llegan a tiempo, pero el 5% 
#restante se retrasan más de 3 horas.

#Intenta dar por lo menos 5 afirmaciones verídicas en base a los 
#datos que tenemos disponibles.

#Da una versión equivalente a las pipes siguientes sin usar la 
#función count:
  
  #not_cancelled %>% count(dest)

#not_cancelled %>% count(tailnum, wt = distance)

#Para definir un vuelo cancelado hemos usado la función

#(is.na(dep_delay) | is.na(arr_delay))

#Intenta dar una definición que sea mejor, ya que la nuestra 
#es un poco subóptima. ¿Cuál es la columna más importante?
  
  #Investiga si existe algún patrón del número de vuelos que se #
#cancelan cada día.

#Investiga si la proporción de vuelos cancelados está relacionada 
#con el retraso promedio por día en los vuelos.

#Investiga si la proporción de vuelos cancelados está relacionada 
#con el retraso promedio por aeropuerto en los vuelos.

#¿Qué compañía aérea sufre los peores retrasos?
  
  #Difícil: Intenta desentrañar los efectos que producen los 
#retrasos por culpa de malos aeropuertos vs malas compañías aéreas.
#Por ejemplo, intenta usar 

#flights %>% group_by(carrier, dest) %>% summarise(n())

#¿Qué hace el parámetro sort como argumento de count()? 
#¿Cuando puede sernos útil?
  
  #Vuelve a la lista de funciones útiles para filtrar y mutar y 
#describe cómo cada operación cambia cuando la juntamos con 
#un group_by.

#Vamos a por los peores aviones. Investiga el top 10 de qué 
#aviones (número de cola y compañía) llegaron más tarde a su destino.

#Queremos saber qué hora del día nos conviene volar si queremos 
#evitar los retrasos en la salida.

#Difícil: Queremos saber qué día de la seman nos conviene volar 
#si queremos evitar los retrasos en la salida.



#Para cada destino, calcula el total de minutos de retraso 
#acumulado.

#Para cada uno de ellos, calcula la proporción del total de retraso 
#para dicho destino.

#Los retrasos suelen estar correlacionados con el tiempo. 
#Aunque el problema que ha causado el primer retraso de un avión 
#se resuelva, el resto de vuelos se retrasan para que salgan 
#primero los aviones que debían haber partido antes. 
#Intenta usar la función lag() explora cómo el retraso de un avión 
#se relaciona con el retraso del avión inmediatamente anterior o 
#posterior.

#Vamos a por los destinos esta vez. Localiza vuelos que llegaron 
#demasiado rápido' a sus destinos. Seguramente, 
#el becario se equivocó al introducir el tiempo de vuelo y se +
#trate de un error en los datos. Calcula para ello el cociente 
#entre el tiempo en el aire de cada vuelo relativo al tiempo de 
#vuelo del avión que tardó menos en llegar a dicho destino. 
#¿Qué vuelos fueron los que más se retrasaron en el aire?
  
  #Encuentra todos los destinos a los que vuelan dos o más 
#compañías y para cada uno de ellos, crea un ranking de las 
#mejores compañías para volar a cada destino (utiliza el 
#criterio que consideres más conveniente como probabilidad de 
#retraso, velocidad o tiempo de vuelo, número de vuelos al año..)

#Finalmente, para cada avión (basándonos en el número de cola) 
#cuenta el número de vuelos que hace antes de sufrir su primer 
#retraso de más de una hora. Valora entonces la fiabilidad del 
#avión o de la compañía aérea asociada al mismo.

##################### ANÁLISIS EXPLORATORIO DE LOS DATOS #############
#David Cox. no hay preguntas rutinarias en estadística, sino preguntas 
#acerca de las rutinas estadísticas. 
#un estadístico nunca repite su trabajo dos días o dos veces, ¿las rutinas estadísticas
#funcionan o no?

#Analisis eploratorio contiene 3 etapas
#1.-modelar
#2.-representación gráfica
#3.-manejo de datos (transformar los datos)
#Para generar calidad en las preguntas, generar preguntas de calidad en un inicio
#es muy difícil. A medida que se va investigando se va revelando con 
#los datos.

#Preguntas útiles en análisis exploratorio
#1.- Que tipo de variación sufren las variables o los datos
#2.- Que tipo de covariación sufren las covariables

#¿Como varian los datos, son todas constante, cambian mucho o poco?




