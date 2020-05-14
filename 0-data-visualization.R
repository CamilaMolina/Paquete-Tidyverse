


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

#Los coches con motor mas grande consumen mas combustible
#que los coches con motor mas pequeño

#la relación consumo tamaño es lineal? es no lineal? es exponencial?
#es positiva? es negativa?

#visualización del data set
ggplot2::mpg
mpg
view(mpg)
#displ: tamaño del motor en litros
help(mpg)
?mpg
#hwy: número de millas recorridas en autopista 
#por galón de combustible (3.78541)

#Primer gráfico de puntos
ggplot(data = mpg) + #se crea un grafo vacío a este determinado data set
  geom_point(mapping = aes(x=displ, y=hwy)) #en esta segunda línea se ordena el tipo de gráfico y las coodenadas
#esta segundo línea adiciona capas a la gráfica base.
#mapping: el argumento mapping define como las variables del daa set van a ser traducidas a propiedades visuales
#siempre va emparejado a aes:estética a las variables x e y

#PLANTILLAS PARA REPRESENTACIÓN GRÁFICA CON GGPLOT
#ggplot(data=<DATA_FRAME>) +
  #<GEOM_FUNCTION> (mapping = aes (<MAPPINGS>))

#Tarea
#ggplot (data=mpg) ¿Qué sigifica?
#Indica el número de filas que tiene el data frame ¿Qué significan las filas?
#Indica el número de columnas que tiene el dataframe ¿qué significan las columnas?
#¿Qué describe la variable drv?
#Realiza un scatterplot de la variable hw vs cyl ¿Qué observa?
ggplot(data=mpg) +
  geom_point(mapping = aes (x=hwy, y=cyl ))

ggplot(data=mpg) +
  geom_point(mapping = aes(x=cyl, y=cty))


### Análisis
#H1: coches híbridos gran volumen de vencina y electricidad. mas rendimiento
#en los datos class hay coches compactos, coches medios. Si los puntos
#outliyers se salen de la media se podría decir que en x= tamaño depósito, y= rendimiento, j= tipo de coche
#aes=estética del plot. colores, tamaño. Nivel=datos particulares de la estética
#datos numéricos= valores

#¿Como colorear los distintos tipos de coches=
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=class))

#OBS
#colour=british
#color=american
#R acepta las dos

#Tamaño de los puntos a pesar de que la variable sea categorial
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=class))

#Estética del alpha de la opacidad/transparencia
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, alpha=class))
#la forma de los puntos(solo permite 6 formas a la vez)
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape= class))
#obs=ggplot solo trabaja un maximo de 6 formas discretas... de la 7° en adelante no aparece

#Elección manual de estéticas: nombre del argumento como función fuerea del mapping para configurar
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), color="red")
#color= nombre del color en formato string
#size=tamaño del punto en mm
#shape=forma del punto con números desde el 0 al 25
#0-14 son formas huecas solo se puede cambair el color
#15-20: formas lenas de color por tanto se le puede cambiar el color otra vez
#21-25: formas con borde y relleno, se les puede cambiar el color (borde) y el fill (relleno)
#googlear ggplot2 quick reference shape
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

#Aplicación del diccionario y cambios de forma y color
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), 
             shape=23, size=10, color="red", fill="yellow")
#TAreas
#1)Toma el siguiente fragmento de código y di qué está mal. 
#¿Por qué no aparecen pintados los puntos de color verde?

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = "green"))

#2)Toma el dataset de mpg anterior y di qué variables son categóricas.
#manufacturer, model, drv,  trans, fl, class
view(mpg)
#manufacturer, model, drv,  trans, fl, class

#3)Toma el dataset de mpg anterior y di qué variables son contínuas.
#displ, year, cyl, ctv, hwy

#4) Dibuja las variables contínuas con color, tamaño y forma respectivamente. 
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



#5)¿En qué se diferencian las estéticas para variables contínuas y categóricas?
#las variables categoriales se pueden mapear con shape y las contínuas no 

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

#6)¿Qué ocurre si haces un mapeo de la misma variable a múltiples estéticas?
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ, size=displ))

