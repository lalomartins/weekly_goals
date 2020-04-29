///
//  Generated code. Do not modify.
//  source: types.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

class Timezone extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Timezone', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..a<$core.int>(2, 'offset', $pb.PbFieldType.OS3)
    ..hasRequiredFields = false
  ;

  Timezone._() : super();
  factory Timezone() => create();
  factory Timezone.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Timezone.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Timezone clone() => Timezone()..mergeFromMessage(this);
  Timezone copyWith(void Function(Timezone) updates) => super.copyWith((message) => updates(message as Timezone));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Timezone create() => Timezone._();
  Timezone createEmptyInstance() => create();
  static $pb.PbList<Timezone> createRepeated() => $pb.PbList<Timezone>();
  @$core.pragma('dart2js:noInline')
  static Timezone getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Timezone>(create);
  static Timezone _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);
}

enum Event_Additional {
  additionalBytes, 
  additionalStr, 
  additionalYaml, 
  notSet
}

class Event extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Event_Additional> _Event_AdditionalByTag = {
    11 : Event_Additional.additionalBytes,
    12 : Event_Additional.additionalStr,
    13 : Event_Additional.additionalYaml,
    0 : Event_Additional.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Event', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..oo(0, [11, 12, 13])
    ..a<$core.List<$core.int>>(1, 'uuid', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, 'account', $pb.PbFieldType.OY)
    ..aOS(3, 'application')
    ..aOS(4, 'type')
    ..aOS(5, 'name')
    ..aOS(6, 'description')
    ..aOM<$1.Timestamp>(7, 'timestamp', subBuilder: $1.Timestamp.create)
    ..aOM<Timezone>(8, 'timezone', subBuilder: Timezone.create)
    ..aOB(9, 'realTime')
    ..aOM<$1.Timestamp>(10, 'synced', subBuilder: $1.Timestamp.create)
    ..a<$core.List<$core.int>>(11, 'additionalBytes', $pb.PbFieldType.OY)
    ..aOS(12, 'additionalStr')
    ..aOS(13, 'additionalYaml')
    ..hasRequiredFields = false
  ;

  Event._() : super();
  factory Event() => create();
  factory Event.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Event.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Event clone() => Event()..mergeFromMessage(this);
  Event copyWith(void Function(Event) updates) => super.copyWith((message) => updates(message as Event));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  Event createEmptyInstance() => create();
  static $pb.PbList<Event> createRepeated() => $pb.PbList<Event>();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event _defaultInstance;

