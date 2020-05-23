


#Data Visualization 27 de noviembre del 2019
library(tidyverse)
#-- Attaching packages ----------------------------- tidyverse 1.3.0 --
#  v ggplot2 3.2.1     v purrr   0.3.3
#v tibble  2.1.3     v dplyr   0.8.3
#v tidyr   1.0.0     v stringr 1.4.0
#v readr   1.3.1     v forcats 0.4.0
#-- Conflicts -------------------------------- tidyverse_conflicts() --
#  x dplyr::filter() masks stats::filter()
#x dplyr::lag()    masks stats::lag()

# Visualización de datos (27-09-2020) -------------------------------------


#Los coches con motor mas grande consumen mas combustible
#que los coches con motor mas peque?o

#la relaci?n consumo tama?o es lineal? es no lineal? es exponencial?
#es positiva? es negativa?


# Visualización del data set ----------------------------------------------


ggplot2::mpg
mpg
view(mpg)
#displ: tama?o del motor en litros
help(mpg)
?mpg
#hwy: n?mero de millas recorridas en autopista 
#por gal?n de combustible (3.78541)





# Gráfico de puntos -------------------------------------------------------


ggplot(data = mpg) + #se crea un grafo vac?o a este determinado data set
  geom_point(mapping = aes(x=displ, y=hwy)) #en esta segunda l?nea se ordena el tipo de gr?fico y las coodenadas
#esta segundo l?nea adiciona capas a la gr?fica base.
#mapping: el argumento mapping define como las variables del daa set van a ser traducidas a propiedades visuales
#siempre va emparejado a aes:est?tica a las variables x e y

#PLANTILLAS PARA REPRESENTACI?N GR?FICA CON GGPLOT
#ggplot(data=<DATA_FRAME>) +
  #<GEOM_FUNCTION> (mapping = aes (<MAPPINGS>))

#Tarea
#ggplot (data=mpg) ?Qu? sigifica?
#Indica el n?mero de filas que tiene el data frame ?Qu? significan las filas?
#Indica el n?mero de columnas que tiene el dataframe ?qu? significan las columnas?
#?Qu? describe la variable drv?
#Realiza un scatterplot de la variable hw vs cyl ?Qu? observa?
ggplot(data=mpg) +
  geom_point(mapping = aes (x=hwy, y=cyl ))

ggplot(data=mpg) +
  geom_point(mapping = aes(x=cyl, y=cty))


### An?lisis
#H1: coches h?bridos gran volumen de vencina y electricidad. mas rendimiento
#en los datos class hay coches compactos, coches medios. Si los puntos
#outliyers se salen de la media se podr?a decir que en x= tama?o dep?sito, y= rendimiento, j= tipo de coche
#aes=est?tica del plot. colores, tama?o. Nivel=datos particulares de la est?tica
#datos num?ricos= valores


# agregar color a varable coches ------------------------------------------


ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=class))




#OBS
#colour=british
#color=american
#R acepta las dos


# Cambio del tamaño de los puntos -----------------------------------------


ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=class))


# Transparencia de los puntos ---------------------------------------------


ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, alpha=class))


# Figura de los puntos ----------------------------------------------------


ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape= class))
#obs=ggplot solo trabaja un maximo de 6 formas discretas... de la 7? en adelante no aparece


# Elección del color en forma manual --------------------------------------

#Elecci?n manual de est?ticas: nombre del argumento como funci?n fuerea del mapping para configurar
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), color="red")
#color= nombre del color en formato string
#size=tama?o del punto en mm
#shape=forma del punto con n?meros desde el 0 al 25
#0-14 son formas huecas solo se puede cambair el color
#15-20: formas lenas de color por tanto se le puede cambiar el color otra vez
#21-25: formas con borde y relleno, se les puede cambiar el color (borde) y el fill (relleno)
#googlear ggplot2 quick reference shape


# Escalas y configuración de identidad ------------------------------------


d=data.frame(p=c(0:25))
ggplot() +
  scale_y_continuous(name="") +
  scale_x_continuous(name="") +
  scale_shape_identity() +
  geom_point(data=d, mapping=aes(x=p%%16, y=p%/%16, shape=p), size=5, fill="red") +
  geom_text(data=d, mapping=aes(x=p%%16, y=p%/%16+0.25, label=p), size=3)

d=data.frame(p=c(0:25,32:127))
ggplot() +
  scale_y_continuous(name="") +
  scale_x_continuous(name="") +
  scale_shape_identity() +
  geom_point(data=d, mapping=aes(x=p%%16, y=p%/%16, shape=p), size=5, fill="red") +
  geom_text(data=d, mapping=aes(x=p%%16, y=p%/%16+0.25, label=p), size=3)

#CAMBIO DE CURSOR DE VERTICAL Y HORIZONTAL Y VICE VERSA
#PRESS INSERT


# Aplicación del diccionario y cambios en forma e identidad ---------------


#Aplicaci?n del diccionario y cambios de forma y color
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), 
             shape=23, size=10, color="red", fill="yellow")


# Ejercicios y resultados -------------------------------------------------


#TAreas
#1)Toma el siguiente fragmento de c?digo y di qu? est? mal. 
#?Por qu? no aparecen pintados los puntos de color verde?

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = "green"))

#2)Toma el dataset de mpg anterior y di qu? variables son categ?ricas.
#manufacturer, model, drv,  trans, fl, class
view(mpg)
#manufacturer, model, drv,  trans, fl, class

#3)Toma el dataset de mpg anterior y di qu? variables son cont?nuas.
#displ, year, cyl, ctv, hwy

#4) Dibuja las variables cont?nuas con color, tama?o y forma respectivamente. 
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=year))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour= cyl))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=hwy))

ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=displ))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=year))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size= cyl))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=hwy))



#5)?En qu? se diferencian las est?ticas para variables cont?nuas y categ?ricas?
#las variables categoriales se pueden mapear con shape y las cont?nuas no 

ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=manufacturer))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=model))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape= drv))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=trans))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=fl))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=drv))

#6)?Qu? ocurre si haces un mapeo de la misma variable a m?ltiples est?ticas?
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ, size=displ))

#Funciona pero depende si es categorial o cont?nua. Yo hice una variable continua con est?tica color y size, 
#pero sin shape porque esta est?tica no corre para variables cont?nuas. 

