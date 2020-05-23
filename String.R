
# String, factores y fechas -----------------------------------------------


#aprenderemos a usar las regexps para descubrir patrones en strings
#es un poco difíciles, pero es muy útil saber porque se utiliza en muchos lenguajes.

library(tidyverse)
library(stringr)
 #recomendación: usar siempre comillas dobles. Pero, si usas simples siempre simples 
#o siempre dobles
s1 <- "Esto es un string"
s2 <- 'Esto es un string que contiene otro "string" dentro'
s3 <- "Esto es un string sin cerrar"

#siempre recordar cerrar un string, porque si nó en la consola 
#aparece un signo + que indica que debemos continuar. 
#solución]: O cerramos o aplicamos scape (a veces se necesita hacer scape 2 veces)

#para incluir una comilla doble dentro de un string
double_quote <- "\"" # '"'
single_quote <- '\'´' # "'"
backslash <- "\\"

x <- c(single_quote, double_quote, backslash)
x
writeLines(x)

#\n -> intro o salto de líneas
#\t -> tabulador
"\u00b5"
mu <- "\u00b5"
mu

#se queremos saber mas información de estos 
#caracteres escapantes conultar el manual de las quotes así:

?'"'

#para crear un vector de caracteres con conjunto de string
c("uno", "dos", "tres")

#PREFIJO STr: 
str_length(c("x", "Macarena es top", NA))

#como combinar o juntar dos strings
str_c("a", "b", "c")
str_c("a", "b", "c", sep=", ")

#si quiero imprimir los NA entre comillas ocupo la función string replace NA
x <- c("abc", NA)
str_c("hola", "adios")

str_c("hola", str_replace_na(x), "adios", sep = " ")

#la función string está vectorizada

str_c("prefix-", c("a", "b", "c"), "-suffix")

#combinación de string en acción

name <- "Macarena"
momento_del_dia <- "tarde"
cumpleaños <- F

str_c(
  "Buena ", momento_del_dia, " ", name, 
  if (cumpleaños) " y FELIZ CUMPLEAÑOS!!! =D",
  "."
)

name <- "Sergio"
momento_del_dia <- "tarde"
cumpleaños <- TRUE

str_c(
  "Buena ", momento_del_dia, " ", name, 
  if (cumpleaños) " y FELIZ CUMPLEAÑOS!!! =D",
  "."
)

#si queremos copapsar un vector de string en un solo string

str_c(c("a", "b", "c"), collapse = "'")

#si queremos hacer subconjutos de un string
#tiene un argumento star y otro end

x <- c("Manzana", "Peras", "Limones", "Plátanos")
str_sub(x, 1,3)
str_sub(x, -3,-1)
str_sub("x", 1,8)

str_sub(x, 1,1) <- str_to_lower(str_sub(x,1,1))
x

str_to_upper(x)

str_to_title(x)

#en el caso de idiomas diferentes R adpta los cambios 
str_to_upper("i", locale = "tr")#tr es idioma turco

#hay países en donde el orden es diferente funciones para ordenar string del sistema

str_sort(x, locale = "es")

str_sort(c("apple", "banana", "eggplant"), locale = "how")

str_order(x, locale = "how")


# REGEXP ------------------------------------------------------------------

#Expresiones regulares: nos ayuda a escribir un patrón dentro de un string

#str_view()
#str_view_all()
install.packages("htmlwidgets")
library(htmlwidgets)
x <- c("manzana", "banana", "pera", "pomelo")


#localizar la existencia exacta de un patrón dentro de la lista

str_view(x, "an")
str_view(x, ".a")
str_view(x, "o")

str_view(x, ".a.")

#para crear una expresión regular como un punto se hace con barra barra
#las barras son caracteres escapantes

dot <-"\\."
writeLines(dot)
str_view(c("abc", "a.c", "bc."), "a\\.c")

backslash <-  "\\\\"
writeLines(backslash)
str_view("a\\b", "\\\\")

#el string es útil utilizarlo con anclas
# ^ -> inicio del string
# $ -> final del string

str_view(x, "^p")
str_view(x, "a$")

y <- c("tarta de manzana", "manzana", "manzana al horno", "pastel de manzana")

str_view(y, "manzana")
str_view(y, "^manzana$")#encuentra única y exclusivamente la palabra manzana


