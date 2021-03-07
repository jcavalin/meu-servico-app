// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Feriado extends DataClass implements Insertable<Feriado> {
  final int id;
  final DateTime data;
  final String descricao;
  Feriado({@required this.id, @required this.data, @required this.descricao});
  factory Feriado.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return Feriado(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      data:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}data']),
      descricao: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}descricao']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || data != null) {
      map['data'] = Variable<DateTime>(data);
    }
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    return map;
  }

  FeriadosCompanion toCompanion(bool nullToAbsent) {
    return FeriadosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
    );
  }

  factory Feriado.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Feriado(
      id: serializer.fromJson<int>(json['id']),
      data: serializer.fromJson<DateTime>(json['data']),
      descricao: serializer.fromJson<String>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data': serializer.toJson<DateTime>(data),
      'descricao': serializer.toJson<String>(descricao),
    };
  }

  Feriado copyWith({int id, DateTime data, String descricao}) => Feriado(
        id: id ?? this.id,
        data: data ?? this.data,
        descricao: descricao ?? this.descricao,
      );
  @override
  String toString() {
    return (StringBuffer('Feriado(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(data.hashCode, descricao.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Feriado &&
          other.id == this.id &&
          other.data == this.data &&
          other.descricao == this.descricao);
}

class FeriadosCompanion extends UpdateCompanion<Feriado> {
  final Value<int> id;
  final Value<DateTime> data;
  final Value<String> descricao;
  const FeriadosCompanion({
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  FeriadosCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime data,
    @required String descricao,
  })  : data = Value(data),
        descricao = Value(descricao);
  static Insertable<Feriado> custom({
    Expression<int> id,
    Expression<DateTime> data,
    Expression<String> descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (descricao != null) 'descricao': descricao,
    });
  }

  FeriadosCompanion copyWith(
      {Value<int> id, Value<DateTime> data, Value<String> descricao}) {
    return FeriadosCompanion(
      id: id ?? this.id,
      data: data ?? this.data,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeriadosCompanion(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }
}

class $FeriadosTable extends Feriados with TableInfo<$FeriadosTable, Feriado> {
  final GeneratedDatabase _db;
  final String _alias;
  $FeriadosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dataMeta = const VerificationMeta('data');
  GeneratedDateTimeColumn _data;
  @override
  GeneratedDateTimeColumn get data => _data ??= _constructData();
  GeneratedDateTimeColumn _constructData() {
    return GeneratedDateTimeColumn(
      'data',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descricaoMeta = const VerificationMeta('descricao');
  GeneratedTextColumn _descricao;
  @override
  GeneratedTextColumn get descricao => _descricao ??= _constructDescricao();
  GeneratedTextColumn _constructDescricao() {
    return GeneratedTextColumn(
      'descricao',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, data, descricao];
  @override
  $FeriadosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'feriados';
  @override
  final String actualTableName = 'feriados';
  @override
  VerificationContext validateIntegrity(Insertable<Feriado> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data'], _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao'], _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Feriado map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Feriado.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FeriadosTable createAlias(String alias) {
    return $FeriadosTable(_db, alias);
  }
}

class Servico extends DataClass implements Insertable<Servico> {
  final int id;
  final String nome;
  final int folga;
  final DateTime data;
  final String tipo;
  final String grupo;
  Servico(
      {@required this.id,
      @required this.nome,
      @required this.folga,
      @required this.data,
      @required this.tipo,
      @required this.grupo});
  factory Servico.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Servico(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nome: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      folga: intType.mapFromDatabaseResponse(data['${effectivePrefix}folga']),
      data:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}data']),
      tipo: stringType.mapFromDatabaseResponse(data['${effectivePrefix}tipo']),
      grupo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}grupo']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String>(nome);
    }
    if (!nullToAbsent || folga != null) {
      map['folga'] = Variable<int>(folga);
    }
    if (!nullToAbsent || data != null) {
      map['data'] = Variable<DateTime>(data);
    }
    if (!nullToAbsent || tipo != null) {
      map['tipo'] = Variable<String>(tipo);
    }
    if (!nullToAbsent || grupo != null) {
      map['grupo'] = Variable<String>(grupo);
    }
    return map;
  }

  ServicosCompanion toCompanion(bool nullToAbsent) {
    return ServicosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      folga:
          folga == null && nullToAbsent ? const Value.absent() : Value(folga),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
      tipo: tipo == null && nullToAbsent ? const Value.absent() : Value(tipo),
      grupo:
          grupo == null && nullToAbsent ? const Value.absent() : Value(grupo),
    );
  }

  factory Servico.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Servico(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      folga: serializer.fromJson<int>(json['folga']),
      data: serializer.fromJson<DateTime>(json['data']),
      tipo: serializer.fromJson<String>(json['tipo']),
      grupo: serializer.fromJson<String>(json['grupo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'folga': serializer.toJson<int>(folga),
      'data': serializer.toJson<DateTime>(data),
      'tipo': serializer.toJson<String>(tipo),
      'grupo': serializer.toJson<String>(grupo),
    };
  }

  Servico copyWith(
          {int id,
          String nome,
          int folga,
          DateTime data,
          String tipo,
          String grupo}) =>
      Servico(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        folga: folga ?? this.folga,
        data: data ?? this.data,
        tipo: tipo ?? this.tipo,
        grupo: grupo ?? this.grupo,
      );
  @override
  String toString() {
    return (StringBuffer('Servico(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('folga: $folga, ')
          ..write('data: $data, ')
          ..write('tipo: $tipo, ')
          ..write('grupo: $grupo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          nome.hashCode,
          $mrjc(folga.hashCode,
              $mrjc(data.hashCode, $mrjc(tipo.hashCode, grupo.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Servico &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.folga == this.folga &&
          other.data == this.data &&
          other.tipo == this.tipo &&
          other.grupo == this.grupo);
}

class ServicosCompanion extends UpdateCompanion<Servico> {
  final Value<int> id;
  final Value<String> nome;
  final Value<int> folga;
  final Value<DateTime> data;
  final Value<String> tipo;
  final Value<String> grupo;
  const ServicosCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.folga = const Value.absent(),
    this.data = const Value.absent(),
    this.tipo = const Value.absent(),
    this.grupo = const Value.absent(),
  });
  ServicosCompanion.insert({
    this.id = const Value.absent(),
    @required String nome,
    @required int folga,
    @required DateTime data,
    @required String tipo,
    @required String grupo,
  })  : nome = Value(nome),
        folga = Value(folga),
        data = Value(data),
        tipo = Value(tipo),
        grupo = Value(grupo);
  static Insertable<Servico> custom({
    Expression<int> id,
    Expression<String> nome,
    Expression<int> folga,
    Expression<DateTime> data,
    Expression<String> tipo,
    Expression<String> grupo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (folga != null) 'folga': folga,
      if (data != null) 'data': data,
      if (tipo != null) 'tipo': tipo,
      if (grupo != null) 'grupo': grupo,
    });
  }

  ServicosCompanion copyWith(
      {Value<int> id,
      Value<String> nome,
      Value<int> folga,
      Value<DateTime> data,
      Value<String> tipo,
      Value<String> grupo}) {
    return ServicosCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      folga: folga ?? this.folga,
      data: data ?? this.data,
      tipo: tipo ?? this.tipo,
      grupo: grupo ?? this.grupo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (folga.present) {
      map['folga'] = Variable<int>(folga.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (grupo.present) {
      map['grupo'] = Variable<String>(grupo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicosCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('folga: $folga, ')
          ..write('data: $data, ')
          ..write('tipo: $tipo, ')
          ..write('grupo: $grupo')
          ..write(')'))
        .toString();
  }
}

class $ServicosTable extends Servicos with TableInfo<$ServicosTable, Servico> {
  final GeneratedDatabase _db;
  final String _alias;
  $ServicosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  GeneratedTextColumn _nome;
  @override
  GeneratedTextColumn get nome => _nome ??= _constructNome();
  GeneratedTextColumn _constructNome() {
    return GeneratedTextColumn(
      'nome',
      $tableName,
      false,
    );
  }

  final VerificationMeta _folgaMeta = const VerificationMeta('folga');
  GeneratedIntColumn _folga;
  @override
  GeneratedIntColumn get folga => _folga ??= _constructFolga();
  GeneratedIntColumn _constructFolga() {
    return GeneratedIntColumn(
      'folga',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dataMeta = const VerificationMeta('data');
  GeneratedDateTimeColumn _data;
  @override
  GeneratedDateTimeColumn get data => _data ??= _constructData();
  GeneratedDateTimeColumn _constructData() {
    return GeneratedDateTimeColumn(
      'data',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  GeneratedTextColumn _tipo;
  @override
  GeneratedTextColumn get tipo => _tipo ??= _constructTipo();
  GeneratedTextColumn _constructTipo() {
    return GeneratedTextColumn(
      'tipo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _grupoMeta = const VerificationMeta('grupo');
  GeneratedTextColumn _grupo;
  @override
  GeneratedTextColumn get grupo => _grupo ??= _constructGrupo();
  GeneratedTextColumn _constructGrupo() {
    return GeneratedTextColumn(
      'grupo',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, nome, folga, data, tipo, grupo];
  @override
  $ServicosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'servicos';
  @override
  final String actualTableName = 'servicos';
  @override
  VerificationContext validateIntegrity(Insertable<Servico> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome'], _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('folga')) {
      context.handle(
          _folgaMeta, folga.isAcceptableOrUnknown(data['folga'], _folgaMeta));
    } else if (isInserting) {
      context.missing(_folgaMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data'], _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo'], _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('grupo')) {
      context.handle(
          _grupoMeta, grupo.isAcceptableOrUnknown(data['grupo'], _grupoMeta));
    } else if (isInserting) {
      context.missing(_grupoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Servico map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Servico.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ServicosTable createAlias(String alias) {
    return $ServicosTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $FeriadosTable _feriados;
  $FeriadosTable get feriados => _feriados ??= $FeriadosTable(this);
  $ServicosTable _servicos;
  $ServicosTable get servicos => _servicos ??= $ServicosTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [feriados, servicos];
}