#Funciona pero depende si es categorial o contínua. Yo hice una variable continua con estética color y size, 
#pero sin shape porque esta estética no corre para variables contínuas. 

#7) Vamos a conocer una estética nueva 
#llamada stroke. ¿Qué hace? ¿Con qué formas funciona bien? 
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=model))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=year))#no funcionó con año. Arrojó un gráfico completamente negro
#plotea círculos dependiendo de la relevancia y solo funciona con variables contínuas o numéricas
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ, color=displ))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ, color=class))


#8) ¿Qué ocurre si haces un mapeo de una estética 
#a algo que no sea directamente el nombre de una variable (por ejemplo aes(color = displ < 4))?
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ < 4))
#Plotea y lo hace arrojando leyenda con vector lógico.  False para rojo y True para celeste. 
#Esto significa que todos los cruces menores a 4 para displ y hwy están con color celeste.
#Por tanto, la visualización nos puede ayudar a ver con el color celeste solo los datos de 
#displ con motor inferior a 4.0
?stroke

### PROBLEMAS
#1)STARKOVERFLOW. copiar muy bien los códigos. cuidado con los detalles, puntos comas, mayusculas, etc
#cierre de paréntesis debe cerrar y doble comillas. ayuda hacer intro para alinear los paréntesis
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, 
                           y=hwy, 
                           colour=displ < 4
                           )
             )
#si no aparece el ícono ">" en la consola y aparece un +, es porque
#R está pensando o tu no has terminado el script. Se debe forzar aplicando enter
#hasta que aparezca el ícono de habilitación
#2)abortar secuencias o comandos: con esc
#3) el + tiene que ir siempre al final de la línea sino R no v a entender 
#bien la instrucción
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ < 4))
#4)si no funciona una función preguntar a R con un interrogante. 
#Por ejemplo, si no funciona ggplot hacer interrogante de la función
?ggplot
#para ver la documentación en help dentro de R
#5)
df <- data.frame(
  gp = factor(rep(letters[1:3], each = 10)),
  y = rnorm(30)
)


#Errores: copiar errores y pegar en google para buscar la solución

###DIVISIÓN DEL PLOT EN DIFERENTES FACETS O SUBPLOT
#para hacer un gráfico para dichas subcategorías
#facet_wrap(~<FORMULA_VARIABLE>): la varible debe ser discreta
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_wrap(~class, nrow=2)
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_wrap(~class, nrow=3)
#también se puede utilizar el facet_wrap para combinar dos variables
#con facet_grid
#facet_grid(<FORMULA_VARIBLE1>~<FORMULA_VARIBLE2>)
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_grid(drv~cyl)
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy)) +#
  facet_grid(.~cyl)
### TAREAS
#1)¿Qué ocurre si hacemos un facet de una variable contínua?
###Se puede hacer pero... el resultado digamos 
###que no es lo que uno espera ya que el número de gráficos puede ser enorme!
#R plotea cada una de las observaciones por separado.
#Lo que no tiene mucho sentido.
#2)¿Qué significa si alguna celda queda vacía en el gráfico facet_grid(drv~cyl)?
###También aparece vacío la fila/columna correspondiente en el gráfico con puntos.


#¿Qué relación guardan esos huecos vacíos con el gráfico siguiente?

ggplot(data = mpg) +
  geom_point(mapping = aes(x=drv, y = cyl)) 
#Es una lógica similar al facet_wrap

#3)Qué gráficos generan las siguientes dos instrucciones? ¿Qué hace el punto? ¿Qué diferencias hay de escribir la variable antes o después de la virgula?
###Representa el conjunto de puntos filtrados en columnas i filas respectivamente.
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~.)
?mpg
#1)plotea la realción entre desplazamiento del motor por litro y millas
#de carretera por galón en el subset de datos de número de cilindradas

#2)plotea la realción entre desplazamiento del motor por litro y millas 
#de carretera por galón en el subset de datos de tipos de tracciones de los autos

#4)El primer facet que hemos pintado era el siguiente:

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 3)

#¿Qué ventajas crees que tiene usar facets en lugar de la estética del color? 
#¿Qué desventajas? ¿Qué cambiaría si tu dataset fuera mucho más grande?