#7) Vamos a conocer una est?tica nueva 
#llamada stroke. ?Qu? hace? ?Con qu? formas funciona bien? 
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=model))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=year))#no funcion? con a?o. Arroj? un gr?fico completamente negro
#plotea c?rculos dependiendo de la relevancia y solo funciona con variables cont?nuas o num?ricas
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ, color=displ))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ, color=class))


#8) ?Qu? ocurre si haces un mapeo de una est?tica 
#a algo que no sea directamente el nombre de una variable (por ejemplo aes(color = displ < 4))?
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ < 4))
#Plotea y lo hace arrojando leyenda con vector l?gico.  False para rojo y True para celeste. 
#Esto significa que todos los cruces menores a 4 para displ y hwy est?n con color celeste.
#Por tanto, la visualizaci?n nos puede ayudar a ver con el color celeste solo los datos de 
#displ con motor inferior a 4.0
?stroke

### PROBLEMAS
#1)STARKOVERFLOW. copiar muy bien los c?digos. cuidado con los detalles, puntos comas, mayusculas, etc
#cierre de par?ntesis debe cerrar y doble comillas. ayuda hacer intro para alinear los par?ntesis
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, 
                           y=hwy, 
                           colour=displ < 4
                           )
             )
#si no aparece el ?cono ">" en la consola y aparece un +, es porque
#R est? pensando o tu no has terminado el script. Se debe forzar aplicando enter
#hasta que aparezca el ?cono de habilitaci?n
#2)abortar secuencias o comandos: con esc
#3) el + tiene que ir siempre al final de la l?nea sino R no v a entender 
#bien la instrucci?n
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ < 4))
#4)si no funciona una funci?n preguntar a R con un interrogante. 
#Por ejemplo, si no funciona ggplot hacer interrogante de la funci?n
?ggplot
#para ver la documentaci?n en help dentro de R
#5)
df <- data.frame(
  gp = factor(rep(letters[1:3], each = 10)),
  y = rnorm(30)
)


#Errores: copiar errores y pegar en google para buscar la soluci?n


# División de gráficos: funciones wrap y grid -----------------------------


###DIVISI?N DEL PLOT EN DIFERENTES FACETS O SUBPLOT
#para hacer un gr?fico para dichas subcategor?as
#facet_wrap(~<FORMULA_VARIABLE>): la varible debe ser discreta
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_wrap(~class, nrow=2)
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_wrap(~class, nrow=3)
#tambi?n se puede utilizar el facet_wrap para combinar dos variables
#con facet_grid
#facet_grid(<FORMULA_VARIBLE1>~<FORMULA_VARIBLE2>)
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_grid(drv~cyl)
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy)) +#
  facet_grid(.~cyl)
### TAREAS
#1)?Qu? ocurre si hacemos un facet de una variable cont?nua?
###Se puede hacer pero... el resultado digamos 
###que no es lo que uno espera ya que el n?mero de gr?ficos puede ser enorme!
#R plotea cada una de las observaciones por separado.
#Lo que no tiene mucho sentido.
#2)?Qu? significa si alguna celda queda vac?a en el gr?fico facet_grid(drv~cyl)?
###Tambi?n aparece vac?o la fila/columna correspondiente en el gr?fico con puntos.


#?Qu? relaci?n guardan esos huecos vac?os con el gr?fico siguiente?

ggplot(data = mpg) +
  geom_point(mapping = aes(x=drv, y = cyl)) 
#Es una l?gica similar al facet_wrap

#3)Qu? gr?ficos generan las siguientes dos instrucciones? ?Qu? hace el punto? ?Qu? diferencias hay de escribir la variable antes o despu?s de la virgula?
###Representa el conjunto de puntos filtrados en columnas i filas respectivamente.
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~.)
?mpg
#1)plotea la realci?n entre desplazamiento del motor por litro y millas
#de carretera por gal?n en el subset de datos de n?mero de cilindradas

#2)plotea la realci?n entre desplazamiento del motor por litro y millas 
#de carretera por gal?n en el subset de datos de tipos de tracciones de los autos

#4)El primer facet que hemos pintado era el siguiente:

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 3)

#?Qu? ventajas crees que tiene usar facets en lugar de la est?tica del color? 
#?Qu? desventajas? ?Qu? cambiar?a si tu dataset fuera mucho m?s grande?

#La ventaja que tiene el usar facet_wrap es poder analizar el efecto de la correlaci?n
#sobre subset de datos espec?ficos. Es decir, se puede observar por separado los 
#elementos de una variable (columna) 

#La desventaja es que solo es ?til en variables discretas. No sirve para variables 
#continuas. Y creo que es mas ?til con set data madianos o peque?os

#Ser?a mucho la cantidad de plot que tendr?a que realizar R. Lo que hace la visualizaci?n ilegible
###El n?mero de colores o subdivisiones puede dificultar el entendimiento del gr?fico. 
###En el caso de un dataset grande, muchos colores pueden hacer el gr?fico incomprensible
###mientras que los subplots pueden agilizar el filtrado y la comprensi?n de cada categor?a.


#5)Investiga la documentaci?n de ?facet_wrap y contesta a las siguientes preguntas:
?facet_wrap
#?Qu? hace el par?metro nrow?
#?Y el par?metro ncol?
#?Qu? otras opciones sirven para controlar el layout de los paneles individuales?
#?Por qu? facet_grid() no tiene los par?metros de nrow ni de ncol?

#1)Par?metro nrow: n?mero de filas

#2)Par?metro ncol: n?mero de columnas

#3)NO entend?

#4)porque trabaja con dos variables que en el dataframe corresponden a filas y columnas.
###Define el n?mero de filas (y columnas) en las cuales distribuir los subplots 
##generados por el facet. En el caso del grid, como las variables indican 
##autom?ticamente los niveles de las filas y de las columnas,
###no tiene sentido a?adirle dichas opciones de visualizaci?n gr?ficas. 

#6)Razona la siguiente afirmaci?n:

#Cuando representemos un facet con facet_grid() conviene poner
#la variable con m?s niveles ?nicos en las columnas.

