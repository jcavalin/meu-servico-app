import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meu_servico_app/pages/feriado.dart';
import 'package:meu_servico_app/services/feriado-service.dart';

class FeriadosPage extends StatefulWidget {
  @override
  FeriadosState createState() => new FeriadosState();
}

class FeriadosState extends State<FeriadosPage> {
  final service = FeriadoService();
  final dateFormat = DateFormat('dd/MM/yyyy');
  List<MessageItem> list = [];

  @override
  void initState() {
    service.list().forEach((feriados) {
      List<MessageItem> items = [];

      feriados.forEach((feriado) => items.add(MessageItem(
          data: dateFormat.format(feriado.data),
          descricao: feriado.descricao,
          id: feriado.id)));

      setState(() => list = items);
    });

    super.initState();
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];

          return ListTile(
            leading: Icon(Icons.calendar_today_outlined),
            title: item.buildTitle(context),
            subtitle: item.buildSubtitle(context),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeriadoPage(id: item.id))),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FeriadoPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class MessageItem {
  final String data;
  final String descricao;
  final int id;

  MessageItem({this.data, this.descricao, this.id});

  Widget buildTitle(BuildContext context) => Text(data);

  Widget buildSubtitle(BuildContext context) => Text(descricao);
}
