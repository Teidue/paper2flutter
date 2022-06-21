import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/doctor.dart';

class DoctorsApi {
  // ignore: unused_element
  static Future<List<Doctor>?> getDoctores(String query) async {
    final url = Uri.parse(
        // 'http://10.0.2.2:3000/api/doctor/filter/especiality?especialidad=$query');
        'http://192.168.0.100:3000/api/doctor/filter/especiality?especialidad=$query');
    final http.Response response;
    try {
      response = await http.get(url);
    } catch (e) {
      // throw Exception('El servidor esta inactivo - ServerDown');
      return null;
    }
    final List jsonData;
    List<Doctor>? doctores;

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      jsonData = jsonDecode(body);
      if (jsonData.isNotEmpty) {
        doctores = jsonData.map((json) => Doctor.fromJson(json)).toList();
        return doctores;
      } else {
        return doctores = [];
      }
    } else {
      return doctores;
    }
  }
}
