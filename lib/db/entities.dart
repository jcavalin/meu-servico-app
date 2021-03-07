import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'feriados-init.dart';

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

  TextColumn get grupo => text()();
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

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
      beforeOpen: (details) async {
        if (details.wasCreated) {
          FeriadosInit.get()
              .forEach((feriado) => into(feriados).insert(feriado));
        }
      });

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
  Stream<List<Servico>> getServicos() => select(servicos).watch();

  Stream<List<Servico>> getServicosByDate(DateTime data) =>
      (select(servicos)..where((t) => t.data.equals(data))).watch();

  Future<Servico> getServico(int id) =>
      (select(servicos)..where((t) => t.id.equals(id))).getSingle();

  Future insertServico(Servico servico) => into(servicos).insert(servico);

  Future updateServico(Servico servico) => update(servicos).replace(servico);

  Future deleteServico(Servico servico) => delete(servicos).delete(servico);
// Serviço
}
