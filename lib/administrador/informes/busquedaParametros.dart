import 'dart:convert';

import 'package:condominios_web/administrador/informes/crearInforme.dart';
import 'package:http/http.dart' as http;

busquedaParametros (String idAdmin, String opcion, String fechaSeleccionada,String fechaSeleccionadaMes, String metodoPago)async{

  var lista;
  int sumaTotal = 0;

  if (opcion == "Día")
  {
    final response = await http.post (Uri.parse("https://olam.com.mx/recibos/diaEspecifico.php"), body: {
      "buscar": idAdmin,
      "fecha": fechaSeleccionada,
      "metodo": metodoPago,
    });
    lista = json.decode(response.body);
  }
  else{
    var mes;
    var anio;
    anio = fechaSeleccionadaMes.substring(0,4);
    mes = fechaSeleccionadaMes.substring(5,7);
    final response = await http.post (Uri.parse("https://olam.com.mx/recibos/mesEspecifico.php"), body: {
      "buscar": idAdmin,
      "mes": mes,
      "anio": anio,
      "metodo": metodoPago,
    });
    lista = json.decode(response.body);

    print(lista.length);
  }

  for (int i=0; i<lista.length; i++)
  {
    sumaTotal = sumaTotal + int.parse(lista[i]['cantidad']);
  }

  crearInforme(lista, sumaTotal);


}