// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CachedGoal extends DataClass implements Insertable<CachedGoal> {
  final int id;
  final String name;
  final String category;
  final int perWeek;
  final bool dailyAmountMatters;
  CachedGoal(
      {@required this.id,
      @required this.name,
      @required this.category,
      this.perWeek,
      this.dailyAmountMatters});
  factory CachedGoal.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return CachedGoal(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      perWeek:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}per_week']),
      dailyAmountMatters: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}daily_amount_matters']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || perWeek != null) {
      map['per_week'] = Variable<int>(perWeek);
    }
    if (!nullToAbsent || dailyAmountMatters != null) {
      map['daily_amount_matters'] = Variable<bool>(dailyAmountMatters);
    }
    return map;
  }

  factory CachedGoal.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CachedGoal(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      perWeek: serializer.fromJson<int>(json['per_week']),
      dailyAmountMatters:
          serializer.fromJson<bool>(json['daily_amount_matters']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'per_week': serializer.toJson<int>(perWeek),
      'daily_amount_matters': serializer.toJson<bool>(dailyAmountMatters),
    };
  }

  CachedGoal copyWith(
          {int id,
          String name,
          String category,
          int perWeek,
          bool dailyAmountMatters}) =>
      CachedGoal(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        perWeek: perWeek ?? this.perWeek,
        dailyAmountMatters: dailyAmountMatters ?? this.dailyAmountMatters,
      );
  @override
  String toString() {
    return (StringBuffer('CachedGoal(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('perWeek: $perWeek, ')
          ..write('dailyAmountMatters: $dailyAmountMatters')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(category.hashCode,
              $mrjc(perWeek.hashCode, dailyAmountMatters.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CachedGoal &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.perWeek == this.perWeek &&
          other.dailyAmountMatters == this.dailyAmountMatters);
}

class CachedGoalsCompanion extends UpdateCompanion<CachedGoal> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<int> perWeek;
  final Value<bool> dailyAmountMatters;
  const CachedGoalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.perWeek = const Value.absent(),
    this.dailyAmountMatters = const Value.absent(),
  });
  CachedGoalsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String category,
    this.perWeek = const Value.absent(),
    this.dailyAmountMatters = const Value.absent(),
  })  : name = Value(name),
        category = Value(category);
  static Insertable<CachedGoal> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> category,
    Expression<int> perWeek,
    Expression<bool> dailyAmountMatters,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (perWeek != null) 'per_week': perWeek,
      if (dailyAmountMatters != null)
        'daily_amount_matters': dailyAmountMatters,
    });
  }

  CachedGoalsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> category,
      Value<int> perWeek,
      Value<bool> dailyAmountMatters}) {
    return CachedGoalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      perWeek: perWeek ?? this.perWeek,
      dailyAmountMatters: dailyAmountMatters ?? this.dailyAmountMatters,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (perWeek.present) {
      map['per_week'] = Variable<int>(perWeek.value);
    }
    if (dailyAmountMatters.present) {
      map['daily_amount_matters'] = Variable<bool>(dailyAmountMatters.value);
    }
    return map;
  }
}