#Los gr?ficos tienden a ser m?s anchos que altos (la proporci?n est?ndar es de 16:9 
#o formato panor?mico) as? que si una variable tiene m?s niveles que otra, 
#conviene que est? en la dimensi?n m?s grande del gr?fico, es decir, la anchura. 

###ELEMENTOS VISUALES DIFERENTES###
#eL OBJETO GEOM: OBJETO geom?trico que se utiliza en ggplot para representar
#visualmente el dato.
#diagramas de l?eas=geomline
#boxplot
#skaterplot=geometry plot=gr?fico de puntos
#son diferentes dimensiones 

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~.)
#diferentes geometr?as
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y = hwy))


# Gráfico smooth ----------------------------------------------------------


ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy))
#subdivisi?n de los autos seg?n tracci?n de acuerdo
#a un gr?fico smooth
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype=drv))

#esto mismo a?adiendo colores
ggplot(data=mpg)+
    geom_smooth(mapping = aes(x=displ, y = hwy, linetype=drv, color=drv))

#combinaci?n de capas
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y = hwy, color=drv)) +
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype=drv, color=drv))


# Mostrar leyenda ---------------------------------------------------------



#data visualizationcheat sheet con ggplot2
library(ggplot)
#visualizaci?n con group y show.legend para hacer la leyenda
#que el group solo no hace
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy, group=drv, color=drv),
              show.legend = T)
#sin leyenda
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy, group=drv, color=drv),
              show.legend = F)


# Combinación de gráficos -------------------------------------------------


# Eliminación sombra intervalos de confianza ------------------------------


#combinaci?n de gr?ficos nuevamente
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))+
  geom_smooth(mapping = aes(x=displ,Y=hwy))
#para evitar tipo de repetici?n, configurar directamente en el ggplot2
ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) +#ac? poner el mapping global
  geom_point(mapping = aes(shape=class))+#ac? poner mapping local
  geom_smooth(mapping = aes(color=drv))
  
#elegir subconjuntos filtrando los datos 
ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point(mapping = aes(color=class)) +
  geom_smooth(data = filter(mpg, class=="suv"), se = F)# se=F elimina el
                                                      #intervalo de confianza 
                                                      #alrededor de la curva

# Ejercicios y soluciones -------------------------------------------------


#TAREA
#1)Ejecuta este c?digo en tu cabeza y predice el resultado. 
#Luego ejecutalo en R y comprueba tu hip?tesis:
ggplot(data = mpg, mapping = aes(x=displ, y = hwy,color = drv)) + 
  geom_point() + 
  geom_smooth( se = F)
#si, se comprueba mi imaginaci?n. solo me falt? imaginar la leyenda.
###

#2)?Qu? hace el par?metro show.legend = F? 
#no muestra la leyenda
#?Qu? pasa si lo eliminamos? 
# depende de si necesitamos la leyenda, si no lo ponemos, no sale leyenda
#?Cuando lo a?adir?as y cuando lo quitar?as?
#lo quitar?a cuando los gr?ficos se expliquen por si solos.
###Muestra o oculta la leyenda cuando hace falta. Revisa el v?deo si no sabes cuando ponerlo o quitarlo.

#3)?Qu? hace el par?metro se de la funci?n geom_smooth()?
#el parametro se dibuja la sombra del intervalo de confianza de la curva
#?Qu? pasa si lo eliminamos? 
#desaparece el intervalo de confianza
#?Cuando lo a?adir?as y cuando lo quitar?as?
#lo a?adir?a para saber la varianza de los datos y lo eliminar?a 
#observar solo el comportamiento de los datos
###se elimina o muestra el error est?ndar de los datos en forma de corredor. De la documentaci?n de R:

###se elimina o muestra el error est?ndar de los datos en forma de corredor. De la documentaci?n de R:

#se: standard error

#4) Describe qu? hacen los dos siguientes gr?ficos 
#y di si ser?n igual y diferente. Justifica tu respuesta.
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  
  geom_point() + 
  geom_smooth()

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y = hwy)) + 
  geom_smooth(mapping = aes(x=displ, y = hwy))
#son iguales porque el primero tiene un mapping global que re?ne los mapping locales del segundo
###Son los mismos ya que el mapping global en el primer caso es igual a los dos locales en el segundo.


#5)Reproduce el c?digo de R que te genera el siguiente gr?fico.
ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth(se=F)
####Ejercicio 5
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(se=F)


#6)Reproduce el c?digo de R que te genere el siguiente gr?fico
ggplot(data=mpg, mapping = aes(x=displ, y=hwy), se = F)+
  geom_point()+
  geom_smooth(aes(class=drv))
####Ejercicio 6
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(mapping = aes(group=drv), se=F)


#7)Reproduce el c?digo de R que te genera el siguiente gr?fico.
ggplot(data=mpg, mapping = aes(x=displ, Y = hwy), color=drv)+
  geom_point()+
  geom_smooth( se = F)
####Ejercicio 7
ggplot(data = mpg, mapping = aes(x=displ, y = hwy, col=drv)) + 
  geom_point() + 
  geom_smooth( se=F)

 
#8)Reproduce el c?digo de R que te genera el siguiente gr?fico.
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(shape=drv, color=drv)) + 
  geom_smooth( se = F)

####Ejercicio 8
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(col=drv, shape = drv)) + 
  geom_smooth( se=F)
  
#9)Reproduce el c?digo de R que te genera el siguiente gr?fico.
ggplot(data = mpg, mapping = aes(x=displ, Y=hwy, shape=drv, color=drv))+
  geom_point()+
  geom_smooth(se = F)
####Ejercicio 9
ggplot(data = mpg, mapping = aes(x=displ, y = hwy) ) + 
  geom_point(mapping = aes(col=drv, shape = drv)) + 
  geom_smooth(mapping = aes(linetype = drv), se=F)

#10)?Este va para nota!

#Reproduce el c?digo de R que te genera el siguiente gr?fico. 
#Investiga algunos par?metros adicionales que te har?n falta de ggplot2 
#como stroke entre otros.

ggplot(data = mpg, mapping = aes(x=displ, y=hwy))+
  geom_dotplot(mapping=aes(color=drv))
####Ejercicio 10
ggplot(data = mpg, mapping = aes(x=displ, y = hwy) ) + 
  geom_point(mapping = aes(fill = drv), size = 4, 
             shape = 23, col = "white", stroke = 2)