#La ventaja que tiene el usar facet_wrap es poder analizar el efecto de la correlación
#sobre subset de datos específicos. Es decir, se puede observar por separado los 
#elementos de una variable (columna) 

#La desventaja es que solo es útil en variables discretas. No sirve para variables 
#continuas. Y creo que es mas útil con set data madianos o pequeños

#Sería mucho la cantidad de plot que tendría que realizar R. Lo que hace la visualización ilegible
###El número de colores o subdivisiones puede dificultar el entendimiento del gráfico. 
###En el caso de un dataset grande, muchos colores pueden hacer el gráfico incomprensible
###mientras que los subplots pueden agilizar el filtrado y la comprensión de cada categoría.


#5)Investiga la documentación de ?facet_wrap y contesta a las siguientes preguntas:
?facet_wrap
#¿Qué hace el parámetro nrow?
#¿Y el parámetro ncol?
#¿Qué otras opciones sirven para controlar el layout de los paneles individuales?
#¿Por qué facet_grid() no tiene los parámetros de nrow ni de ncol?

#1)Parámetro nrow: número de filas

#2)Parámetro ncol: número de columnas

#3)NO entendí

#4)porque trabaja con dos variables que en el dataframe corresponden a filas y columnas.
###Define el número de filas (y columnas) en las cuales distribuir los subplots 
##generados por el facet. En el caso del grid, como las variables indican 
##automáticamente los niveles de las filas y de las columnas,
###no tiene sentido añadirle dichas opciones de visualización gráficas. 

#6)Razona la siguiente afirmación:

#Cuando representemos un facet con facet_grid() conviene poner
#la variable con más niveles únicos en las columnas.

#Los gráficos tienden a ser más anchos que altos (la proporción estándar es de 16:9 
#o formato panorámico) así que si una variable tiene más niveles que otra, 
#conviene que esté en la dimensión más grande del gráfico, es decir, la anchura. 

###ELEMENTOS VISUALES DIFERENTES###
#eL OBJETO GEOM: OBJETO geométrico que se utiliza en ggplot para representar
#visualmente el dato.
#diagramas de líeas=geomline
#boxplot
#skaterplot=geometry plot=gráfico de puntos
#son diferentes dimensiones 

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~.)
#diferentes geometrías
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y = hwy))

ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy))
#subdivisión de los autos según tracción de acuerdo
#a un gráfico smooth
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype=drv))

#esto mismo añadiendo colores
ggplot(data=mpg)+
    geom_smooth(mapping = aes(x=displ, y = hwy, linetype=drv, color=drv))

#combinación de capas
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y = hwy, color=drv)) +
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype=drv, color=drv))

#data visualizationcheat sheet con ggplot2
library(ggplot)
#visualización con group y show.legend para hacer la leyenda
#que el group solo no hace
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy, group=drv, color=drv),
              show.legend = T)
#sin leyenda
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy, group=drv, color=drv),
              show.legend = F)

#combinación de gráficos nuevamente
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))+
  geom_smooth(mapping = aes(x=displ,Y=hwy))
#para evitar tipo de repetición, configurar directamente en el ggplot2
ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) +#acá poner el mapping global
  geom_point(mapping = aes(shape=class))+#acá poner mapping local
  geom_smooth(mapping = aes(color=drv))
  
#elegir subconjuntos filtrando los datos 
ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point(mapping = aes(color=class)) +
  geom_smooth(data = filter(mpg, class=="suv"), se = F)# se=F elimina el
                                                      #intervalo de confianza 
                                                      #alrededor de la curva

#TAREA
#1)Ejecuta este código en tu cabeza y predice el resultado. 
#Luego ejecutalo en R y comprueba tu hipótesis:
ggplot(data = mpg, mapping = aes(x=displ, y = hwy,color = drv)) + 
  geom_point() + 
  geom_smooth( se = F)
#si, se comprueba mi imaginación. solo me faltó imaginar la leyenda.
###