# Busqueda de expresiones regulares ---------------------------------------

#se utiliza sintaxis dentro de la función buscar
#esto se abre con el siguiente comando ctrl+shift+f

#\b -> localizar la frontera de un palabra

sum()
summarise()

#\d -> localizar cualquier dígito
#\s ->  cualquier espacio en blanco (espacio, tabulador, salto de línea)
#[abc]-> localizar la a, la b o la c indistintamente: los de conjunto
#[^abc]-> localizar cualquier cosa excepto la a,b, o c


# Forma de seleccionar uno o mas patrones ---------------------------------

#abc| d..m # los dos puntos sirven para señalar dos letras cualquiera.
#la barra vertical significa cualquier cosa antes y después de la norma
#ejemplo
str_view(c("grey", "gray"), "gr(e|a)y")


# Cuantas veces aparece un determinado elemento dentro de un patrón -------

#Existen tres símbolos para este efecto
#? -> 0 o 1 
#+ -> 1 o más veces # al  menos su existencia
#* -> 0 o más veces # caulquier cosa

#Ejemplo
x <- "El año 1888 es el mas largo en números romanos: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "CC+")
str_view(x, "C[LX]+")
"colou?r"
"ba(na)+"


# Número de veces que busco determinada silaba, palabra o letra -----------

#{n}-> exactamente n repeticiones
#{n,} -> n o más repeticiones
#{,m} -> como máximo m repeticiones
#{n,m} -> entre n y m repeticiones

str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")

#por defecto estos resultados son gridi. Esto significa que van a intentare
#hacer la búsqueda en el mayor string posible

#También se puede hacer busqueda con el string mas corto posible (lazy)
#se deb agragar el signo de interrogación
str_view(x, "C{2,3}?")

str_view(x, "C[LX]+")#sin espacio para que marque la zona
str_view(x, "C[LX]+?")


# Grupo de expresiones y palabras mas complicadas -------------------------
#Grupos que se pueden referenciar hacia atrás

fruits <- c("banana", "coco", "papaya", "manzana", "pera", "pepino")

#localizar pares repetidos de letra

str_view(fruits, "(..)\\1")#devuelve todo destacando la zona con el patrón
str_view(fruits, "(..)\\1", match=TRUE)#devuelve solo las palabras que contengan el patrón

#hay un data set que contiene muchas frutas
fruit
str_view(fruit, "(..)\\1", match=TRUE)

str_view("abc-abc", "(...)-\\1")
str_view("abc-abc-", "(...)-\\1")
str_view("abc-abc-", "(...)(-)\\1\\2")
str_view("abc-def-", "(...)(-)\\1\\2")


# Encontrar y extraer coincidencias de la expresión regular ---------------

#DEterminar un vector de caracteres coincide con un determinado patrón
str_detect(fruits, "a")

words

#Cuantas de estas palabras comienzan con letra j
str_detect(words, "^j")
sum(str_detect(words, "^j"))
mean(str_detect(words, "^j"))
mean(str_detect(words, "^[aeiou]"))
mean(str_detect(words, "[aeiou]$"))

#como encontrar palabras que no contienen ninguna vocal
!str_detect(words, "[aeiou]")


#encontrar solo las palabras que constan de consonantes:
#sirve también para detectar elementos que coinciden con un cierto patrón

sum(!str_detect(words, "[aeiou]"))
sum(str_detect(words, "^[^aeiou]+$"))

f1 <- !str_detect(words, "[aeiou]")
f2 <- str_detect(words, "^[^aeiou]+$")#[^ que no contenga
identical(f1,f2)

#¿Cuáles son las palabras que no tienen ninguna vocal?
words[!str_detect(words, "[aeiou]")]

#hacerlo directamente con un subconjunto lógico
str_subset(words,"[aeiou]$")

#usar combinaciones de sintaxis
df <- tibble(
  word = words,
  i = seq_along(word)
)
df %>% view()

df %>% filter(str_detect(words, "x$"))

str_count(fruits, "a")

str_count(words, "[aeiou]")
mean(str_count(words, "[aeiou]"))

df %>% 
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )
#el str_count no tiene overlapping

str_count("abababababa", "aba")
str_view("abababababa", "aba")
str_view_all("abababababa", "aba")
