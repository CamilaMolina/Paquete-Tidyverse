############### DATA WRANLING ###########

# * IMPORTACIÓN
# * LIMPIEZA
# * TRANSFORMACIÓN DEL DATO

############ Las Tibbles ############
vignette("tibble")#para leer un documento sobre...

library(tidyverse)

view(iris)

class(iris)#es un data.frame

#transformar el data.frame en tibble

iris_tibble <- as_tibble(iris)
class(iris_tibble)

#crear un tibble
t <- tibble(
  x = 1:10,
  y = pi,
  z = y * x ^ 2
)
t
t$z
t$y

#nombres no sintacticos de un variables:backsticks
t2 <- tibble(
  ':)'  = "smile",
  ' '   = "space",
  '1998'= "number"
  )
tribble(
  ~x, ~y, ~z,
#|---|---|------|
  "a", 4, 3.14,
  "a", 8, 6.28,
  "c", 9, -1.25
)

#cual es la diferencia entre data frame y tibbles

lubridate::now()
lubridate::today()

tibble(
  a = lubridate::now() + runif(1e3)*24*60*60,
  b = 1:1e3, 
  c = lubridate::today() + runif(1e3)*30,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = T)
)

#para visualizar mas de lo que sale por defecto
library(nycflights13)
nycflights13::flights %>% 
  print(n =12, width = Inf)

#para ver parametros configurados por R
options()

options(tibble.print.max = 12, tibble.print_min = 12)
options(dplyr.print_min = Inf)
options(tibble.width = Inf)

#para saber de que se trata un paquete
package?tibble

view(flights)

########### SUBCONJUNOS Y ACCESO A TIBBLES#############

#[['nombre_variable']]
#[['posicion_variable']]
#$nombre_variable

df <- tibble(
  x= rnorm(10),
  y= runif(10)
)
df$y
df$x

df %>% .$x
df %>% .$y

df %>% .[["x"]]

df[["x"]]
df[["y"]]

df[[1]]
df[[2]]

#funciones que no funcionarán con las tibbles
df
as.data.frame(df)

#el doble corchete hace los mismo que dplyr::filer()
#el doble corchete hace los mismo que dplyr::select()

#"[[]]" devuelve siempre tibbles

##################IMPORTACIÓN DE LOS DATOS###########

# * read_csv() lee ficheros separados por coma ','
# * read_csv2() lee ficheros separados por punto y coma ';''
# * read_tsv() lee ficheros separaso por tabulador '\t'
# * read_delim() lee ficheros separados por lo que nosotros le digamos

# * read_fwf() ficheros de anchura fija
  # * fwf_widths()
  # * fwf_positions()
# * read_table()

# * read_log() ficheros de un server creados por apache
   # * install.packages("webreadr")

write.csv(mtcars, "data/cars.csv")

cars <- read.csv("data/cars.csv")
cars %>% view()

