import 'package:flutter/material.dart';
import 'package:meu_servico_app/pages/feriado.dart';

class FeriadosPage extends StatelessWidget {
  final List<MessageItem> items = List<MessageItem>.generate(
      10,
      (i) => MessageItem(
          sender: "01/01/2018", body: "Confraternização Universal $i", id: i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

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
  final String sender;
  final String body;
  final int id;

  MessageItem({this.sender, this.body, this.id});

  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) => Text(body);
}
