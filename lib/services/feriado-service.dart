import 'package:meu_servico_app/db/entities.dart';

class FeriadoService {
  Feriado save(Feriado feriado) {
    feriado.id == null
        ? Database().insertFeriado(feriado)
        : Database().updateFeriado(feriado);

    return feriado;
  }
}