read_csv("x,y,z
         1,2,3.5
         4,5,6
         7,8,9")

#cuando la primera de fila es un metadato (no la cabecera:descripción de las columnas)

read.csv(" este es una primera fila de ejemplo
         que ocupa fils para que no comienzan con cabecero
         y solo es para rellenar
         x,y,z
         1,2,3
         4,5,6
         7,8,9", skip = 3) # el 3 son las 3 filas ocupadas

#cuando los  metadatos o coementarios incluya hashtag
read.csv("#Esto es un comentario
         1,2,3
         4,5,6, comment = "#")se salta el simbolo y no forma parte del iris_tibble
         
#Saltos de línea en R con \n
         
read_csv("1,2,3\n4,5,6\n7,8,9", col_names = FALSE)

read_csv("1,2,3\n4,5,6\n7,8,9", col_names = c("primena", "segunda", "tercera"))         

############################los NA en el readr##############

read_csv("x,y,z\n1,2,.\4,#,6", na= c(".", "#"))

################ paquete base v/s readr########################

#el paquete readr es mucho mas rápido que el paquete base
#readr está una capa mas arriba por el sistema operativo del computaodor
#o los paquetes bases del mismo R


######################### PARSE #################
#ES UNA FUNCIÓN QUE TOMA UN VECTOR DE CARACTERES y nos devuelve un vector específicos
parse_logical(c("TRue", "FALSE", "FALSE", "NA"))

str(parse_logical(c("TRUE", "FALSE", "FALSE", "NA")))
str(parse_integer(c("1", "2", "3", "4")))
str(parse_date(c("1988-05-19", "2018-05-30")))

parse_integer(c("1", "2", "#", "5", "729"), na ="#")

data <- parse_integer(c("1", "2", "hola", "5", "234", "3.141592"))
problems(data)

#existen 8 tipos de parse que procesan los 8 tipos de datos
#parse_logical()
#parse_integer()

#parse_double() procesa estrictamente valores numéricos
#parse_number() es mas flexible es mas genéricos puede procesar numerso escritos 
#en diferentes normas ej: 1000 = 1e3
    #decimales

parse_double("12.345")

parse_double("12,345", locale = locale(decimal_mark = ","))

     #monetarios
     #porcentajes
parse_number("100€")

parse_number("$1000")
parse_number("12%")
parse_number("el vestido ha costado 12.45€")
     #agrupaciones 1,000,000
parse_number("$1,000,000")
parse_number("1.000.000", locale = locale(grouping_mark = "."))
parse_number("123'456'789", locale = locale(grouping_mark = "'"))


#parse_character() para procesar caracteres que trabajan con el encoding ej UTF8, diferentes alfabetos
charToRaw("Juan Gabriel") #cada uno de los caracteres se llama byte
#ASCII caracteres con simbolos de alfabeto distinto
#las dos codificaciones clásicas:
#Latin1 (ISO-8859-1) para idiomas de Europa del Oeste
#Latin2 (ISO-8859-2) para idiomas del Europa del este

#UTF-8 el que usa readr

x1 <- "El Ni\xf1o ha estado enfermo"

x2 <- "\x82\xb1\x82\xf1\x82\xb2\x82\xcd"

parse_character(x1, locale = locale(encoding = "Latin1")))

parse_character(x2, locale = locale(encoding = "Shift-JIS"))

#como encuentro el encoding correcto

guess_encoding(charToRaw(x1)) #también puede ser una ruta

guess_encoding(charToRaw(x2))

###################parse_factor()############################# 
#analizar varables categóricas con valores fijos (colores) o conocidos

      #la condición es que los factores deben ser conocidos
months <- c("Jan", "Feb", "Mar", 
            "Apr", "May", "Jun", "Jul", 
            "Aug", "sep", "Oct", "Nov", "Dec")
parse_factor(c("May", "Apr", "Jul", "Aug", "Sec", "Nob"), levels = months)

####################Procesado de fechas##################

#EPOCH -> 1970-01-01 00:00 dia 0 de la informática

#parse_datetime() ISO-8601 standard de fechas van de mayor a menor, año,mes,dia, hora, minuto, segundo
parse_datetime("2018-06-05T1845")
parse_datetime("20180605")
#parse_date()
parse_date("2015-12-07")
parse_date("2015/12/07")
#parse_time()
parse_time("03:00pm")
parse_time("20:00:34")

#Años
# %Y -> año con 4 dígitos
# %y -> año con 2 dígitos (00-69)-> 2000-2069, (70-99) -> 1970-1999

#meses
# %m -> mes en formato de dos dígitos 01-12
# %b -> abreviación del mes 'Ene', 'Feb', ...
# %B -> nombre completo del mes 'Enero', 'Febrero', ...

#Día

# %d -> número del día con dos dígitos
# %e -> de forma opcional, los dígitos 1-9 pueden llevar espacio en blanco

#HOras
# %H -> hora entre 0-23
# %I -> hora entre 0-12 sienpre va con %p
# %p -> am/pm
# %M -> minutos 0-59
# %s -> segundos enteros 0-59
# %OS -> segundos reales
# %Z -> Zona horaria America/Chicago, Canada, France, Spain
# %z -> Zona horaria con respecto a UTC +0800, +0100

#NO digitos
# %. -> eleiminar un caracter no dígitos
# %* -> eliminar cualquier número de caracteres que no sean dígitos

parse_date("05/08/15", format = "%d/%m/%y")

parse_date("05/08/15", format = "%m/%d/%y")


parse_date("01-05-2018", format = "%d-%m-%y")

parse_date ( "5 janvier 2012" , format = "%d %B %Y", locale = locale("fr"))

parse_date ( "3 Septiembre 2014" , format = "%d %B %Y", locale = locale("es"))

################# procesado de números################
#a veces se escriben con puntos o comas
#caracter monetario: el símbolo, si aparece antes o después: 100$, 100€
#porcentajes: 12%... el % no es parte del número

###############HEURÍSTICA DEL PARSEO##############

# -> lógico -> integer -> double -> number
# -> time -> date -> datetime -> strings
guess_parser("2018-05-03")
guess_parser("23:36")
guess_parser(c("3,6,8,25"))
guess_parser(c("TRUE", "FALSE", "FALSE"))

guess_parser(C("3", "6", "8","25"))

challenge <- read_csv(readr_example("challenge.csv"))
tail(challenge)

problems(challenge)

challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    Y = col_character()
  )
  )