#2)¿Qué hace el parámetro show.legend = F? 
#no muestra la leyenda
#¿Qué pasa si lo eliminamos? 
# depende de si necesitamos la leyenda, si no lo ponemos, no sale leyenda
#¿Cuando lo añadirías y cuando lo quitarías?
#lo quitaría cuando los gráficos se expliquen por si solos.
###Muestra o oculta la leyenda cuando hace falta. Revisa el vídeo si no sabes cuando ponerlo o quitarlo.

#3)¿Qué hace el parámetro se de la función geom_smooth()?
#el parametro se dibuja la sombra del intervalo de confianza de la curva
#¿Qué pasa si lo eliminamos? 
#desaparece el intervalo de confianza
#¿Cuando lo añadirías y cuando lo quitarías?
#lo añadiría para saber la varianza de los datos y lo eliminaría 
#observar solo el comportamiento de los datos
###se elimina o muestra el error estándar de los datos en forma de corredor. De la documentación de R:

###se elimina o muestra el error estándar de los datos en forma de corredor. De la documentación de R:

#se: standard error

#4) Describe qué hacen los dos siguientes gráficos 
#y di si serán igual y diferente. Justifica tu respuesta.
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  
  geom_point() + 
  geom_smooth()

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y = hwy)) + 
  geom_smooth(mapping = aes(x=displ, y = hwy))
#son iguales porque el primero tiene un mapping global que reúne los mapping locales del segundo
###Son los mismos ya que el mapping global en el primer caso es igual a los dos locales en el segundo.


#5)Reproduce el código de R que te genera el siguiente gráfico.
ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth(se=F)
####Ejercicio 5
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(se=F)


#6)Reproduce el código de R que te genere el siguiente gráfico
ggplot(data=mpg, mapping = aes(x=displ, y=hwy), se = F)+
  geom_point()+
  geom_smooth(aes(class=drv))
####Ejercicio 6
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(mapping = aes(group=drv), se=F)


#7)Reproduce el código de R que te genera el siguiente gráfico.
ggplot(data=mpg, mapping = aes(x=displ, Y = hwy), color=drv)+
  geom_point()+
  geom_smooth( se = F)
####Ejercicio 7
ggplot(data = mpg, mapping = aes(x=displ, y = hwy, col=drv)) + 
  geom_point() + 
  geom_smooth( se=F)

 
#8)Reproduce el código de R que te genera el siguiente gráfico.
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(shape=drv, color=drv)) + 
  geom_smooth( se = F)

####Ejercicio 8
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(col=drv, shape = drv)) + 
  geom_smooth( se=F)
  
#9)Reproduce el código de R que te genera el siguiente gráfico.
ggplot(data = mpg, mapping = aes(x=displ, Y=hwy, shape=drv, color=drv))+
  geom_point()+
  geom_smooth(se = F)
####Ejercicio 9
ggplot(data = mpg, mapping = aes(x=displ, y = hwy) ) + 
  geom_point(mapping = aes(col=drv, shape = drv)) + 
  geom_smooth(mapping = aes(linetype = drv), se=F)

#10)¡Este va para nota!

#Reproduce el código de R que te genera el siguiente gráfico. 
#Investiga algunos parámetros adicionales que te harán falta de ggplot2 
#como stroke entre otros.

ggplot(data = mpg, mapping = aes(x=displ, y=hwy))+
  geom_dotplot(mapping=aes(color=drv))
####Ejercicio 10
ggplot(data = mpg, mapping = aes(x=displ, y = hwy) ) + 
  geom_point(mapping = aes(fill = drv), size = 4, 
             shape = 23, col = "white", stroke = 2)

