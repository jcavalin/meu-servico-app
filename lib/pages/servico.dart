import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meu_servico_app/db/entities.dart';
import 'package:meu_servico_app/services/servico-service.dart';

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
  final service = ServicoService();
  final dateFormat = DateFormat('dd/MM/yyyy');

  DateTime dataSelected;
  TextEditingController nomeController = new TextEditingController(text: '');
  TextEditingController folgaController = new TextEditingController(text: '');
  TextEditingController dataController = new TextEditingController(text: '');
  int tipo = 1;
  int calcularProximos = 0;
  String grupo;

  ServicoState(this.id);

  @override
  void initState() {
    super.initState();

    if (this.id != null) {}
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    folgaController.dispose();
    dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();

    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dataSelected != null ? dataSelected : DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2090),
      );
      if (picked != null && picked != dataSelected)
        setState(() {
          dataSelected = picked;
          dataController.text = dateFormat.format(dataSelected);
        });
    }

    _save(BuildContext context) {
      if (_form.currentState.validate()) {
        service.save(
            id: this.id,
            nome: nomeController.text,
            folga: int.parse(folgaController.text),
            data: dataSelected,
            tipo: service.getTipoByNumber(tipo),
            grupo: grupo,
            calcularProximos: calcularProximos == 1);

        Navigator.pop(context);
      }
    }

    return new Scaffold(
        appBar: new AppBar(
          title: Text("Serviço"),
        ),
        body: ListView(children: <Widget>[
          Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Nome da pessoa'),
                      controller: nomeController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe o nome da pessoa';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Quantidade de dias de folga'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: folgaController,
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
                      controller: dataController,
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
                            groupValue: tipo,
                            onChanged: (val) => setState(() => tipo = val),
                          ),
                        ),
                        GestureDetector(
                            onTap: () => setState(() => tipo = 1),
                            child: Text('Preta')),
                        Radio(
                          value: 2,
                          groupValue: tipo,
                          onChanged: (val) => setState(() => tipo = val),
                        ),
                        GestureDetector(
                            onTap: () => setState(() => tipo = 2),
                            child: Text('Vermelha')),
                        Radio(
                          value: 3,
                          groupValue: tipo,
                          onChanged: (val) => setState(() => tipo = val),
                        ),
                        GestureDetector(
                            onTap: () => setState(() => tipo = 3),
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
                            groupValue: calcularProximos,
                            onChanged: (val) =>
                                setState(() => calcularProximos = val),
                          ),
                        ),
                        GestureDetector(
                            onTap: () => setState(() => calcularProximos = 1),
                            child: Text('Sim')),
                        Radio(
                          value: 0,
                          groupValue: calcularProximos,
                          onChanged: (val) =>
                              setState(() => calcularProximos = val),
                        ),
                        GestureDetector(
                            onTap: () => setState(() => calcularProximos = 0),
                            child: Text('Não')),
                      ],
                    ),
                    Builder(
                      builder: (btnContext) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ButtonTheme(
                            child: ElevatedButton(
                                onPressed: () => _save(btnContext),
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
                    )
                  ],
                ),
              ),
            ),
          ]),
        ]),
        floatingActionButton: Visibility(
          visible: this.id != null,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
          ),
        ));
  }
}
