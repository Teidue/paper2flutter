import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/doctor.dart';

class DoctorsApi {
  // ignore: unused_element
  static Future<List<Doctor>> getDoctores(String query) async {
    final url = Uri.parse(
        'http://localhost:3000/api/doctor/filter/especiality?especialidad=$query');
    final response = await http.get(url);

    List<Doctor> doctores = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final List jsonData = jsonDecode(body);
      doctores = jsonData.map((json) => Doctor.fromJson(json)).toList();
      return doctores;
    } else {
      throw Exception("FALLO");
    }
  }
}