# Gráfico de barras -------------------------------------------------------


#Diagrama de barras
#se utiliza con mas observaciones. datos mas grades. Por tanto, utilizaremos 
#el data set de diamonds
diamonds
view(diamonds)
#Ejemplo del data set de diamantes
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut))#aparece la Y como count. el bar chart, un histograma, 
#un pol?gono de frecuencias, 
#son gr?ficos que toman los datos, agruparlos por categor?as y representar el 
#n?mero de elementos que cae dentro de cada uno de las secciones o grupos
#calcula nuevos valores el plot. entonces hace una serie de operaciones,
#de transformaciones, antes de poder llevar a cabo la represntaci?n gr?fica
#para calcular los valores utilza un algoritmo llamado stat.
#se siguen tres pasos para llegar a la representaci?n gr?fica:
#1) tenemos los datos crudos en el data set de diamonds
#2)geometry bar utiliza una funci?n llamada stat count para calcular cuantos 
#elementos caen dentro de cada uno de los cortes
#3) finalmente geometry bar utiliza esta informaci?n transformada que la hace 
#autom?ticamente ggplor, para llevar a cabo la representaci?n gr?fica 
#donde las categor?as pertenecen al eje de las x mientras que el count pertenece
#al eje de las y
#para saber mas de geom_bar
?geom_bar


# Función stat_count ------------------------------------------------------


#el valor por defecto es count es decir, geom_bar=stat_count: es el mismo resultado
ggplot(data=diamonds)+
  stat_count(mapping = aes(x=cut))

#toda la geometr?a tiene un stat. podemos usar geometr?as sin las preocupacioens estad?sticass
#el propio ggplot las infiere autom?ticamente.

#creaci?n de subconjunto de los diamantes. Peque?o data set 
#de otro dataset mas grande
demo_diamonds <- tribble(
  ~cut,      ~freqs,
  "Fair",       1610, 
  "Good",       4906,
  "Very Good", 12082,
  "Premium",   13791, 
  "Ideal",     21551
)


# Stat identidad ----------------------------------------------------------


#vamos a cambair el estad?stico del count a la identidad.
#esto me dejar? mapear la altura de las barras de los raw values
#a una variable Y que yo tengo ya autom?ticamente

ggplot(data=demo_diamonds)+
  geom_bar(mapping = aes (x=cut, y=freqs), 
           stat="identity")
#esto es manual y diferente al stat_count autom?tico de r


# Proporción --------------------------------------------------------------


#ahora mostramos un diagrama de barras para mostrar la porporci?n
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, Y=..prop.., group=1))

#queremos traer la atenci?n en una transformaci?n estad?stica
#directamente en nuestro c?digo.
#porejemplo, podemos utilizar la funci?n stat summary
#esta funci?n resume los valores Y para cada valor de x 
#todo un conjunto de datos del mundo de la estad?stica
#ver valores m?nimos m?ximos o medias, medianas, etc podemos utilizar un ggplot


# Función stat_summary ----------------------------------------------------


ggplot(data=diamonds)+
  stat_summary(
    mapping = aes(x=cut, y=depth),
    fun.ymin=min,
    fun.ymax=max, 
    fun.y=median
  )

ggplot(data=diamonds)+
  stat_summary(
    mapping = aes(x=cut, y=price),
    fun.ymin=min,
    fun.ymax=max, 
    fun.y=median
  )

ggplot(data=diamonds)+
  stat_summary(
    mapping = aes(x=cut, y=price),
    fun.ymin=min,
    fun.ymax=max, 
    fun.y=media
  )


# Ejercicios y soluciones -------------------------------------------------


###TAREA
#!)?Qu? hace el par?metro geom_col? ?En qu? se diferencia de geom_bar?
ggplot(data=demo_diamonds)+
  geom_bar(mapping = aes (x=cut, y=freqs), 
           stat="identity")
ggplot(data=demo_diamonds)+
  geom_col(mapping = aes (x=cut, y=freqs), 
           stat="identity")
#no se diferencian en nada. lo mismo que geom_bar

###Seg?n la documentaci?n exacta, os sumar? los valores subministrados como y en el dataset:
#There are two types of bar charts: geom_bar makes the height of the 
#bar proportional to the number of cases in each group 
#(or if the weight aethetic is supplied, the sum of the weights). 
#If you want the heights of the bars to represent values in the data, 
#use geom_col instead. geom_bar uses stat_countby default: it counts 
#the number of cases at each x position. geom_col uses stat_identity: 
#it leaves the data as is.

#2)La gran mayor?a de geometr?as y de stats vienen por parejas 
#que siempre se utilizan en conjunto. Por ejemplo geom_bar con stats_count. 
#Haz una pasada por la documentaci?n y la chuleta de ggplot y establece una 
#relaci?n entre esas parejas de funciones. ?Qu? tienen todas en com?n?
#la transformaci?n de los datos 

#3) Cuando hemos pintado nuestro diagrama de barras con sus proporciones, 
#necesitamos configurar el par?metro group = 1. ?Por qu??
#para mostrar las proporciones por barra. De lo contrario todas las barras aparecer?n 
#de igual proporci?n

###Seg?n la documentaci?n de R:

#Aesthetics
#geom_smooth understands the following aesthetics 
#(required aesthetics are in bold):
  
  #<strong>x</strong>
  
 # <strong>y</strong>
  
  alpha

colour

fill

group

linetype

size

weight

#Computed variables
#y: predicted value
#ymin: lower pointwise confidence interval around the mean
#ymax: upper pointwise confidence interval around the mean
#se: standard error

#4)Qu? problema tienen los dos siguientes gr?ficos?
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group=1))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop.., group=1))
#no demuestran las proporciones correspondientes porque no est? group=1

###Porque si no, la proporci?n no se calcula para cada una de las 
###categor?as del eje de las X. 

#5)?Qu? variables calcula la funci?n stat_smooth? ?Qu? par?metros
#controlan su comportamiento?
#e + stat_smooth(method = "lm", formula = 
#y ~ x, se=T, level=0.95) x, y | ..se.., ..x.., ..y.., ..ymin.., ..ymax.. 