  Event_Additional whichAdditional() => _Event_AdditionalByTag[$_whichOneof(0)];
  void clearAdditional() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.List<$core.int> get uuid => $_getN(0);
  @$pb.TagNumber(1)
  set uuid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get account => $_getN(1);
  @$pb.TagNumber(2)
  set account($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get application => $_getSZ(2);
  @$pb.TagNumber(3)
  set application($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasApplication() => $_has(2);
  @$pb.TagNumber(3)
  void clearApplication() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(5)
  set name($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(5)
  void clearName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get timestamp => $_getN(6);
  @$pb.TagNumber(7)
  set timestamp($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasTimestamp() => $_has(6);
  @$pb.TagNumber(7)
  void clearTimestamp() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureTimestamp() => $_ensure(6);

  @$pb.TagNumber(8)
  Timezone get timezone => $_getN(7);
  @$pb.TagNumber(8)
  set timezone(Timezone v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasTimezone() => $_has(7);
  @$pb.TagNumber(8)
  void clearTimezone() => clearField(8);
  @$pb.TagNumber(8)
  Timezone ensureTimezone() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.bool get realTime => $_getBF(8);
  @$pb.TagNumber(9)
  set realTime($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRealTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearRealTime() => clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get synced => $_getN(9);
  @$pb.TagNumber(10)
  set synced($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasSynced() => $_has(9);
  @$pb.TagNumber(10)
  void clearSynced() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureSynced() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.List<$core.int> get additionalBytes => $_getN(10);
  @$pb.TagNumber(11)
  set additionalBytes($core.List<$core.int> v) { $_setBytes(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasAdditionalBytes() => $_has(10);
  @$pb.TagNumber(11)
  void clearAdditionalBytes() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get additionalStr => $_getSZ(11);
  @$pb.TagNumber(12)
  set additionalStr($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasAdditionalStr() => $_has(11);
  @$pb.TagNumber(12)
  void clearAdditionalStr() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get additionalYaml => $_getSZ(12);
  @$pb.TagNumber(13)
  set additionalYaml($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasAdditionalYaml() => $_has(12);
  @$pb.TagNumber(13)
  void clearAdditionalYaml() => clearField(13);
}

class ErrorDetails extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ErrorDetails', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..a<$core.int>(1, 'code', $pb.PbFieldType.OU3)
    ..aOS(2, 'message')
    ..hasRequiredFields = false
  ;

  ErrorDetails._() : super();
  factory ErrorDetails() => create();
  factory ErrorDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ErrorDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ErrorDetails clone() => ErrorDetails()..mergeFromMessage(this);
  ErrorDetails copyWith(void Function(ErrorDetails) updates) => super.copyWith((message) => updates(message as ErrorDetails));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ErrorDetails create() => ErrorDetails._();
  ErrorDetails createEmptyInstance() => create();
  static $pb.PbList<ErrorDetails> createRepeated() => $pb.PbList<ErrorDetails>();
  @$core.pragma('dart2js:noInline')
  static ErrorDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrorDetails>(create);
  static ErrorDetails _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

enum EventStreamItem_ItemContent {
  event, 
  error, 
  noMore, 
  notSet
}

class EventStreamItem extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, EventStreamItem_ItemContent> _EventStreamItem_ItemContentByTag = {
    1 : EventStreamItem_ItemContent.event,
    2 : EventStreamItem_ItemContent.error,
    3 : EventStreamItem_ItemContent.noMore,
    0 : EventStreamItem_ItemContent.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('EventStreamItem', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<Event>(1, 'event', subBuilder: Event.create)
    ..aOM<ErrorDetails>(2, 'error', subBuilder: ErrorDetails.create)
    ..aOM<$1.Timestamp>(3, 'noMore', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  EventStreamItem._() : super();
  factory EventStreamItem() => create();
  factory EventStreamItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EventStreamItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  EventStreamItem clone() => EventStreamItem()..mergeFromMessage(this);
  EventStreamItem copyWith(void Function(EventStreamItem) updates) => super.copyWith((message) => updates(message as EventStreamItem));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EventStreamItem create() => EventStreamItem._();
  EventStreamItem createEmptyInstance() => create();
  static $pb.PbList<EventStreamItem> createRepeated() => $pb.PbList<EventStreamItem>();
  @$core.pragma('dart2js:noInline')
  static EventStreamItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventStreamItem>(create);
  static EventStreamItem _defaultInstance;

  EventStreamItem_ItemContent whichItemContent() => _EventStreamItem_ItemContentByTag[$_whichOneof(0)];
  void clearItemContent() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Event get event => $_getN(0);
  @$pb.TagNumber(1)
  set event(Event v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => clearField(1);
  @$pb.TagNumber(1)
  Event ensureEvent() => $_ensure(0);

  @$pb.TagNumber(2)
  ErrorDetails get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(ErrorDetails v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  ErrorDetails ensureError() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Timestamp get noMore => $_getN(2);
  @$pb.TagNumber(3)
  set noMore($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasNoMore() => $_has(2);
  @$pb.TagNumber(3)
  void clearNoMore() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureNoMore() => $_ensure(2);
}

enum EventOperationResult_ItemContent {
  event, 
  error, 
  notSet
}

class EventOperationResult extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, EventOperationResult_ItemContent> _EventOperationResult_ItemContentByTag = {
    1 : EventOperationResult_ItemContent.event,
    2 : EventOperationResult_ItemContent.error,
    0 : EventOperationResult_ItemContent.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('EventOperationResult', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<Event>(1, 'event', subBuilder: Event.create)
    ..aOM<ErrorDetails>(2, 'error', subBuilder: ErrorDetails.create)
    ..hasRequiredFields = false
  ;

  EventOperationResult._() : super();
  factory EventOperationResult() => create();
  factory EventOperationResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EventOperationResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  EventOperationResult clone() => EventOperationResult()..mergeFromMessage(this);
  EventOperationResult copyWith(void Function(EventOperationResult) updates) => super.copyWith((message) => updates(message as EventOperationResult));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EventOperationResult create() => EventOperationResult._();
  EventOperationResult createEmptyInstance() => create();
  static $pb.PbList<EventOperationResult> createRepeated() => $pb.PbList<EventOperationResult>();
  @$core.pragma('dart2js:noInline')
  static EventOperationResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventOperationResult>(create);
  static EventOperationResult _defaultInstance;

  EventOperationResult_ItemContent whichItemContent() => _EventOperationResult_ItemContentByTag[$_whichOneof(0)];
  void clearItemContent() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Event get event => $_getN(0);
  @$pb.TagNumber(1)
  set event(Event v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => clearField(1);
  @$pb.TagNumber(1)
  Event ensureEvent() => $_ensure(0);

  @$pb.TagNumber(2)
  ErrorDetails get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(ErrorDetails v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  ErrorDetails ensureError() => $_ensure(1);
}

class EventsFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('EventsFilter', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, 'account', $pb.PbFieldType.OY)
    ..aOS(2, 'application')
    ..aOS(3, 'type')
    ..aOS(4, 'name')
    ..aOM<$1.Timestamp>(5, 'since', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  EventsFilter._() : super();
  factory EventsFilter() => create();
  factory EventsFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EventsFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  EventsFilter clone() => EventsFilter()..mergeFromMessage(this);
  EventsFilter copyWith(void Function(EventsFilter) updates) => super.copyWith((message) => updates(message as EventsFilter));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EventsFilter create() => EventsFilter._();
  EventsFilter createEmptyInstance() => create();
  static $pb.PbList<EventsFilter> createRepeated() => $pb.PbList<EventsFilter>();
  @$core.pragma('dart2js:noInline')
  static EventsFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventsFilter>(create);
  static EventsFilter _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get account => $_getN(0);
  @$pb.TagNumber(1)
  set account($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get application => $_getSZ(1);
  @$pb.TagNumber(2)
  set application($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasApplication() => $_has(1);
  @$pb.TagNumber(2)
  void clearApplication() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get since => $_getN(4);
  @$pb.TagNumber(5)
  set since($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasSince() => $_has(4);
  @$pb.TagNumber(5)
  void clearSince() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureSince() => $_ensure(4);
}

