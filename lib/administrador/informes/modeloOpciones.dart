class OpcionesTiempo { // LOCACIONES
  String name;
  OpcionesTiempo(this.name);
  static List<OpcionesTiempo> getCompanies() {
    return <OpcionesTiempo>[
      OpcionesTiempo('Día'),
      OpcionesTiempo('Mensual'),
    ];
  }
}
