
rm(list=ls())

cant_figuritas=670
n=1000 #cantidad de simulaciones con cantidad de sobres fijos (n_sobres)
m=5000 #cantidad de simulaciones con cantidad de sobres ilimitada.
n_sobres=800 #cantidad de sobres fijos

#Funciones:
pegar_sobre = function(a,p){ #Esta función simula la acción de abrir un paquete de figuritas y pegarlas en el album
  for (j in 1:5) {
    a[p[j]]=TRUE
  }
  return(a)
}

album_lleno = function(album){ #Devuelve True si el album está lleno y False si no.
  salida= FALSE
  if (all(album)==1) {
    salida=TRUE
  }
  return(salida)
}

probaconnsobres= function(n, n_sobres){ #Estima la probabilidad de completar el album con la cantidad prefijada de sobre n_sobres.
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
  cat('La probabilidad estimada de llenar el album con ', n_sobres, ' sobres es de ', 100*exitos/n, ' %.')
}

cuantossobres=function(cant_figuritas){ #Esta simulación cuenta la cantidad de sobres que hacen falta hasta llenar el album desde cero.
  album=rep(FALSE, cant_figuritas)
  sobres=0
  while (album_lleno(album)!=1) {
    paquete=sample (1:cant_figuritas,5, replace=TRUE) 
    album=pegar_sobre(album,paquete)
    sobres=sobres+1
  }
  # print('La cantidad de sobres necesarios para llenar el album fue de')
  # print(sobres)
  return(sobres)
}


#Programa a ejecutar:
probaconnsobres(n, n_sobres)
  #Gráfico de sobres:
x=rep(0, m)
for (i in 1:m){
x[i]=cuantossobres(cant_figuritas)
#x son los sobres necesarios para llenar el album, cada lugar de x es el resultado de una simulación distinta.
}
#plot(x) 
hist(x,
     main="Cantidad de sobres hasta completar el album",
     xlab="Cantidad de sobres",
     col="lightblue",
     breaks=30,
     freq=TRUE
)
cat('La cantidad de sobres esperados para completar el album es ', mean(x), ' con una desviación estándar de ', sd(x))
cat('Los cuantiles para la cantidad de sobres necesarios son los siguientes:')
quantile(x)
