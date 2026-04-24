class Accidente {
  final String claseAccidente;
  final String gravedadAccidente;
  final String barrio;
  final String dia;
  final String hora;
  final String area;
  final String claseVehiculo;

  Accidente({
    required this.claseAccidente,
    required this.gravedadAccidente,
    required this.barrio,
    required this.dia,
    required this.hora,
    required this.area,
    required this.claseVehiculo,
  });

  factory Accidente.fromJson(Map<String, dynamic> json) {
    return Accidente(
      claseAccidente: json['clase_de_accidente'] ?? 'Desconocido',
      gravedadAccidente: json['gravedad_del_accidente'] ?? 'Desconocido',
      barrio: json['barrio_hecho'] ?? 'Desconocido',
      dia: json['dia'] ?? 'Desconocido',
      hora: json['hora'] ?? '00:00',
      area: json['area'] ?? 'Desconocido',
      claseVehiculo: json['clase_de_vehiculo'] ?? 'Desconocido',
    );
  }
}
