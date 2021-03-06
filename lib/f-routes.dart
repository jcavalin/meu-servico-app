import 'package:flutter/material.dart';
import 'package:meu_servico_app/fragments/feriados.dart';
import 'package:meu_servico_app/fragments/servicos.dart';

class Item {
  String title;
  IconData icon;
  Function fragment;

  Item(this.title, this.fragment, this.icon);
}

class FragmentRoutes {
  static first() {
    return get(0);
  }

  static get(int index) {
    return all()[index];
  }

  static all() {
    return [
      new Item('Serviços', () {
        return new ServicosPage();
      }, Icons.person_pin_rounded),
      new Item('Feriados', () {
        return new FeriadosPage();
      }, Icons.calendar_today_outlined),
    ];
  }
}
