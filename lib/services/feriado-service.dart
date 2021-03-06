import 'package:meu_servico_app/db/entities.dart';

class FeriadoService {
  final Database db = Database.get();

  Feriado save(Feriado feriado) {
    feriado.id == null ? db.insertFeriado(feriado) : db.updateFeriado(feriado);
    return feriado;
  }

  Stream<List<Feriado>> list() => db.getFeriados();

  Stream<Feriado> get(int id) => db.getFeriado(id);
}
