import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meu_servico_app/fragment-routes.dart';
import 'package:meu_servico_app/fragment/feriados.dart';
import 'package:meu_servico_app/fragment/servicos.dart';

class DrawerItem {
  String title;
  IconData icon;
  Function fragment;

  DrawerItem(this.title, this.fragment, this.icon);
}

class HomePage extends StatefulWidget {
  static drawerItems() {
    // var itens = [];
    //
    // FragmentRoutes.get().forEach((route) {
    //   itens.add(new DrawerItem(route.title, route.fragment, route.icon));
    // });
    //
    // return itens;

    return [
      new DrawerItem('Serviços', () {
        return new ServicosPage();
      }, Icons.person_pin_rounded),
      new DrawerItem('Feriados', () {
        return new FeriadosPage();
      }, Icons.calendar_today_outlined),
      new DrawerItem('Importar/Exportar', () {
        return new FeriadosPage();
      }, Icons.import_export),
    ];
  }

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  DrawerItem _selectedDrawer = HomePage.drawerItems()[0];

  _getDrawerItemWidget(DrawerItem item) {
    return item.fragment();
  }

  _onSelectItem(DrawerItem item) {
    setState(() => _selectedDrawer = item);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < HomePage.drawerItems().length; i++) {
      var d = HomePage.drawerItems()[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: d.title == _selectedDrawer.title,
        onTap: () => _onSelectItem(d),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(_selectedDrawer.title),
      ),
      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Meu serviço',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: AssetImage('assets/images/stormtrooper.png'))),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawer),
    );
  }
}
