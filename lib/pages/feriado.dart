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

  DateTime selectedDate;
  TextEditingController _datePickerController;
  TextEditingController _descricaoController;


  FeriadoState(this.id);

  @override
  void initState() {
    super.initState();
    _datePickerController = TextEditingController(text: '');
    _descricaoController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _datePickerController.dispose();
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
          final f = DateFormat('dd/MM/yyyy');
          _datePickerController.text = f.format(selectedDate);
        });
    }

    _save(BuildContext context) {
      if (_form.currentState.validate()) {
        service.save(Feriado(
            id: this.id,
            data: selectedDate,
            descricao: _descricaoController.text
        ));

        Navigator.pop(context);
      }
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
                  controller: _datePickerController,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
    );
  }
}