class CachedGoals extends Table with TableInfo<CachedGoals, CachedGoal> {
  final GeneratedDatabase _db;
  final String _alias;
  CachedGoals(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        declaredAsPrimaryKey: true,
        hasAutoIncrement: true,
        $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        $customConstraints: 'NOT NULL');
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;
  GeneratedTextColumn get category => _category ??= _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn('category', $tableName, false,
        $customConstraints: 'NOT NULL');
  }

  final VerificationMeta _perWeekMeta = const VerificationMeta('perWeek');
  GeneratedIntColumn _perWeek;
  GeneratedIntColumn get perWeek => _perWeek ??= _constructPerWeek();
  GeneratedIntColumn _constructPerWeek() {
    return GeneratedIntColumn('per_week', $tableName, true,
        $customConstraints: '');
  }

  final VerificationMeta _dailyAmountMattersMeta =
      const VerificationMeta('dailyAmountMatters');
  GeneratedBoolColumn _dailyAmountMatters;
  GeneratedBoolColumn get dailyAmountMatters =>
      _dailyAmountMatters ??= _constructDailyAmountMatters();
  GeneratedBoolColumn _constructDailyAmountMatters() {
    return GeneratedBoolColumn('daily_amount_matters', $tableName, true,
        $customConstraints: 'DEFAULT 1',
        defaultValue: const CustomExpression<bool>('1'));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, category, perWeek, dailyAmountMatters];
  @override
  CachedGoals get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cached_goals';
  @override
  final String actualTableName = 'cached_goals';
  @override
  VerificationContext validateIntegrity(Insertable<CachedGoal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('per_week')) {
      context.handle(_perWeekMeta,
          perWeek.isAcceptableOrUnknown(data['per_week'], _perWeekMeta));
    }
    if (data.containsKey('daily_amount_matters')) {
      context.handle(
          _dailyAmountMattersMeta,
          dailyAmountMatters.isAcceptableOrUnknown(
              data['daily_amount_matters'], _dailyAmountMattersMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedGoal map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CachedGoal.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  CachedGoals createAlias(String alias) {
    return CachedGoals(_db, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Event extends DataClass implements Insertable<Event> {
  final String uuid;
  final String type;
  final String name;
  final String description;
  final DateTime timestamp;
  final String timezone;
  final int timezoneOffset;
  final bool realTime;
  final String additional;
  final DateTime synced;
  Event(
      {@required this.uuid,
      @required this.type,
      @required this.name,
      @required this.description,
      @required this.timestamp,
      @required this.timezone,
      @required this.timezoneOffset,
      @required this.realTime,
      @required this.additional,
      this.synced});
  factory Event.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Event(
      uuid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}uuid']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      timestamp: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
      timezone: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}timezone']),
      timezoneOffset: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}timezoneOffset']),
      realTime:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}real_time']),
      additional: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}additional']),
      synced: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}synced']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || uuid != null) {
      map['uuid'] = Variable<String>(uuid);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<DateTime>(timestamp);
    }
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    if (!nullToAbsent || timezoneOffset != null) {
      map['timezoneOffset'] = Variable<int>(timezoneOffset);
    }
    if (!nullToAbsent || realTime != null) {
      map['real_time'] = Variable<bool>(realTime);
    }
    if (!nullToAbsent || additional != null) {
      map['additional'] = Variable<String>(additional);
    }
    if (!nullToAbsent || synced != null) {
      map['synced'] = Variable<DateTime>(synced);
    }
    return map;
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Event(
      uuid: serializer.fromJson<String>(json['uuid']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      timezone: serializer.fromJson<String>(json['timezone']),
      timezoneOffset: serializer.fromJson<int>(json['timezoneOffset']),
      realTime: serializer.fromJson<bool>(json['real_time']),
      additional: serializer.fromJson<String>(json['additional']),
      synced: serializer.fromJson<DateTime>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'timezone': serializer.toJson<String>(timezone),
      'timezoneOffset': serializer.toJson<int>(timezoneOffset),
      'real_time': serializer.toJson<bool>(realTime),
      'additional': serializer.toJson<String>(additional),
      'synced': serializer.toJson<DateTime>(synced),
    };
  }

  Event copyWith(
          {String uuid,
          String type,
          String name,
          String description,
          DateTime timestamp,
          String timezone,
          int timezoneOffset,
          bool realTime,
          String additional,
          DateTime synced}) =>
      Event(
        uuid: uuid ?? this.uuid,
        type: type ?? this.type,
        name: name ?? this.name,
        description: description ?? this.description,
        timestamp: timestamp ?? this.timestamp,
        timezone: timezone ?? this.timezone,
        timezoneOffset: timezoneOffset ?? this.timezoneOffset,
        realTime: realTime ?? this.realTime,
        additional: additional ?? this.additional,
        synced: synced ?? this.synced,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('uuid: $uuid, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('timestamp: $timestamp, ')
          ..write('timezone: $timezone, ')
          ..write('timezoneOffset: $timezoneOffset, ')
          ..write('realTime: $realTime, ')
          ..write('additional: $additional, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      uuid.hashCode,
      $mrjc(
          type.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(
                      timestamp.hashCode,
                      $mrjc(
                          timezone.hashCode,
                          $mrjc(
                              timezoneOffset.hashCode,
                              $mrjc(
                                  realTime.hashCode,
                                  $mrjc(additional.hashCode,
                                      synced.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Event &&
          other.uuid == this.uuid &&
          other.type == this.type &&
          other.name == this.name &&
          other.description == this.description &&
          other.timestamp == this.timestamp &&
          other.timezone == this.timezone &&
          other.timezoneOffset == this.timezoneOffset &&
          other.realTime == this.realTime &&
          other.additional == this.additional &&
          other.synced == this.synced);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<String> uuid;
  final Value<String> type;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> timestamp;
  final Value<String> timezone;
  final Value<int> timezoneOffset;
  final Value<bool> realTime;
  final Value<String> additional;
  final Value<DateTime> synced;
  const EventsCompanion({
    this.uuid = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.timezone = const Value.absent(),
    this.timezoneOffset = const Value.absent(),
    this.realTime = const Value.absent(),
    this.additional = const Value.absent(),
    this.synced = const Value.absent(),
  });
  EventsCompanion.insert({
    @required String uuid,
    @required String type,
    @required String name,
    this.description = const Value.absent(),
    @required DateTime timestamp,
    @required String timezone,
    @required int timezoneOffset,
    this.realTime = const Value.absent(),
    this.additional = const Value.absent(),
    this.synced = const Value.absent(),
  })  : uuid = Value(uuid),
        type = Value(type),
        name = Value(name),
        timestamp = Value(timestamp),
        timezone = Value(timezone),
        timezoneOffset = Value(timezoneOffset);
  static Insertable<Event> custom({
    Expression<String> uuid,
    Expression<String> type,
    Expression<String> name,
    Expression<String> description,
    Expression<DateTime> timestamp,
    Expression<String> timezone,
    Expression<int> timezoneOffset,
    Expression<bool> realTime,
    Expression<String> additional,
    Expression<DateTime> synced,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (timestamp != null) 'timestamp': timestamp,
      if (timezone != null) 'timezone': timezone,
      if (timezoneOffset != null) 'timezoneOffset': timezoneOffset,
      if (realTime != null) 'real_time': realTime,
      if (additional != null) 'additional': additional,
      if (synced != null) 'synced': synced,
    });
  }

  EventsCompanion copyWith(
      {Value<String> uuid,
      Value<String> type,
      Value<String> name,
      Value<String> description,
      Value<DateTime> timestamp,
      Value<String> timezone,
      Value<int> timezoneOffset,
      Value<bool> realTime,
      Value<String> additional,
      Value<DateTime> synced}) {
    return EventsCompanion(
      uuid: uuid ?? this.uuid,
      type: type ?? this.type,
      name: name ?? this.name,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      timezone: timezone ?? this.timezone,
      timezoneOffset: timezoneOffset ?? this.timezoneOffset,
      realTime: realTime ?? this.realTime,
      additional: additional ?? this.additional,
      synced: synced ?? this.synced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (timezoneOffset.present) {
      map['timezoneOffset'] = Variable<int>(timezoneOffset.value);
    }
    if (realTime.present) {
      map['real_time'] = Variable<bool>(realTime.value);
    }
    if (additional.present) {
      map['additional'] = Variable<String>(additional.value);
    }
    if (synced.present) {
      map['synced'] = Variable<DateTime>(synced.value);
    }
    return map;
  }
}

class Events extends Table with TableInfo<Events, Event> {
  final GeneratedDatabase _db;
  final String _alias;
  Events(this._db, [this._alias]);
  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  GeneratedTextColumn _uuid;
  GeneratedTextColumn get uuid => _uuid ??= _constructUuid();
  GeneratedTextColumn _constructUuid() {
    return GeneratedTextColumn('uuid', $tableName, false,
        $customConstraints: 'NOT NULL PRIMARY KEY');
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn('type', $tableName, false,
        $customConstraints: 'NOT NULL');
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        $customConstraints: 'NOT NULL');
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        $customConstraints: 'NOT NULL DEFAULT \'\'',
        defaultValue: const CustomExpression<String>('\'\''));
  }

  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  GeneratedDateTimeColumn _timestamp;
  GeneratedDateTimeColumn get timestamp => _timestamp ??= _constructTimestamp();
  GeneratedDateTimeColumn _constructTimestamp() {
    return GeneratedDateTimeColumn('timestamp', $tableName, false,
        $customConstraints: 'NOT NULL');
  }

  final VerificationMeta _timezoneMeta = const VerificationMeta('timezone');
  GeneratedTextColumn _timezone;
  GeneratedTextColumn get timezone => _timezone ??= _constructTimezone();
  GeneratedTextColumn _constructTimezone() {
    return GeneratedTextColumn('timezone', $tableName, false,
        $customConstraints: 'NOT NULL');
  }

  final VerificationMeta _timezoneOffsetMeta =
      const VerificationMeta('timezoneOffset');
  GeneratedIntColumn _timezoneOffset;
  GeneratedIntColumn get timezoneOffset =>
      _timezoneOffset ??= _constructTimezoneOffset();
  GeneratedIntColumn _constructTimezoneOffset() {
    return GeneratedIntColumn('timezoneOffset', $tableName, false,
        $customConstraints: 'NOT NULL');
  }

  final VerificationMeta _realTimeMeta = const VerificationMeta('realTime');
  GeneratedBoolColumn _realTime;
  GeneratedBoolColumn get realTime => _realTime ??= _constructRealTime();
  GeneratedBoolColumn _constructRealTime() {
    return GeneratedBoolColumn('real_time', $tableName, false,
        $customConstraints: 'NOT NULL DEFAULT 1',
        defaultValue: const CustomExpression<bool>('1'));
  }

  final VerificationMeta _additionalMeta = const VerificationMeta('additional');
  GeneratedTextColumn _additional;
  GeneratedTextColumn get additional => _additional ??= _constructAdditional();
  GeneratedTextColumn _constructAdditional() {
    return GeneratedTextColumn('additional', $tableName, false,
        $customConstraints: 'NOT NULL DEFAULT \'\'',
        defaultValue: const CustomExpression<String>('\'\''));
  }

  final VerificationMeta _syncedMeta = const VerificationMeta('synced');
  GeneratedDateTimeColumn _synced;
  GeneratedDateTimeColumn get synced => _synced ??= _constructSynced();
  GeneratedDateTimeColumn _constructSynced() {
    return GeneratedDateTimeColumn('synced', $tableName, true,
        $customConstraints: '');
  }

  @override
  List<GeneratedColumn> get $columns => [
        uuid,
        type,
        name,
        description,
        timestamp,
        timezone,
        timezoneOffset,
        realTime,
        additional,
        synced
      ];
  @override
  Events get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'events';
  @override
  final String actualTableName = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid'], _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp'], _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(_timezoneMeta,
          timezone.isAcceptableOrUnknown(data['timezone'], _timezoneMeta));
    } else if (isInserting) {
      context.missing(_timezoneMeta);
    }
    if (data.containsKey('timezoneOffset')) {
      context.handle(
          _timezoneOffsetMeta,
          timezoneOffset.isAcceptableOrUnknown(
              data['timezoneOffset'], _timezoneOffsetMeta));
    } else if (isInserting) {
      context.missing(_timezoneOffsetMeta);
    }
    if (data.containsKey('real_time')) {
      context.handle(_realTimeMeta,
          realTime.isAcceptableOrUnknown(data['real_time'], _realTimeMeta));
    }
    if (data.containsKey('additional')) {
      context.handle(
          _additionalMeta,
          additional.isAcceptableOrUnknown(
              data['additional'], _additionalMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced'], _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  Event map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Event.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Events createAlias(String alias) {
    return Events(_db, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$WeeklyGoalsDatabase extends GeneratedDatabase {
  _$WeeklyGoalsDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  CachedGoals _cachedGoals;
  CachedGoals get cachedGoals => _cachedGoals ??= CachedGoals(this);
  Events _events;
  Events get events => _events ??= Events(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cachedGoals, events];
}
