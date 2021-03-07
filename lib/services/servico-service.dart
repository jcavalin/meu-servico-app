import 'package:meu_servico_app/db/entities.dart';
import 'package:uuid/uuid.dart';

class ServicoService {
  final Database db = Database.get();

  Servico save(
      {int id,
      String nome,
      int folga,
      DateTime data,
      String tipo,
      String grupo,
      bool calcularProximos}) {
    grupo = grupo == null ? Uuid().v1() : grupo;
    Servico servico = Servico(
        id: id,
        nome: nome,
        folga: folga,
        data: DateTime(data.year, data.month, data.day),
        tipo: tipo,
        grupo: grupo);

    id == null ? db.insertServico(servico) : db.updateServico(servico);

    if (calcularProximos) {
      this.calcularProximos(servico);
    }

    return servico;
  }

  void delete(int id, bool excluirProximos) =>
      db.deleteServico(Servico(id: id));

  Stream<List<Servico>> list() => db.getServicos();

  Stream<List<Servico>> listByDate(DateTime data) =>
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

  void calcularProximos(Servico servico) {
    // ... calcular
  }
}
