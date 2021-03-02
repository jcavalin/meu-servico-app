import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
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
          ListTile(
            leading: Icon(Icons.person_pin_rounded),
            title: Text('Serviços'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.calendar_today_outlined),
            title: Text('Feriados'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.import_export),
            title: Text('Importar/Exportar'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}