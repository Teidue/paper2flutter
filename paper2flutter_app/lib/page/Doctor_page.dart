import 'package:flutter/material.dart';
import '../models/doctor/doctor.dart';

class DoctorPage extends StatelessWidget {
  
  final Doctor doctor;

  const DoctorPage({
    Key? key,
    required this.doctor
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.p_nombre + ' ' + doctor.p_apellido),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage:  AssetImage('../assets/images/' + doctor.foto),
              radius: 80,
            ),
            const SizedBox(height: 40),
            Text(
              doctor.p_apellido,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 64)
          ],
        ),
      ),
    );
  }
}