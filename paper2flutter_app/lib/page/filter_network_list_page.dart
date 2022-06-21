import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paper2flutter_app/models/doctor.dart';
import '../api/doctors_api.dart';
import '../widget/search_widget.dart';

class FilterNetworkListPage extends StatefulWidget {
  const FilterNetworkListPage({Key? key}) : super(key: key);

  @override
  FilterNetworkListPageState createState() => FilterNetworkListPageState();
}

class FilterNetworkListPageState extends State<FilterNetworkListPage> {
  List<Doctor> doctors= [];
  String query = '';
  Timer? debouncer;
  bool isNull = false;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final doctors = await DoctorsApi.getDoctores(query);

    setState(() {
      if (doctors != null) {
        this.doctors = doctors;
      } else {
        this.doctors = [];
        isNull = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Filtro de Doctores'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.isNotEmpty
                    ? doctors.length
                    : 1,
                itemBuilder: (context, index) {
                  if (doctors.isNotEmpty) {
                    final doctor = doctors[index];
                    var flatEspecialidades = '';
                    for (var item in doctors[index].especialidades) {
                      flatEspecialidades =
                          flatEspecialidades + item.nombre! + ', ';
                    }
                    flatEspecialidades = flatEspecialidades.substring(
                        0, flatEspecialidades.length - 2);
                    flatEspecialidades = flatEspecialidades + '.';
                    return buildDoctor(doctor, flatEspecialidades);
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            !isNull
                                ? 'No se encontraron resultados para: "$query"'
                                : 'Servidor Caido',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  }

                  // switch (doctors!.isNotEmpty) {
                  //   case true:
                  //     {
                  //       final doctor = doctors![index];
                  //       var flatEspecialidades = '';
                  //       for (var item in doctors![index].especialidades) {
                  //         flatEspecialidades =
                  //             flatEspecialidades + item.nombre! + ', ';
                  //       }
                  //       flatEspecialidades = flatEspecialidades.substring(
                  //           0, flatEspecialidades.length - 2);
                  //       flatEspecialidades = flatEspecialidades + '.';
                  //       return buildDoctor(doctor, flatEspecialidades);
                  //     }
                  //   default:
                  //     return Center(
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           Text('No se encontraron resultados para: "$query"',
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(fontSize: 20),),
                  //         ],
                  //       ),
                  //     );
                  // }
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Buscar doctores por especialidad',
        onChanged: searchDoctor,
      );

  Future searchDoctor(String query) async => debounce(() async {
        final doctors = await DoctorsApi.getDoctores(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          {
            if (doctors != null) {
              this.doctors = doctors;
              isNull = false;
            } else {
              this.doctors = [];
              isNull = true;
            }
          }
        });
      });

  Widget buildDoctor(Doctor doctor, String especialidades) => ListTile(
        leading: CircleAvatar(
          child: ClipRRect(
            child: Image.asset('assets/images/' + doctor.foto),
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        title: doctor.sexo == 'M'
            ? Text('Dr. ' + doctor.p_nombre + ' ' + doctor.p_apellido)
            : Text('Dra. ' + doctor.p_nombre + ' ' + doctor.p_apellido),
        subtitle: Text(especialidades),
      );
}
