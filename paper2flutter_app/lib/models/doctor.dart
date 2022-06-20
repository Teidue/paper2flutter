// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, camel_case_types

import 'especialidad.dart';

class Doctor {
  final int id_doctor;
  final String p_nombre;
  final String p_apellido;
  final String sexo;
  final String foto;
  final List<especialidad> especialidades;

  const Doctor(
      {required this.id_doctor,
      required this.p_nombre,
      required this.p_apellido,
      required this.sexo,
      required this.foto,
      required this.especialidades});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id_doctor: json['id_doctor'],
      p_nombre: json['p_nombre'],
      p_apellido: json['p_apellido'],
      sexo: json['sexo'],
      foto: json['foto'],
      especialidades: List<especialidad>.from(json["especialidades"]
          .map((especialidadJson) => especialidad.fromJson(especialidadJson))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id_doctor": id_doctor,
        "p_nombre": p_nombre,
        "p_apellido": p_apellido,
        "sexo": sexo,
        "foto": foto,
        "especialidades": List<dynamic>.from(
            especialidades.map((especialidad) => especialidad.toJson())),
      };
}
