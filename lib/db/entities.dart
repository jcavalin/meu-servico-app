import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

// flutter packages pub run build_runner build
part 'entities.g.dart';

class Feriados extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get data => dateTime()();

  TextColumn get descricao => text()();
}

class Servicos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nome => text()();

  IntColumn get folga => integer()();

  DateTimeColumn get data => dateTime()();

  TextColumn get tipo => text()();

  IntColumn get grupo => integer()();
}

@UseMoor(tables: [Feriados, Servicos])
class Database extends _$Database {
  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "meu_servico.sqlite", logStatements: true));

  int get schemaVersion => 1;

  // Feriado
  Future<List<Feriado>> allFeriados() => select(feriados).get();

  Stream<List<Feriado>> watchFeriados() => select(feriados).watch();

  Future insertFeriado(Feriado feriado) => into(feriados).insert(feriado);

  Future updateFeriado(Feriado feriado) => update(feriados).replace(feriado);

  Future deleteFeriado(Feriado feriado) => delete(feriados).delete(feriado);

  // Feriado

  // Serviço
  Future<List<Servico>> allServicos() => select(servicos).get();

  Stream<List<Servico>> watchServicos() => select(servicos).watch();

  Future insertServico(Servico servico) => into(servicos).insert(servico);

  Future updateServico(Servico servico) => update(servicos).replace(servico);

  Future deleteServico(Servico servico) => delete(servicos).delete(servico);
// Serviço
}
