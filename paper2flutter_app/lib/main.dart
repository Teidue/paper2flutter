// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paper2flutter_app/models/doctor/doctor.dart';
import './page/Doctor_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<Doctor> docs = [];

  Future<List<Doctor>> _getDocs() async {
    final response = await http.get(Uri.parse(
        'http://localhost:3000/api/doctor/filter/especiality?especialidad=Neurologia'));

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

  fetchFromApi() async {
    docs = await _getDocs();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filtro de Doctores por Especialidad',
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                hintText: 'Buscar',
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<Doctor>>(
          future: _getDocs(),
          builder: (context, snapshot) {
            final filteredDocs = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('Ocurrió un error!'));
                } else {
                  return buildDoctors(filteredDocs!);
                }
            }
          },
        ),
      ),
    );
  }

  Widget buildDoctors(List<Doctor> doctores) => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: doctores.length,
        itemBuilder: (context, index) {
          final filteredDoctor = doctores[index];

          return ListTile(
            leading: CircleAvatar(
              child: ClipRRect(
                child: Image.asset('../assets/images/media/hombre1.jpg'),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            title: Text(filteredDoctor.p_nombre),
          );
        },
      );
}
