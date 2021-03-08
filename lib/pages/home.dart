import 'package:flutter/material.dart';
import 'package:meu_servico_app/f-routes.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  Item _selectedDrawer = FragmentRoutes.first();

  _getItemWidget(Item item) {
    return item.fragment();
  }

  _onSelectItem(Item item) {
    setState(() => _selectedDrawer = item);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < FragmentRoutes.all().length; i++) {
      var d = FragmentRoutes.get(i);
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
              child: Column(children: <Widget>[
                Image(
                  image: AssetImage('assets/images/stormtrooper.png'),
                  width: 80,
                ),
                Text(
                  'Meu serviço',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Text(
                  'v1.0.0',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ]),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getItemWidget(_selectedDrawer),
    );
  }
}