#Diagrama de barras
#se utiliza con mas observaciones. datos mas grades. Por tanto, utilizaremos 
#el data set de diamonds
diamonds
view(diamonds)
#Ejemplo del data set de diamantes
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut))#aparece la Y como count. el bar chart, un histograma, 
#un polígono de frecuencias, 
#son gráficos que toman los datos, agruparlos por categorías y representar el 
#número de elementos que cae dentro de cada uno de las secciones o grupos
#calcula nuevos valores el plot. entonces hace una serie de operaciones,
#de transformaciones, antes de poder llevar a cabo la represntación gráfica
#para calcular los valores utilza un algoritmo llamado stat.
#se siguen tres pasos para llegar a la representación gráfica:
#1) tenemos los datos crudos en el data set de diamonds
#2)geometry bar utiliza una función llamada stat count para calcular cuantos 
#elementos caen dentro de cada uno de los cortes
#3) finalmente geometry bar utiliza esta información transformada que la hace 
#automáticamente ggplor, para llevar a cabo la representación gráfica 
#donde las categorías pertenecen al eje de las x mientras que el count pertenece
#al eje de las y
#para saber mas de geom_bar
?geom_bar
#el valor por defecto es count es decir, geom_bar=stat_count: es el mismo resultado
ggplot(data=diamonds)+
  stat_count(mapping = aes(x=cut))

#toda la geometría tiene un stat. podemos usar geometrías sin las preocupacioens estadísticass
#el propio ggplot las infiere automáticamente.

#creación de subconjunto de los diamantes. Pequeño data set 
#de otro dataset mas grande
demo_diamonds <- tribble(
  ~cut,      ~freqs,
  "Fair",       1610, 
  "Good",       4906,
  "Very Good", 12082,
  "Premium",   13791, 
  "Ideal",     21551
)
#vamos a cambair el estadístico del count a la identidad.
#esto me dejará mapear la altura de las barras de los raw values
#a una variable Y que yo tengo ya automáticamente

ggplot(data=demo_diamonds)+
  geom_bar(mapping = aes (x=cut, y=freqs), 
           stat="identity")
#esto es manual y diferente al stat_count automático de r

#ahora mostramos un diagrama de barras para mostrar la porporción
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, Y=..prop.., group=1))

#queremos traer la atención en una transformación estadística
#directamente en nuestro código.
#porejemplo, podemos utilizar la función stat summary
#esta función resume los valores Y para cada valor de x 
#todo un conjunto de datos del mundo de la estadística
#ver valores mínimos máximos o medias, medianas, etc podemos utilizar un ggplot

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
###TAREA
#!)¿Qué hace el parámetro geom_col? ¿En qué se diferencia de geom_bar?
ggplot(data=demo_diamonds)+
  geom_bar(mapping = aes (x=cut, y=freqs), 
           stat="identity")
ggplot(data=demo_diamonds)+
  geom_col(mapping = aes (x=cut, y=freqs), 
           stat="identity")
#no se diferencian en nada. lo mismo que geom_bar

###Según la documentación exacta, os sumará los valores subministrados como y en el dataset:
#There are two types of bar charts: geom_bar makes the height of the 
#bar proportional to the number of cases in each group 
#(or if the weight aethetic is supplied, the sum of the weights). 
#If you want the heights of the bars to represent values in the data, 
#use geom_col instead. geom_bar uses stat_countby default: it counts 
#the number of cases at each x position. geom_col uses stat_identity: 
#it leaves the data as is.

#2)La gran mayoría de geometrías y de stats vienen por parejas 
#que siempre se utilizan en conjunto. Por ejemplo geom_bar con stats_count. 
#Haz una pasada por la documentación y la chuleta de ggplot y establece una 
#relación entre esas parejas de funciones. ¿Qué tienen todas en común?
#la transformación de los datos 

#3) Cuando hemos pintado nuestro diagrama de barras con sus proporciones, 
#necesitamos configurar el parámetro group = 1. ¿Por qué?
#para mostrar las proporciones por barra. De lo contrario todas las barras aparecerán 
#de igual proporción

###Según la documentación de R:

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

#4)Qué problema tienen los dos siguientes gráficos?
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group=1))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop.., group=1))
#no demuestran las proporciones correspondientes porque no está group=1

###Porque si no, la proporción no se calcula para cada una de las 
###categorías del eje de las X. 

#5)¿Qué variables calcula la función stat_smooth? ¿Qué parámetros
#controlan su comportamiento?
#e + stat_smooth(method = "lm", formula = 
#y ~ x, se=T, level=0.95) x, y | ..se.., ..x.., ..y.., ..ymin.., ..ymax.. 

###COLORES Y FORMAS DE LOS GRÁFICOS 
ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, colour=cut))

ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, fill=cut))

ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, fill=clarity))

ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, fill=color))


