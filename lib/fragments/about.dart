import 'package:flutter/material.dart';
import 'package:meu_servico_app/services/version-service.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/stormtrooper.png'),
                height: 180,
              ),
              new Container(
                height: 20,
              ),
              Center(
                  child: Text(
                'Meu serviço',
                style: TextStyle(fontSize: 25),
              )),
              Center(
                child: Text(
                  VersionService.get(),
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              new Container(
                height: 80,
              ),
              Image(
                image: AssetImage('assets/images/horsecode.png'),
                height: 50,
              ),
              new Container(
                height: 5,
              ),
              Center(
                child: Text(
                  'Horse Code',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ]),
      ),
    );
  }
}