problems(challenge)
tail(challenge)

view(challenge)

?stop_for_problems

x <- parse_integer(c("1X", "blah", "3"))
problems(x)

challenge2 <- read_csv(readr_example("challenge.csv"),
                       guess_max = 1001)
challenge2


###############elección de muestras y la función type_convert#############

challenge2 <- read_csv(readr_example("challenge.csv"),
                       guess_max = 1001)#para aumentar lo que se puede mirar
challenge2

challenge3 <- read_csv(readr_example("challenge.csv"),
                       col_types = cols(.default = col_character()))
challenge3
type_convert(challenge3)

df <- tribble(
  ~x, ~y,
  "1", "1,2",
  "2", "3.87",
  "3", "3.1415"
)

type_convert(df)

read_lines (readr_example("challenge.csv")) 
            
#para leer filas y todo sería filas de caracteres

read_file(readr_example("challenge.csv"))

###########OTROS TIPOS DE FICHEROS ESPECIALES################

#Escritura de ficheros 
#write.csv(), write_tsv()
#strings en UTF8 siempre
#date/ datetimes ISO8601
#write_excel_csv()
write.csv(challenge, "data/challenge.csv")

read_csv(challenge, "data/challenge.csv", guess_max = 1001)

write_rds(challenge, "data/challenge.rds")#tipo de archivo especial de R
read_rds("data/challenge.rds")

install.packages("feather")#implementa un formato de lenguaje binario super rápido
library(feather)#puede ser incluido en otros lenguajes (python, etc)

write_feather(challenge, "data/challenge.feather")
read_feather("data/challenge.feather")

#librería haven -> para spss, stata y sas

#readxl -> ficheros de microsoft excel xml y xmls
#para bases de datos
# DBI + RMySQL, RSQLite, RPostgreSQL

#para datos no rectangulares... para jerarquicos
#jsonlite, xml2

#libreria rio (R inputo output)

#se guardó este archivo con encoding UTF-8 por recomendación de R

#########LIMPIANDO Y DANDO ESTRUCTURA A LOS DATOS####################

#limpieza con el paquete tidyr
#los mismos datos se pueden organizar de distintas maneras
#REgGLAS PARA TENER DATOS TIDY (LIMPIOS):
# 1* cada variable tiene tener su propia columna: no mezclar datos indistintamente
# 2* cada una de las observaciones tiene que tener su propia fila
# 3* Cada valor tiene que tener su propia celda
# VARIABLE EN COLUMNAS, OBSERVACIONES EN FILAS Y VALORES EN CELDAS 

#SER CONSISTENTE EN EL ALMACENAMIENTO DE DATOS
#Colocar las variables en columnas permite a R trabajar muy bien con su sintaxis

popula<- tibble(
  ':)'  = "smile",
  ' '   = "space",
  '1998'= "number"
)

write_csv(population, "data/population.csv")
table <- read_csv("data/population.csv")
view(table)


table %>% 
  mutate(rate = cases/population*10000)

table %>% 
  count(year, nt=cases)

table %>% 
  ggplot(aes(year, cases)) +
  geom_line (aes(group = country), color = "grey") +
  geom_point (aes(color=country))

#ejemplos de tener diferentes formas la tabulación de los datos
#en R están los ejemplos escribiendo table y se despliegan las diferentes tablas

############### gather ó pivot_long#############
#a partir de columnas con valores generamos filas. tablas muy anchas se vuelvan mas estrechas, pero mas largas
table4a
#para reunir los datos de la población
table4a %>% 
  gather(`1999`,`2000`, key = "year", value = "cases") -> tidy4a

table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")-> tidy4b

population2 <- left_join(tidy4a, tidy4b)
 write_csv(population, "data/population2.csv")

############### spread ó pivot_wider#################
#a partir de filas con valores generamos columnas. tablas muy largas en longitud se vuelvan mas cortas
table2 %>% 
  spread(key = type, value = count)

 #################### separate ##############
 
 #separa los valores de una columna en multiples columnas

 table3 %>% 
   separate(rate, into = c("cases", "population"))
#si queremos usar un separador específico en las columnas
 table3 %>% 
   separate(rate, into = c("cases", "population"), sep = "/")

 #hay que fijarse en los parseo y arreglar el tipo de dato
