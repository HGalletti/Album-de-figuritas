rm(list=ls())

cant_figuritas=670
n=1000 #cantidad de simulaciones con sobres fijos
m=500 #cantidad de simulaciones de cuantos sobres
n_sobres=800

#Funciones
pegar_sobre = function(a,p){
  for (j in 1:5) {
    a[p[j]]=TRUE
  }
  return(a)
}

album_lleno = function(album){
  salida= FALSE
  if (all(album)==1) {
    salida=TRUE
  }
  return(salida)
}

probaconnsobres= function(n, n_sobres){
  exitos=0
  for (k in 1:n) {
    album=rep(FALSE, cant_figuritas)
    for (i in 1:n_sobres) {
      paquete=sample (1:670,5, replace=TRUE) 
      album=pegar_sobre(album,paquete)
    }
    if (album_lleno(album)==1) {
      exitos=exitos+1
    }
  }
  print('La probabilidad estimada de llenar el album con la cantidad de sobres propuesta es ')
  print(exitos/n)
}

cuantossobres=function(cant_figuritas){
  album=rep(FALSE, cant_figuritas)
  sobres=0
  while (album_lleno(album)!=1) {
    paquete=sample (1:670,5, replace=TRUE) 
    album=pegar_sobre(album,paquete)
    sobres=sobres+1
  }
  # print('La cantidad de sobres necesarios para llenar el album fue de')
  # print(sobres)
  return(sobres)
}





#Ejecutar
probaconnsobres(n, n_sobres)
  #Gráfico de sobres:
x=rep(0, m)
for (i in 1:m){
x[i]=cuantossobres(cant_figuritas)
}
plot(x) #x son los sobres necesarios para llenar en album, en cada lugar una simulacion.
hist(x)
quantile(x)