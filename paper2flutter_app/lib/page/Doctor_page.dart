// ignore_for_file: file_names

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
            const CircleAvatar(
              backgroundImage:  AssetImage('assets/images/media/hombre1.jpg'),
              radius: 80,
            ),
            const SizedBox(height: 40),
            Text(
              doctor.p_apellido,
              style: const TextStyle(
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