## position="identity"
ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( alpha=0.2, position="identity")#alpha 0.2 es para que quede mas transparente
#position es ver el overlapping de las barras... todas empiezan abajo y se van sobreponiendo
#sirve para geom 3d. este gráfico se debe usar con transparencia (alpha=0.2)
#position identity para un scatterplot puede resultar fantástico, pero para un geom bar
#es fatal
ggplot(data=diamonds,mapping  = aes(x=cut, colour = clarity))+
  geom_bar( fill= NA, position="identity")

##position = "fill" muy similar al stacket, pero sirven para comparar las proporciones. 
#todos quedan a la misma altura y se puede comparar proporciones. toda las barras altura 1
# y comparas proporciones
ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( position="fill")#para diagrama de barra

##position = "dodge"
ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( position="dodge")#coloca los objetos uno al lado del otro para evitar esa 
#oclusión que ocurría con el gráfico de identity
#es mucho mas fácil de comparar por coloraciones. 
#para diagrama de barras una al lado del otro

#volvemos al scatterplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy))#solo pinta una pequeña muestra. Los puntos no son 
#todas las obervaciones. esto es por el problema del overplotting.
#esto impide ver la concentración de puntos porque se overlapean y se ven todos iguales los puntos
#la forma mejor de hacer la representación es configurar mejor el parámetro 
#de ajustamiento de pisición llamado jitter
##position="jitter"
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(position="jitter")#acá los puntos no se overlapean. se puede ver mas en los gráficos
#añade un pequeño ruido aleatorio. Hace que pequeñas diferencias por factores de escala 
#se revelen aparezcan, salgan a la luz, y que podamos ver de mejor manera la concentración
#de puntos
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_jitter()#esto es lo mismo que lo anterior

ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( position="stack")

?position_stack
?position_identity
?position_fill
?position_dodge
?position_jitter


##Sistemas de coordenadas en ggplot2
#el sistema de coordenadas de cualquier gráfico es el sistema de coordenadas cartesiana
#pero existen otros sistemas de coordenadas que pueden ser realmente útiles
#la función coodinate_flip

#coord_flip()-> cambia los papeles de x e Y para girar un gráfico
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
#el rango intercuantítilico es la distancia que hay desde la zona inferior de la caja 
#hasta la zona superior. 
#básicamente 1,5 veces ese valor es el maximo del pivote
#valores 1,5 veces del rango  intercuartículo por encima o debajo de la caja tenemos aoutlayers

#coord_quickmap() -> configura el aspect ratio para mapas
#importante para representacion de datos geoespaciales con ggplot

es<- map_data("es")
#"es"=cpodigo iso de un país en este caso es españa

install.packages("maps")

italy<- map_data("italy")
ggplot(italy, aes(long, lat, group=group)) +
  geom_polygon(fill="blue", color="white") +
  coord_quickmap()#facilita un aspecto mas real 

usa<- map_data("usa")
ggplot(usa, aes(long, lat, group=group)) +
  geom_polygon(fill="blue", color="white") +
  coord_quickmap()#facilita un aspecto mas real 

#coord_polar=uso coordenadas polares entre un barchart y un coxcomechart, el diagrama en tela de araña

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
  coord_polar()#para girar muy utilizado en las infografías y resumen de inforamción
#una vez realizado los análisis
####################################
#Gramática por capas de ggplot2
##########################################
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

#partir siempre de un diagrama básico y luego combinar parámetros y coordenadas 
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, y = ..count..))
#tipo de plot
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, y = ..prop.., group=1))#..prop.. para la proporción
#agrego color
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))

#############################
#COOORDENADAS POLAR
#################################


#cambio de coordenadas
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()
#creación de gráficos por una varible determinada en este caso cut en Y
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)

#quitar información irrelevante en cada uno de los ejes
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL)

#agregar un título 
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL, title="Ejemplo final de ggplot con JB")

# si quiero agregar un caption=una descripción abajo
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL, title="Ejemplo final de ggplot con JB",
       caption = "Dos variables cruzadas de diamonds")