# Colores y formas de gráficos --------------------------------------------


###COLORES Y FORMAS DE LOS GR?FICOS 
ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, colour=cut))

ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, fill=cut))

ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, fill=clarity))

ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, fill=color))


# Posición="Identidad" ----------------------------------------------------


## position="identity"
ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( alpha=0.2, position="identity")#alpha 0.2 es para que quede mas transparente
#position es ver el overlapping de las barras... todas empiezan abajo y se van sobreponiendo
#sirve para geom 3d. este gr?fico se debe usar con transparencia (alpha=0.2)
#position identity para un scatterplot puede resultar fant?stico, pero para un geom bar
#es fatal
ggplot(data=diamonds,mapping  = aes(x=cut, colour = clarity))+
  geom_bar( fill= NA, position="identity")


# position="fill" ---------------------------------------------------------


##position = "fill" muy similar al stacket, pero sirven para comparar las proporciones. 
#todos quedan a la misma altura y se puede comparar proporciones. toda las barras altura 1
# y comparas proporciones
ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( position="fill")#para diagrama de barra


# position"dodge" ---------------------------------------------------------


##position = "dodge"
ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( position="dodge")#coloca los objetos uno al lado del otro para evitar esa 
#oclusi?n que ocurr?a con el gr?fico de identity
#es mucho mas f?cil de comparar por coloraciones. 
#para diagrama de barras una al lado del otro


# Volvemos al gráfico de puntos -------------------------------------------


#volvemos al scatterplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy))#solo pinta una peque?a muestra. Los puntos no son 
#todas las obervaciones. esto es por el problema del overplotting.
#esto impide ver la concentraci?n de puntos porque se overlapean y se ven todos iguales los puntos
#la forma mejor de hacer la representaci?n es configurar mejor el par?metro 
#de ajustamiento de pisici?n llamado jitter
##position="jitter"


# position="jitter" -------------------------------------------------------


ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(position="jitter")#ac? los puntos no se overlapean. se puede ver mas en los gr?ficos
#a?ade un peque?o ruido aleatorio. Hace que peque?as diferencias por factores de escala 
#se revelen aparezcan, salgan a la luz, y que podamos ver de mejor manera la concentraci?n
#de puntos
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_jitter()#esto es lo mismo que lo anterior


# position="stack" --------------------------------------------------------


ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( position="stack")

?position_stack
?position_identity
?position_fill
?position_dodge
?position_jitter



# coord_flip(). Sistema de coordenadas ------------------------------------

##Sistemas de coordenadas en ggplot2
#el sistema de coordenadas de cualquier gr?fico es el sistema de coordenadas cartesiana
#pero existen otros sistemas de coordenadas que pueden ser realmente ?tiles
#la funci?n coodinate_flip

#coord_flip()-> cambia los papeles de x e Y para girar un gr?fico
ggplot(data=mpg, mapping = aes(x=class, y=hwy)) +
  geom_boxplot()

ggplot(data=mpg, mapping = aes(x=class, y=hwy)) +
  geom_boxplot() +
  coord_flip()

#como se lee un boxplot+
#lo mas importante es la caja 
#la raya representa el promedio, la media
#en la caja el primer y el tercer cuartil. Entre la primera raya y el centro
#se encuentra el 25% de los datos
#y entre la raya y la zona superior hay el 25% de los datos
#entre el 25 y el 75% de los datos caen dentro de la caja
#el rango intercuant?tilico es la distancia que hay desde la zona inferior de la caja 
#hasta la zona superior. 
#b?sicamente 1,5 veces ese valor es el maximo del pivote
#valores 1,5 veces del rango  intercuart?culo por encima o debajo de la caja tenemos aoutlayers

#coord_quickmap() -> configura el aspect ratio para mapas
#importante para representacion de datos geoespaciales con ggplot


# coord_quickmap ----------------------------------------------------------


es<- map_data("es")
#"es"=cpodigo iso de un pa?s en este caso es espa?a

install.packages("maps")

italy<- map_data("italy")
ggplot(italy, aes(long, lat, group=group)) +
  geom_polygon(fill="blue", color="white") +
  coord_quickmap()#facilita un aspecto mas real 

usa<- map_data("usa")
ggplot(usa, aes(long, lat, group=group)) +
  geom_polygon(fill="blue", color="white") +
  coord_quickmap()#facilita un aspecto mas real 


# coord_polar -------------------------------------------------------------


#coord_polar=uso coordenadas polares entre un barchart y un coxcomechart, el diagrama en tela de ara?a

ggplot(data=diamonds) +
  geom_bar(
    mapping = aes(x=cut, fill=cut),
    show.legend = F, #quitar leyenda
    width = 1 #agregar anchura
  ) +
  theme(aspect.ratio = 1)+#armar grafico perfectamente cuadrado
  labs(x=NULL, Y=NULL) +#eliminar etiquetas de arriba y abajo
  coord_flip()#para girar

ggplot(data=diamonds) +
  geom_bar(
    mapping = aes(x=cut, fill=cut),
    show.legend = F, #quitar leyenda
    width = 1 #agregar anchura
  ) +
  theme(aspect.ratio = 1)+#armar grafico perfectamente cuadrado
  labs(x=NULL, Y=NULL) +#eliminar etiquetas de arriba y abajo
  coord_polar()#para girar muy utilizado en las infograf?as y resumen de inforamci?n
#una vez realizado los an?lisis


# Gramática de ggplot2 ----------------------------------------------------


#ggplot(data=<DATA_FRAME>) +
#<GEOM_FUNCTION> (
#                 mapping = aes (<MAPPINGS>),
#                 stat=<STAT>,
#                 position = <POSITION>
#                 ) +
#  <COORDINATE_FUNCTION>() +
#  <FACET_FUNCTION>(
diamonds
stats_count()
coord_cartesian()

#partir siempre de un diagrama b?sico y luego combinar par?metros y coordenadas 
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, y = ..count..))
#tipo de plot
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, y = ..prop.., group=1))#..prop.. para la proporci?n
#agrego color
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))


# Coordenadas Polar -------------------------------------------------------



#cambio de coordenadas
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()
#creaci?n de gr?ficos por una varible determinada en este caso cut en Y
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)

