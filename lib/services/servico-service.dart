import 'package:meu_servico_app/db/entities.dart';
import 'package:uuid/uuid.dart';

class ServicoService {
  final Database db = Database.get();

  Servico save({int id,
    String nome,
    int folga,
    DateTime data,
    String tipo,
    String grupo,
    bool saveNext}) {
    grupo = grupo == null ? Uuid().v1() : grupo;

    Servico servico = Servico(
        id: id,
        nome: nome,
        folga: folga,
        data: DateTime(data.year, data.month, data.day),
        tipo: tipo,
        grupo: grupo);

    if (saveNext) {
      this.saveNext(servico);
      return servico;
    }

    id == null ? db.insertServico(servico) : db.updateServico(servico);
    return servico;
  }

  void delete(int id, bool excluirProximos) async {
    if (excluirProximos) {
      this.deleteNext(id);
      return;
    }

    await db.deleteServico(Servico(id: id));
  }

  Future<void> deleteNext(int id) async {
    Servico servico = await this.get(id);
    await db.deleteNextServicos(servico);
  }

  Stream<List<Servico>> list() => db.getServicos();

  Future<List<Servico>> listByDate(DateTime data) =>
      db.getServicosByDate(DateTime(data.year, data.month, data.day));

  Future<Servico> get(int id) => db.getServico(id);

  String getTipoByNumber(int number) {
    Map tipos = {
      1: 'preta',
      2: 'vermelha',
      3: 'corrida',
    };

    return tipos[number];
  }

  int getNumberByTipo(String tipo) {
    Map tipos = {
      'preta': 1,
      'vermelha': 2,
      'corrida': 3,
    };

    return tipos[tipo];
  }

  void saveNext(Servico servico) async {
    await db.deleteServicosByGrupo(servico.grupo);
    final DateTime finalDate =
    DateTime(servico.data.year, servico.data.month, servico.data.day)
        .add(Duration(days: 365));

    Servico createService(Servico servico, DateTime data) =>
        Servico(
            id: null,
            nome: servico.nome,
            folga: servico.folga,
            data: data,
            tipo: servico.tipo,
            grupo: servico.grupo);

    Servico lastServico = servico;
    db.insertServico(lastServico);

    while (finalDate.isAfter(lastServico.data)) {
      lastServico = createService(lastServico, calcNextDate(lastServico));
      db.insertServico(lastServico);
    }
  }

  DateTime calcNextDate(Servico servico) {
    DateTime calcCorrida(Servico servico) =>
        DateTime(servico.data.year, servico.data.month, servico.data.day)
            .add(Duration(days: servico.folga + 1));

    return calcCorrida(servico);
  }
}
