import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meu_servico_app/db/entities.dart';
import 'package:meu_servico_app/services/feriado-service.dart';

class FeriadoPage extends StatefulWidget {
  final int id;

  FeriadoPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FeriadoState(this.id);
  }
}

class FeriadoState extends State<FeriadoPage> {
  final int id;
  final service = FeriadoService();
  final dateFormat = DateFormat('dd/MM/yyyy');

  DateTime selectedDate;
  TextEditingController _dataController;
  TextEditingController _descricaoController;

  FeriadoState(this.id);

  @override
  void initState() {
    super.initState();
    _dataController = TextEditingController(text: '');
    _descricaoController = TextEditingController(text: '');

    if (this.id != null) {
      service.get(id).then((feriado) {
        setState(() {
          selectedDate = feriado.data;
          _descricaoController.text = feriado.descricao;
          _dataController.text = dateFormat.format(feriado.data);
        });
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _dataController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();

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
          _dataController.text = dateFormat.format(selectedDate);
        });
    }

    _save(BuildContext context) {
      if (_form.currentState.validate()) {
        service.save(Feriado(
            id: this.id,
            data: selectedDate,
            descricao: _descricaoController.text));

        Navigator.pop(context);
      }
    }

    _delete(BuildContext context) {
      service.delete(this.id);
      Navigator.of(context).popUntil((route) => route.isFirst);
    }

    showAlertDialog(BuildContext context) {
      // set up the buttons
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Excluir feriado"),
        content: Text("Deseja excluir este feriado?"),
        actions: [
          FlatButton(
            child: Text("Não"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Sim"),
            onPressed: () => _delete(context),
          ),
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => alert,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Feriado"),
      ),
      body: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Data do feriado',
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  readOnly: true,
                  controller: _dataController,
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
                  controller: _descricaoController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe a descrição';
                    }
                    return null;
                  },
                ),
                Builder(
                  builder: (context2) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ButtonTheme(
                        child: ElevatedButton(
                            onPressed: () => _save(context2),
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
                )
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: Visibility(
        visible: this.id != null,
        child: FloatingActionButton(
          onPressed: () => showAlertDialog(context),
          child: Icon(Icons.delete),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