#quitar informaci?n irrelevante en cada uno de los ejes
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL)


# Agregar título ----------------------------------------------------------

#agregar un t?tulo 
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL, title="Ejemplo final de ggplot con JB")


# Agregar descripción -----------------------------------------------------


# si quiero agregar un caption=una descripci?n abajo
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL, title="Ejemplo final de ggplot con JB",
       caption = "Dos variables cruzadas de diamonds")


# Agregar subtítulo -------------------------------------------------------


#para agregar un subtitle
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL, title="Ejemplo final de ggplot con JB",
       caption = "Dos variables cruzadas de diamonds",
       subtitle = "Aprender ggplot puede ser hasta divertido ;)")



# Ejercicicios y solución -------------------------------------------------


#TAREA AJUSTES AVANZADOS DE GGPLOT

#El siguiente gr?fico que genera el c?digo de R es correcto 
#pero puede mejorarse. ?Qu? cosas a?adir?as para mejorarlo?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) + 
  geom_point(shape=23, size=5, color="red", fill="yellow", stroke = cty)

ggplot(data=mpg, mapping = aes (x = cty,  y = hwy )) +
  geom_point(position = "jitter", color= "red")+
  geom_smooth()

  
#Investiga la documentaci?n de geom_jitter(). 
#?Qu? par?metros controlan la cantidad de ru?do aleatorio (jitter)?
?geom_jitter
#todas las de aes
#x

#y

#alpha

#colour

#fill

#group

#shape

#size

#stroke

#Compara las funciones geom_jitter contra geom_count 
#y busca semejanzas y diferencias entre ambas.

ggplot(mpg, aes(cyl, hwy))+
  geom_point()+
  geom_jitter()

ggplot(mpg, aes(cyl, hwy))+
  geom_point()+
  geom_count()

?geom_count

#las dos son utilizadas para solucionar porblemas de overlapping. 
#Sin embargo, la pirmera muestra los puntos sin overlapping y la segunda
#sirve para observar la concentraci?n de datos en cada localizaci?n

# Add aesthetic mappings
geom_jitter(aes(colour = class))

# Add aesthetic mappings
geom_jitter(aes(colour = class))

#?Cual es el valor por defecto del par?metro position de 
#un geom_boxplot? Usa el dataset de diamonds o de mpg para hacer una visualizaci?n 
#que lo demuestre.

#El valor del par?metro de posici?n es el carteriano por defecto
ggplot(data=diamonds, mapping = aes(x=cut, y=price)) +
  geom_boxplot() 




#Convierte un diagrama de barras apilado en un diagrama de sectores o de tarta usando la funci?n coord_polar()

ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, y = ..count..))

ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()



#?Qu? hace la funci?n labs()? Lee la documentaci?n y expl?calo correctamente.
?labs#modifica las las etiquetas de los ejes x e y, y las leyendas de plot


#?En qu? se diferencian las funciones coord_quickmap() y coord_map()?

usa<- map_data("usa")
ggplot(usa, aes(long, lat, group=group)) +
  geom_polygon(fill="blue", color="white") +
  coord_quickmap()

usa<- map_data("usa")
ggplot(usa, aes(long, lat, group=group)) +
  geom_polygon(fill="blue", color="white") +
  coord_map()

?coord_quickmap#coord_map projects a portion of the earth, which is approximately spherical,
#onto a flat 2D plane using any projection defined by the mapproj package. Map projections do not, 
#in general, preserve straight lines, so this requires considerable computation. 
#coord_quickmap is a quick approximation that does preserve straight lines. 
#It works best for smaller areas closer to the equator.

?coord_map #es lo mismo 

#Investiga las coordenadas coord_fixed() e indica su funci?n.
?coord_fixed
#A fixed scale coordinate system forces a specified ratio between the physical 
#representation of data units on the axes. The ratio represents the number of 
#units on the y-axis equivalent to one unit on the x-axis. The default, ratio = 1, 
#ensures that one unit on the x-axis is the same length as one unit on the y-axis. 
#Ratios higher than one make units on the y axis longer than units on the x-axis, and vice versa. 
#This is similar to MASS::eqscplot(), but it works for all types of graphics.
ggplot(mtcars, aes(mpg, wt)) + 
  geom_point()+
  coord_fixed(ratio = 1)

ggplot(mtcars, aes(mpg, wt)) + 
  geom_point()+
  coord_fixed(ratio = 1/5)

ggplot(mtcars, aes(mpg, wt)) + 
  geom_point()+
  coord_fixed(xlim = c(15, 30))

#Investiga la geometr?a de la funci?n geom_abline(), geom_vline() y geom_hline() e indica su funci?n respectivamente.


?geom_abline#calculate slope and intercept
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point()+
  geom_abline(intercept = 20)

?geom_vline#xinterpcept
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point()+
  geom_vline(xintercept = 5)

ggplot(mtcars, aes(wt, mpg)) + 
  geom_point()+
  geom_vline(xintercept = 1:5)

?geom_hline#yintercept
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point()+
  geom_hline(yintercept = 20)

# Calculate slope and intercept of line of best fit
coef(lm(mpg ~ wt, data = mtcars)) + 
  geom_abline(intercept = 37, slope = -5)
# But this is easier to do with geom_smooth:
coef(lm(mpg ~ wt, data = mtcars)) + 
  geom_smooth(method = "lm", se = FALSE)

# To show different lines in different facets, use aesthetics
ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  facet_wrap(~ cyl)

# You can also control other aesthetics
ggplot(mtcars, aes(mpg, wt, colour = wt)) +
  geom_point () 
  geom_point()
  
  geom_hline(aes(yintercept = wt, colour = wt), mean_wt) +
  facet_wrap(~ cyl)

#?Qu? nos indica el gr?fico siguiente acerca de la relaci?n entre el consumo en ciudad y en autopista del dataset de mpg?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) + 
  geom_point() + 
  geom_abline() + 
  coord_fixed()
#significa que en un ratio de 1/5  existe una directa proporci?n del rendimiento de los autos y en la ciudad. Los que rinden mas 
# en ciudad rinden mas en autopista


x <- "hola_mundo"
 
