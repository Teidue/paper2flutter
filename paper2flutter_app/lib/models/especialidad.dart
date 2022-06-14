class especialidad {
  final int? id_especialidad;
  final String? nombre;

  const especialidad({required this.id_especialidad, required this.nombre});

  factory especialidad.fromJson(Map<String, dynamic> json) {
    return especialidad(
      id_especialidad: json['id_especialidad'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_especialidad": id_especialidad,
        "nombre": nombre,
      };
}