import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ServicoPage extends StatefulWidget {
  final int id;

  ServicoPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ServicoState(this.id);
  }
}

class ServicoState extends State<ServicoPage> {
  final int id;
  DateTime selectedDate;
  TextEditingController _controller;
  String radioButtonItem = 'ONE';
  int radioValue = 1;

  ServicoState(this.id);

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
        title: Text("Servico"),
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
                  decoration: InputDecoration(labelText: 'Nome da pessoa'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o nome da pessoa';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Quantidade de dias de folga'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe a quantidade de dias de folga';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Data',
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
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('Tipo', style: new TextStyle(fontSize: 16.0)),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      margin: EdgeInsets.only(right: 10),
                      child: Radio(
                        value: 1,
                        groupValue: radioValue,
                        onChanged: (val) {
                          setState(() {
                            radioValue = 1;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            radioValue = 1;
                          });
                        },
                        child: Text('Preta')),
                    Radio(
                      value: 2,
                      groupValue: radioValue,
                      onChanged: (val) {
                        setState(() {
                          radioValue = 2;
                        });
                      },
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            radioValue = 2;
                          });
                        },
                        child: Text('Vermelha')),
                    Radio(
                      value: 3,
                      groupValue: radioValue,
                      onChanged: (val) {
                        setState(() {
                          radioValue = 3;
                        });
                      },
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            radioValue = 3;
                          });
                        },
                        child: Text('Corrida')),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('Calcular próximos serviços?',
                      style: new TextStyle(fontSize: 16.0)),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      margin: EdgeInsets.only(right: 10),
                      child: Radio(
                        value: 1,
                        groupValue: radioValue,
                        onChanged: (val) {
                          setState(() {
                            radioValue = 1;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            radioValue = 1;
                          });
                        },
                        child: Text('Sim')),
                    Radio(
                      value: 2,
                      groupValue: radioValue,
                      onChanged: (val) {
                        setState(() {
                          radioValue = 2;
                        });
                      },
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            radioValue = 2;
                          });
                        },
                        child: Text('Não')),
                  ],
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
                                  ? "Incluir serviço"
                                  : "Alterar serviço")
                            ],
                          ))),
                ),
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
    );
  }
}