x <- "hola_mundo"
x <- "hola_mundo"
x <- "hola_mundo"
X <- "hola_mundo" 
#si no terminamos de cerrar con comillas o parentesis 
#R muestra en la consola un signo mas como se?al de que te falta terminar
# o que a?n sigue abierta lo que estas programando
#indica que R est? esperando que completes la instrucci?n
x
(x <- "hola_mundo")

# R como calculadora ------------------------------------------------------


#round()
round(pi, digits = 8)#arroje pi con 8 d?gitos

round(pi, digits = 2)#arroje pi pero con solo 2 d?gitos 

sin(pi/2) #calcule el seno de pi partido por 2
    
tan(pi/6) #la tangente de pi partida por 6
sqrt(64)#raiz cuadrada de 64
log(7, base = 8)#logaritmo de 7 en base 8
log(7, base=3)


exp(1)# es el n?mero e (2.718281828) exponente de 1
exp(2)
2^5#dos elevado a 5
factorial(5)5*4*3*2
choose(6, 2)#n?mero de formas en que se puede extraer subconjuntos
#a partir de un subconjunto dado.
#n?mero de formas de escoger K elementos a partir de un 
#conjunto n

round(sqrt(45), 3)-> x # x es el objeto de redondear la ra?z
#cuadrada de 45 menos 3

#FUNCIONES EN r
#function_name(arg1=val1, arg2 = val2, ...)
round(pi, 3)
round(pi, digits = 3)
#los dos anteriores son los mismo
#arrojan el mimso resultado en la consola
seq(1, 12)#funci?n de secuencia que rellena los n?meros
seq(12)
seq(1,12, by=3)#para que corra tienes que poner de 1,12
#ver los objetos por sint?xis
#creamos una secuencia con longitud 8
y <- seq(1,12, length.out = 8)
#se observa en la consola elresultado de este comando
y
#para ver el valor tercero de esta secuencia
y[3]
#puedo ver todas las otras posiciones piniendo el valor del lugar entre
#corchetes
Y[8]
y
y[8]
y[5]
y[9]# arroja [1] NA porque el dato no est? disponible

datos::diamantes
view(diamantes)

getwd()

setwd()


# Calendarización con ggplot 2/ Taller de Javiera Riffo (23-05-202 --------
# Cargar paquetes y librerías ---------------------------------------------

#install.packages(c("viridisLite","viridis","tidyverse", "hrbrthemes", "sugrrants") )
library(viridis)
library(tidyverse)
library(hrbrthemes)
library(viridisLite)
library(dplyr) 
library(sugrrants)



# Abreviaciones -----------------------------------------------------------
#Cmd + shift + R -> Insertar codigo de seccion
#Cmd + shift + O -> outline
#Cmd + shift + M  -> pipe


# Nuestros primeros ejemplos  ---------------------------------------
#Nuestro primer plot
nombres <- read_csv("nombres.csv")
nombres
str(nombres) 

Sara_group <- nombres %>% 
  filter(nombre == "Sara" | nombre == "Sarah") %>% 
  group_by(nombre, anio) %>% #función group_by aplica la funcion count para cada grupo
  summarise(n=sum(n))  
head(Sara_group, 4) 

ggplot(Sara_group, aes(x = anio , y =n ))+
  geom_point()

ggplot(Sara_group, aes(x = anio , y =n, color = nombre))+ 
  geom_line()

Familia <- nombres %>% 
  filter(nombre %in% c("Robert", "Mary","Arthur"))  %>% 
  group_by(nombre, anio) %>% 
  summarise(n=sum(n))  

ggplot(data = Familia, aes(x = anio, y = n, color= nombre))+ 
  geom_point(size = 0.1) + 
  facet_wrap(~ nombre )

ggplot(data = Familia, aes(x = anio, y = n, color= nombre))+ 
  geom_point(size = 0.1) + 
  facet_wrap( ~nombre , nrow=3)

nombres_fraction <- nombres %>% 
  group_by(anio) %>% 
  mutate(anio_total = sum(n)) %>% 
  ungroup() %>% 
  mutate(fraction = n/anio_total) 
nombres_fraction

#Un truco
v<- c(1, 2, 3, 4, 5)
v - lag(v)

fraction_Mary <- nombres_fraction %>% 
  filter(nombre == "Mary") %>% 
  arrange(anio) %>% 
  mutate(diferencia_abs = abs(fraction - lag(fraction)))

#Warning message por el NA

ggplot(data = fraction_Mary, mapping = aes(x= anio, y = diferencia_abs))+ 
  geom_line() +
  labs(title = "Diferencia absoluta en el nombre Mary",
       x = "Año",
       y = "Dif. absoluta") +
  theme_bw() +
  theme(text=element_text(size = 16))


# Mision cumplida ---------------------------------------------------------
dataBI2 <- read_excel("Datos.xlsx")
str(dataBI2)

dataBI2$Date <- as.Date(dataBI2$Date)
typeof(dataBI2$Date)

# ¿por que me devuelve un double?
class(dataBI2$Date)
#Internamente las fehas son tratadas como valores numericos
as.Date("16/09/12", "%y/%m/%d") + 5

colnames(dataBI2) <- c("BI","Date","Name.BI","Stage")
dataBI2 <- data.frame(dataBI2)
#class(___)

#Step 1
ggplot(dataBI2, aes(x = BI, y = Stage)) +
  geom_point()

# Step 2
ggplot(dataBI2, aes(x = BI, y = Stage, colour = Name.BI)) +
  geom_point()

# Step 3
ggplot(dataBI2, aes(x = BI, y = Stage, colour = Name.BI)) +
  geom_point(size = 2) +
  facet_wrap( ~ Date)

#Step 4

ggplot(dataBI2, aes(x = BI, y = Stage, colour = Name.BI)) +
  geom_point(size = 2)+
  facet_wrap( ~ Date)

#Step 5
ggplot(dataBI2, aes(x = BI, y = Stage, colour = Name.BI)) +
  geom_point(size = 2)+
  facet_wrap( ~ Date) + 
  theme_bw() + #así aparece más claro 
  theme(legend.position = "bottom")  #cambia la posicion de la leyenda

