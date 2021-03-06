import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeriadoPage extends StatefulWidget {
  final int id;

  FeriadoPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new FeriadoState(this.id);
  }
}

class FeriadoState extends State<FeriadoPage> {
  final int id;
  DateTime selectedDate;
  TextEditingController _controller;

  FeriadoState(this.id);

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate != null ? selectedDate : DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          final f = new DateFormat('dd/MM/yyyy');
          _controller.text = f.format(selectedDate);
          // _controller.text = "${selectedDate.toLocal()}".split(' ')[0];
        });
    }

    return new Scaffold(
        appBar: new AppBar(
          // here we display the title corresponding to the fragment
          // you can instead choose to have a static title
          title: Text("Feriado"),
        ),
        body: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Data do feriado',
                      suffixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    readOnly: true,
                    controller: _controller,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe a data';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Descrição'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe a descrição';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ButtonTheme(
                        child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("save")));
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add),
                                Text(this.id == null
                                    ? "Incluir feriado"
                                    : "Alterar feriado")
                              ],
                            ))),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
