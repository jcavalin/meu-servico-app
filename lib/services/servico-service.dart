import 'package:meu_servico_app/db/entities.dart';
import 'package:uuid/uuid.dart';

class ServicoService {
  final Database db = Database.get();

  Future<Servico> save(
      {int id,
      String nome,
      int folga,
      DateTime data,
      String tipo,
      String grupo,
      bool saveNext}) async {
    grupo = grupo == null ? Uuid().v1() : grupo;

    Servico servico = Servico(
        id: id,
        nome: nome,
        folga: folga,
        data: DateTime(data.year, data.month, data.day),
        tipo: tipo,
        grupo: grupo);

    if (saveNext) {
      await this.saveNext(servico);
      return servico;
    }

    id == null ? db.insertServico(servico) : db.updateServico(servico);
    return servico;
  }

  Future delete(int id, bool excluirProximos) async {
    if (excluirProximos) {
      await this.deleteNext(id);
      return;
    }

    await db.deleteServico(Servico(
        id: id, nome: null, folga: null, data: null, tipo: null, grupo: null));
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

  Servico createService(Servico servico, DateTime data) => Servico(
      id: null,
      nome: servico.nome,
      folga: servico.folga,
      data: data,
      tipo: servico.tipo,
      grupo: servico.grupo);

  Future<void> saveNext(Servico servico) async {
    await db.deleteServicosByGrupo(servico.grupo);
    final DateTime finalDate =
        DateTime(servico.data.year, servico.data.month, servico.data.day)
            .add(Duration(days: 365));

    Servico lastServico = createService(servico, servico.data);
    await db.insertServico(lastServico);

    List<DateTime> holidays =
        await db.getFeriadosByPeriod(servico.data, finalDate);

    while (finalDate.isAfter(lastServico.data)) {
      lastServico =
          createService(lastServico, calcNextDate(lastServico, holidays));
      await db.insertServico(lastServico);
    }
  }

  bool isWeekendOrHoliday(DateTime date, List<DateTime> holidays) {
    if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      return true;
    }

    return holidays.contains(date);
  }

  Future<bool> isDateWeekendOrHoliday(DateTime date) async {
    if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      return true;
    }

    List<DateTime> holidays = await db.getFeriadosByPeriod(date, date);
    return holidays.contains(date);
  }

  DateTime calcCorrida(Servico servico) =>
      DateTime(servico.data.year, servico.data.month, servico.data.day)
          .add(Duration(days: servico.folga + 1));

  DateTime calcPreta(Servico servico, List<DateTime> holidays) {
    int days = 1;
    DateTime date =
        DateTime(servico.data.year, servico.data.month, servico.data.day)
            .add(Duration(days: 1));

    while (days <= servico.folga || isWeekendOrHoliday(date, holidays)) {
      if (!isWeekendOrHoliday(date, holidays)) {
        days++;
      }

      date = DateTime(date.year, date.month, date.day).add(Duration(days: 1));
    }

    return date;
  }

  DateTime calcVermelha(Servico servico, List<DateTime> holidays) {
    int days = 1;
    DateTime date =
        DateTime(servico.data.year, servico.data.month, servico.data.day)
            .add(Duration(days: 1));

    while (days <= servico.folga || !isWeekendOrHoliday(date, holidays)) {
      if (isWeekendOrHoliday(date, holidays)) {
        days++;
      }
      date = DateTime(date.year, date.month, date.day).add(Duration(days: 1));
    }

    return date;
  }

  DateTime calcNextDate(Servico servico, List<DateTime> holidays) {
    DateTime nextDate;

    switch (servico.tipo) {
      case 'preta':
        nextDate = calcPreta(servico, holidays);
        break;
      case 'vermelha':
        nextDate = calcVermelha(servico, holidays);
        break;
      case 'corrida':
        nextDate = calcCorrida(servico);
        break;
    }

    return nextDate;
  }
}