#para agregar un subtitle
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL, title="Ejemplo final de ggplot con JB",
       caption = "Dos variables cruzadas de diamonds",
       subtitle = "Aprender ggplot puede ser hasta divertido ;)")



#TAREA AJUSTES AVANZADOS DE GGPLOT

#El siguiente gráfico que genera el código de R es correcto 
#pero puede mejorarse. ¿Qué cosas añadirías para mejorarlo?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) + 
  geom_point(shape=23, size=5, color="red", fill="yellow", stroke = cty)

ggplot(data=mpg, mapping = aes (x = cty,  y = hwy )) +
  geom_point(position = "jitter", color= "red")+
  geom_smooth()

  
#Investiga la documentación de geom_jitter(). 
#¿Qué parámetros controlan la cantidad de ruído aleatorio (jitter)?
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
#sirve para observar la concentración de datos en cada localización

# Add aesthetic mappings
geom_jitter(aes(colour = class))

# Add aesthetic mappings
geom_jitter(aes(colour = class))

#¿Cual es el valor por defecto del parámetro position de 
#un geom_boxplot? Usa el dataset de diamonds o de mpg para hacer una visualización 
#que lo demuestre.

#El valor del parámetro de posición es el carteriano por defecto
ggplot(data=diamonds, mapping = aes(x=cut, y=price)) +
  geom_boxplot() 




#Convierte un diagrama de barras apilado en un diagrama de sectores o de tarta usando la función coord_polar()

ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, y = ..count..))

ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()



#¿Qué hace la función labs()? Lee la documentación y explícalo correctamente.
?labs#modifica las las etiquetas de los ejes x e y, y las leyendas de plot


#¿En qué se diferencian las funciones coord_quickmap() y coord_map()?

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

#Investiga las coordenadas coord_fixed() e indica su función.
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

#Investiga la geometría de la función geom_abline(), geom_vline() y geom_hline() e indica su función respectivamente.


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

#¿Qué nos indica el gráfico siguiente acerca de la relación entre el consumo en ciudad y en autopista del dataset de mpg?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) + 
  geom_point() + 
  geom_abline() + 
  coord_fixed()
#significa que en un ratio de 1/5  existe una directa proporción del rendimiento de los autos y en la ciudad. Los que rinden mas 
# en ciudad rinden mas en autopista


x <- "hola_mundo"
 
x <- "hola_mundo"
x <- "hola_mundo"
x <- "hola_mundo"
X <- "hola_mundo" 
#si no terminamos de cerrar con comillas o parentesis 
#R muestra en la consola un signo mas como señal de que te falta terminar
# o que aún sigue abierta lo que estas programando
#indica que R está esperando que completes la instrucción
x
(x <- "hola_mundo")



#####################################################
#R como calculadora
#####################################################

#round()
round(pi, digits = 8)#arroje pi con 8 dígitos

round(pi, digits = 2)#arroje pi pero con solo 2 dígitos 

sin(pi/2) #calcule el seno de pi partido por 2
    
tan(pi/6) #la tangente de pi partida por 6
sqrt(64)#raiz cuadrada de 64
log(7, base = 8)#logaritmo de 7 en base 8
log(7, base=3)


exp(1)# es el número e (2.718281828) exponente de 1
exp(2)
2^5#dos elevado a 5
factorial(5)5*4*3*2
choose(6, 2)#número de formas en que se puede extraer subconjuntos
#a partir de un subconjunto dado.
#número de formas de escoger K elementos a partir de un 
#conjunto n

round(sqrt(45), 3)-> x # x es el objeto de redondear la raíz
#cuadrada de 45 menos 3

#FUNCIONES EN r
#function_name(arg1=val1, arg2 = val2, ...)
round(pi, 3)
round(pi, digits = 3)
#los dos anteriores son los mismo
#arrojan el mimso resultado en la consola
seq(1, 12)#función de secuencia que rellena los números
seq(12)
seq(1,12, by=3)#para que corra tienes que poner de 1,12
#ver los objetos por sintáxis
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
y[9]# arroja [1] NA porque el dato no está disponible

datos::diamantes
view(diamantes)

getwd()

setwd()


###################################################################
#Estructura de proyecto
#####################################################################
