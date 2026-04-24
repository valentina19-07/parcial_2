class EstadisticasAccidentes {
  final Map<String, int> porClase;
  final Map<String, int> porGravedad;
  final Map<String, int> topBarrios;
  final Map<String, int> porDia;

  EstadisticasAccidentes({
    required this.porClase,
    required this.porGravedad,
    required this.topBarrios,
    required this.porDia,
  });
}