#Step 6
ggplot(dataBI2, aes(x = BI, y = Stage, colour = Name.BI)) +
  geom_point(size = 2)+
  facet_wrap( ~ Date) + 
  theme_bw() + 
  theme(legend.position = "bottom") +
  labs(x="Store Visited", y="Stages", title = "")  +
  theme(plot.title=element_text(family='', face='bold', size=10, hjust = 0.5))+
  scale_y_discrete(limits = c("stage-1","stage-2","stage-3")) +
  scale_x_discrete(limits = c(1,2,3,4,5,6,7,8))

#Step 7
ggplot(dataBI2, aes(x = BI, y = Stage, colour = Name.BI)) +
  geom_point(size = 2)+
  facet_calendar( ~ Date) + 
  theme_bw() + 
  theme(legend.position = "bottom") +
  labs(x="Store Visited", y="Stages", title = "Work calendar by our model")  +
  theme(plot.title=element_text(family='', face='bold', size=10, hjust = 0.5))+
  scale_y_discrete(limits = c("stage-1","stage-2","stage-3")) +
  scale_x_discrete(limits = c(1,2,3,4,5,6,7,8)) + 
  scale_color_viridis(discrete = TRUE, option = "D")

#Step Ultimo!

ggplot(dataBI2, aes(x = BI, y = Stage, colour = Name.BI))  +
  geom_point(size=2)  +
  facet_calendar(~ Date) +
  theme_bw()  +
  theme(legend.position = "bottom")  + 
  labs(x="Store Visited", y="Stages", title = "")  +
  theme(plot.title=element_text(family='', face='bold', size=10, hjust = 0.5))+
  scale_color_viridis(discrete = TRUE, option = "D")+
  scale_y_discrete(limits = c("stage-1","stage-2","stage-3")) +
  scale_x_discrete(limits = c(1,2,3,4,5,6,7,8))


# Visualización con Rmarkdown. Gabriela Sandoval Rladies Chile ------------

---
  title: "Taller de introducción a ggplot2"
output: html_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(
  echo = TRUE,
  message = FALSE,
  warning = FALSE
)
```

# Librerias:

```{r message=FALSE, warning=FALSE}
#remotes::install_github("cienciadedatos/datos")
library(datos) #datos millas
library(tidyverse) #contiene a ggplot2
library(forcats) #usaremos la funcion fct_infreq()
```

```{r}
str(millas)
```


## Iniciamos el gráfico, proporcionando los datos
```{r}
ggplot(data=millas)
```

## Incluimos las variables a mapear
```{r}
ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista))
```

## Cambiar el color de los puntos
```{r}
ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista),color="blue")
```

# Diferenciar los puntos según la variable clase:

```{r}
ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista,color=clase))
```

# Mapping en la función ggplot()

```{r}
ggplot(data = millas,mapping = aes(x = traccion, y = autopista)) +
  geom_point()
```


```{r}
ggplot(data = millas,mapping = aes(x = cilindrada, y = autopista)) +
  geom_point() +
  geom_smooth()
```

# Facetas

```{r}
p <- ggplot(data = millas,mapping = aes(x = cilindrada, y = autopista))
```

## facet_grid

```{r}
p + 
  geom_point() +
  geom_smooth() +
  facet_grid(.~ traccion)
```


```{r}
p + geom_point() +
  geom_smooth() +
  facet_grid(traccion~.)
```


# Visualización datos espaciales Stephanie Orellana #RladiesChile ---------

# Leer puntos como tabla y convertir a formato espacial
# Atributar los puntos con su comuna correspondiente (spatial join)
# Generar estadísticas


# Cargar librerías --------------------------------------------------------
library(sf)
library(ggplot2)
library(tidyverse)


# Cargar datos con sf -----------------------------------------------------

tabla <- read_csv("data/reciclaje.csv")

reciclaje <- st_as_sf(tabla, coords = c("lon", "lat"), crs = 4326)

comunas <- read_sf("data/comunas.shp") %>% 
  filter(Region == "Región Metropolitana de Santiago")

# Corroborar CRS ----------------------------------------------------------

st_crs(reciclaje)$epsg
st_crs(comunas)$epsg

reciclaje_utm <- st_transform(reciclaje, crs = 32719)
comunas_utm <- st_transform(comunas, crs = 32719)

# Hacer spatial join y estadísticas ---------------------------------------

reciclaje_comuna <- comunas_utm %>% 
  st_join(reciclaje_utm) %>% 
  group_by(Comuna) %>% 
  summarise( n = n())

# Hacer gráfico ---------------------------------------------------------
## Espacial

ggplot(reciclaje_comuna) +
  geom_sf(aes(fill=n))

## No Espacial

tab_rec_com <- st_drop_geometry(reciclaje_comuna)

ggplot(reciclaje_comuna, aes(x=reorder(Comuna, n), y = n, fill = Comuna)) +
  geom_col() +
  theme(legend.position = "none") +
  coord_flip()

# Para revisarlo en Excel
write_csv(tab_rec_com, "tabla.csv")
© 2020 GitHub, Inc.

# Leer un conjunto de rásters de temperatura superficial en Kelvin
# Convertir unidades multiplicando por factor 0.02 y luego convertir a Celcius 
# Realizar estadísticas zonales por comuna para el mes de enero


# Cargar librerías --------------------------------------------------------
library(raster)
library(tidyverse)
library(sf)


# Hacer raster stack y cáculos --------------------------------------------

l <- list.files(path = "data/raster/LST", pattern = ".tif$", full.names = T)

lst <- stack(l)
lst <- (lst * 0.02) - 273.15

# Leer comunas ------------------------------------------------------------

comunas <- read_sf("data/comunas.shp") %>% 
  filter(Region == "Región de Valparaíso") %>% 
  st_transform(crs = st_crs(lst)) 

# Hacer estadística zonal -------------------------------------------------

max_ene <- comunas %>% 
  dplyr::select(Comuna, Provincia, Region) %>% 
  mutate(ene = raster::extract(lst$lst_01, comunas["Comuna"], fun = max, na.rm=T)) %>% 
  filter(!is.na(ene))


# Hacer gráfico -----------------------------------------------------------

p1 <- ggplot(max_ene)+
  geom_sf(aes(fill=ene)) +
  scale_fill_viridis_c()

## leaflet?
### Tarea: Intentar hacerlo con https://rstudio.github.io/leaflet/choropleths.html
