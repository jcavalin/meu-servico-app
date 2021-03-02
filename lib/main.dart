import 'package:flutter/material.dart';

import 'package:meu_servico_app/widgets/nav-drawer.dart';
import 'package:meu_servico_app/pages/servicos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu serviço',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Meu serviço'),
      ),
      body: ServicosPage(),
    );
  }
}