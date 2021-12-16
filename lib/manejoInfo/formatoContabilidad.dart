String formatocontabilidad (String cantidad){
  String formato = "";
  int contador = 0;
  int lugar;
  if (cantidad.length > 3)
  {
    lugar = cantidad.length % 3;
    print (cantidad.length);
    for (int i = 0 ; i <cantidad.length; i++)
    {
      if (i == lugar && lugar != 0|| contador == 2)
      {
        contador = 0;
        formato = formato + ",";
        formato = formato + cantidad[i];
      }
      else
      {
        formato= formato + cantidad[i];
        contador = contador + 1;
      }
    }
  }
  else
    formato = cantidad;
  return formato;
}