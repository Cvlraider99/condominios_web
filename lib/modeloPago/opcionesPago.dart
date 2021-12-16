class OpcionesPago { // LOCACIONES
  String name;
  OpcionesPago(this.name);
  static List<OpcionesPago> obtenerListaPago() {
    return <OpcionesPago>[
      OpcionesPago('Deposito'),
      OpcionesPago('Transferencia'),
      OpcionesPago('Efectivo'),
      OpcionesPago('Tarjeta'),
    ];
  }
}
