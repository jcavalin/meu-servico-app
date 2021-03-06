import 'package:meu_servico_app/db/entities.dart';

class FeriadoService {
  final Database db = Database.get();

  Feriado save(Feriado feriado) {
    feriado.id == null ? db.insertFeriado(feriado) : db.updateFeriado(feriado);
    return feriado;
  }

  void delete(int id) => db.deleteFeriado(Feriado(id: id));

  Stream<List<Feriado>> list() => db.getFeriados();

  Future<Feriado> get(int id) => db.getFeriado(id);
}
