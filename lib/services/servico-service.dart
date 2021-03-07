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
        id: id, nome: nome, folga: folga, data: data, tipo: tipo, grupo: grupo);

    id == null ? db.insertServico(servico) : db.updateServico(servico);

    if(calcularProximos) {
      this.calcularProximos(servico);
    }

    return servico;
  }

  void delete(int id) => db.deleteServico(Servico(id: id));

  Stream<List<Servico>> list() => db.getServicos();

  Future<Servico> get(int id) => db.getServico(id);

  String getTipoByNumber(int number) {
    Map tipos = {
      1: 'preta',
      2: 'vermelha',
      3: 'corrida',
    };

    return tipos[number];
  }

  void calcularProximos(Servico servico) {
    // ... calcular
  }
}
