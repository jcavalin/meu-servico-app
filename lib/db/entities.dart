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
  static Database db;

  static get() {
    if (db == null) {
      db = Database();
    }

    return db;
  }

  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "meu_servico.sqlite", logStatements: true));

  int get schemaVersion => 1;

  // Feriado
  Stream<List<Feriado>> getFeriados() => (select(feriados)
        ..orderBy(
            [(t) => OrderingTerm(expression: t.data, mode: OrderingMode.desc)]))
      .watch();

  Future<Feriado> getFeriado(int id) =>
      (select(feriados)..where((t) => t.id.equals(id))).getSingle();

  Future insertFeriado(Feriado feriado) => into(feriados).insert(feriado);

  Future updateFeriado(Feriado feriado) => update(feriados).replace(feriado);

  Future deleteFeriado(Feriado feriado) => delete(feriados).delete(feriado);

  // Feriado

  // Serviço
  Future<List<Servico>> getServicos() => select(servicos).get();

  Future insertServico(Servico servico) => into(servicos).insert(servico);

  Future updateServico(Servico servico) => update(servicos).replace(servico);

  Future deleteServico(Servico servico) => delete(servicos).delete(servico);
// Serviço
}
