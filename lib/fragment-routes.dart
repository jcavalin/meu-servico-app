import 'package:flutter/material.dart';
import 'package:meu_servico_app/fragment/feriados.dart';
import 'package:meu_servico_app/fragment/servicos.dart';

class FragmentRoutes {
  static get() {
    return [
      {
        'title': 'Serviços',
        'fragment': () {
          return ServicosPage();
        },
        'icon': Icons.person_pin_rounded
      },
      {
        'title': 'Feriados',
        'fragment': () {
          return FeriadosPage();
        },
        'icon': Icons.calendar_today_outlined
      }
    ];
  }
}