table3 %>% 
  separate (rate, into = c("cases", "population"), 
            sep = "/",
            convert = TRUE)
 
# suministar un vector de enteros al separador
# posición en la que vas a separar 
# valores positivos empiezan en 1 y se colocan a la izq del string y cuentan hacia la derecha
#valores negativos empiezan en -1, se colocan a la derecha del string y cuentan hacia la izquierda
# ej: 
table3 %>% 
  separate (rate, into = c("cases", "population"), 
            sep = "/",
            convert = TRUE) %>% 
  separate(year, sep =2, into = c("century", "year"))
#arreglar el paseo nuevamente

table3 %>% 
  separate (rate, into = c("cases", "population"), 
            sep = "/",
            convert = TRUE) %>% 
  separate(year, sep =2, into = c("century", "year"), convert =  TRUE)

################### UNITE ####################
table5 %>%
  unite(new_year, century, year, sep="/")
#aparece con un undersocore entre los números del año  
table5 %>%
  unite(new_year, century, year, sep="")

################ NA en la limpieza de datos ###############
#el valor NA solo puede aparecer en dos formas:
# 1* forma explícita
# 1* en forma implícita: no aparece en el original, o está pero al arreglar aparce NA

roi <- tibble(
  year = c(rep(2016,4), rep(2017,4), 2018),
  quarter = c(rep(c(1,2,3,4),2),1),
  return = rnorm(9, mean = 0.5, sd =1)
)
roi
roi$return[7] = NA
roi

roi %>% 
  spread(year, return)

roi %>% 
  spread(year, return) %>% 
  gather(year, return, `2016`: `2018`, na.rm =TRUE)
roi

roi %>% 
  complete(year, quarter)

#otros ejemplos de Na: a veces se utiliza para no repetir un mismo dato. ej:
treatments <- tribble(
  ~name,           ~treatment,  ~response,
  "Juan Gabriel",  1,           8,
  NA,              2,           10, 
  NA,              3,           4,
  "Ricardo",       1,           7,
  NA,              2,           9, 
)

treatments %>% 
  fill(name)#para rellenar los NA que se repiten como nombres
#pero ojo que si el último hubiera sido un tratamiento cuarto se podría comenter un error.

############### un caso real de sanidad #############################

tidyr::who %>% view()

tidyr::who  

#Por donde empezar con un problema de este estilo

# 1° Reunir variables que no son columnas
# 2° observar la estructura de las variables: comienzan con new-- luego varía ente números
# 3° de qué se tratan las definiciones de las variables

#reunir las variables detectadas que estaban desordenadas

tidyr::who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)->Who1
Who1 %>% count(key) %>% view()
#new, old, sp(pulmonía positiva), np (pulmonía negativa), ep (pulmonía exterior), rel (recaída)
#rel, no tiene barra baja... hay que cambiarlo
who2 <- Who1 %>% 
  mutate(key = stringr:: str_replace(key, "newrel", "new_rel"))
#en el nuevo objeto who2, está compuesto por who1.
#Entonces, ahí cambiar la columna key, con la función stringr,
#en específico la fucnicón estructura de reemplazo,
# en la columna key cambiar newrel por new_rel



who2
#hacer un conteo de las key y verlo
who2 %>% count(key) %>% view()

#separar las key
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")

who3 %>% count(new)#todos los datos son new por tanto es inutil igual que la iso 2 e iso 3

#eliminamos entonces las columnas inútiles
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)
who4 %>% view()

#separar sexo de edad
who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep=1)
who5 %>% view()

#para ahorrar espacio de información  hacemos una sintaxis toda junta haciendo relucir todo tidyverse
#se realizó con diferenes iteraciones
tidyr::who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE) %>%
  mutate(key = stringr:: str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "type", "sexage"), sep = "_") %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep=1)

#############ultimo punto sobre datos desestructurados#############

#en caso de estructuras matriciales y muchas celdas desocupadas
#no vale la pena ocupar las matrices
#nace mas matrices 3d, los datos espaciales
#estas no se dan en una tibble o data frame
# a veces hay que tratar con otros tipos de estructuras
# si se quiere dar un vistazo a datos desestructurados buscar en internet
#buscar estructuras de datos

##########Análisis en multiplea tablas (Base de datos relacionales)############
#para trabajar con bases de datos relacionales se necesita trabajar con los siguientes verbos
#se necesita la siguiente base
library(nycflights13)
nycflights13::airlines
airports
tails(planes)  
tail(planes)  
tail(weather)  


 