import 'package:flutter/material.dart';
import 'package:meu_servico_app/pages/home.dart';

void main() => runApp(MeuServicoApp());

class MeuServicoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu serviço',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: Routes.initial(),
      // routes: Routes.get(),
      home: HomePage(),
    );
  }
}
