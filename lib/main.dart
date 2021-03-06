import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meu_servico_app/pages/home.dart';

void main() => runApp(MeuServicoApp());

class MeuServicoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('pt', 'BR')
      ],
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
