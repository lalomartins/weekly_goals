// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String type;
  final String name;
  final String description;
  final DateTime timestamp;
  final bool realTime;
  final String additional;
  Event(
      {@required this.id,
      @required this.type,
      @required this.name,
      @required this.description,
      @required this.timestamp,
      @required this.realTime,
      @required this.additional});
  factory Event.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Event(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      timestamp: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
      realTime:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}real_time']),
      additional: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}additional']),
    );
  }
  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      realTime: serializer.fromJson<bool>(json['realTime']),
      additional: serializer.fromJson<String>(json['additional']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'realTime': serializer.toJson<bool>(realTime),
      'additional': serializer.toJson<String>(additional),
    };
  }

  @override
  EventsCompanion createCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
      realTime: realTime == null && nullToAbsent
          ? const Value.absent()
          : Value(realTime),
      additional: additional == null && nullToAbsent
          ? const Value.absent()
          : Value(additional),
    );
  }

  Event copyWith(
          {int id,
          String type,
          String name,
          String description,
          DateTime timestamp,
          bool realTime,
          String additional}) =>
      Event(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        description: description ?? this.description,
        timestamp: timestamp ?? this.timestamp,
        realTime: realTime ?? this.realTime,
        additional: additional ?? this.additional,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('timestamp: $timestamp, ')
          ..write('realTime: $realTime, ')
          ..write('additional: $additional')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          type.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(timestamp.hashCode,
                      $mrjc(realTime.hashCode, additional.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.description == this.description &&
          other.timestamp == this.timestamp &&
          other.realTime == this.realTime &&
          other.additional == this.additional);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> timestamp;
  final Value<bool> realTime;
  final Value<String> additional;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.realTime = const Value.absent(),
    this.additional = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    @required String type,
    @required String name,
    this.description = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.realTime = const Value.absent(),
    this.additional = const Value.absent(),
  })  : type = Value(type),
        name = Value(name);
  EventsCompanion copyWith(
      {Value<int> id,
      Value<String> type,
      Value<String> name,
      Value<String> description,
      Value<DateTime> timestamp,
      Value<bool> realTime,
      Value<String> additional}) {
    return EventsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      realTime: realTime ?? this.realTime,
      additional: additional ?? this.additional,
    );
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        defaultValue: Constant(''));
  }

  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  GeneratedDateTimeColumn _timestamp;
  @override
  GeneratedDateTimeColumn get timestamp => _timestamp ??= _constructTimestamp();
  GeneratedDateTimeColumn _constructTimestamp() {
    return GeneratedDateTimeColumn(
      'timestamp',
      $tableName,
      false,
    )..clientDefault = () => DateTime.now();
  }

  final VerificationMeta _realTimeMeta = const VerificationMeta('realTime');
  GeneratedBoolColumn _realTime;
  @override
  GeneratedBoolColumn get realTime => _realTime ??= _constructRealTime();
  GeneratedBoolColumn _constructRealTime() {
    return GeneratedBoolColumn('real_time', $tableName, false,
        defaultValue: Constant(true));
  }

  final VerificationMeta _additionalMeta = const VerificationMeta('additional');
  GeneratedTextColumn _additional;
  @override
  GeneratedTextColumn get additional => _additional ??= _constructAdditional();
  GeneratedTextColumn _constructAdditional() {
    return GeneratedTextColumn('additional', $tableName, false,
        defaultValue: Constant(''));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, type, name, description, timestamp, realTime, additional];
  @override
  $EventsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'events';
  @override
  final String actualTableName = 'events';
  @override
  VerificationContext validateIntegrity(EventsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    }
    if (d.timestamp.present) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableValue(d.timestamp.value, _timestampMeta));
    }
    if (d.realTime.present) {
      context.handle(_realTimeMeta,
          realTime.isAcceptableValue(d.realTime.value, _realTimeMeta));
    }
    if (d.additional.present) {
      context.handle(_additionalMeta,
          additional.isAcceptableValue(d.additional.value, _additionalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Event.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(EventsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.type.present) {
      map['type'] = Variable<String, StringType>(d.type.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.timestamp.present) {
      map['timestamp'] = Variable<DateTime, DateTimeType>(d.timestamp.value);
    }
    if (d.realTime.present) {
      map['real_time'] = Variable<bool, BoolType>(d.realTime.value);
    }
    if (d.additional.present) {
      map['additional'] = Variable<String, StringType>(d.additional.value);
    }
    return map;
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(_db, alias);
  }
}

abstract class _$EventDatabase extends GeneratedDatabase {
  _$EventDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $EventsTable _events;
  $EventsTable get events => _events ??= $EventsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [events];
}
