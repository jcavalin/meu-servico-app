import 'package:flutter/material.dart';

class FeriadosPage extends StatelessWidget {
  List<MessageItem> items = List<MessageItem>.generate(
      1000,
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
            title: item.buildTitle(context),
            subtitle: item.buildSubtitle(context),
            onTap: () => Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("onTap ${item.id}"))));
      },
    ));
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
