///
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'types.pb.dart' as $1;

class PushEventsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PushEventsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'eventserver'), createEmptyInstance: create)
    ..aOM<$1.Event>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'event', subBuilder: $1.Event.create)
    ..hasRequiredFields = false
  ;

  PushEventsRequest._() : super();
  factory PushEventsRequest({
    $1.Event? event,
  }) {
    final _result = create();
    if (event != null) {
      _result.event = event;
    }
    return _result;
  }
  factory PushEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PushEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PushEventsRequest clone() => PushEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PushEventsRequest copyWith(void Function(PushEventsRequest) updates) => super.copyWith((message) => updates(message as PushEventsRequest)) as PushEventsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PushEventsRequest create() => PushEventsRequest._();
  PushEventsRequest createEmptyInstance() => create();
  static $pb.PbList<PushEventsRequest> createRepeated() => $pb.PbList<PushEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static PushEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushEventsRequest>(create);
  static PushEventsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Event get event => $_getN(0);
  @$pb.TagNumber(1)
  set event($1.Event v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => clearField(1);
  @$pb.TagNumber(1)
  $1.Event ensureEvent() => $_ensure(0);
}

class PushEventsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PushEventsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'eventserver'), createEmptyInstance: create)
    ..aOM<$1.EventOperationResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: $1.EventOperationResult.create)
    ..hasRequiredFields = false
  ;

  PushEventsResponse._() : super();
  factory PushEventsResponse({
    $1.EventOperationResult? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory PushEventsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PushEventsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PushEventsResponse clone() => PushEventsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PushEventsResponse copyWith(void Function(PushEventsResponse) updates) => super.copyWith((message) => updates(message as PushEventsResponse)) as PushEventsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PushEventsResponse create() => PushEventsResponse._();
  PushEventsResponse createEmptyInstance() => create();
  static $pb.PbList<PushEventsResponse> createRepeated() => $pb.PbList<PushEventsResponse>();
  @$core.pragma('dart2js:noInline')
  static PushEventsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushEventsResponse>(create);
  static PushEventsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $1.EventOperationResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result($1.EventOperationResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  $1.EventOperationResult ensureResult() => $_ensure(0);
}

class GetEventsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetEventsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'eventserver'), createEmptyInstance: create)
    ..aOM<$1.EventsFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter', subBuilder: $1.EventsFilter.create)
    ..hasRequiredFields = false
  ;

  GetEventsRequest._() : super();
  factory GetEventsRequest({
    $1.EventsFilter? filter,
  }) {
    final _result = create();
    if (filter != null) {
      _result.filter = filter;
    }
    return _result;
  }
  factory GetEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEventsRequest clone() => GetEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEventsRequest copyWith(void Function(GetEventsRequest) updates) => super.copyWith((message) => updates(message as GetEventsRequest)) as GetEventsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEventsRequest create() => GetEventsRequest._();
  GetEventsRequest createEmptyInstance() => create();
  static $pb.PbList<GetEventsRequest> createRepeated() => $pb.PbList<GetEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEventsRequest>(create);
  static GetEventsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.EventsFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter($1.EventsFilter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  $1.EventsFilter ensureFilter() => $_ensure(0);
}

class GetEventsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetEventsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'eventserver'), createEmptyInstance: create)
    ..aOM<$1.EventOperationResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: $1.EventOperationResult.create)
    ..hasRequiredFields = false
  ;

  GetEventsResponse._() : super();
  factory GetEventsResponse({
    $1.EventOperationResult? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory GetEventsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEventsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEventsResponse clone() => GetEventsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEventsResponse copyWith(void Function(GetEventsResponse) updates) => super.copyWith((message) => updates(message as GetEventsResponse)) as GetEventsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEventsResponse create() => GetEventsResponse._();
  GetEventsResponse createEmptyInstance() => create();
  static $pb.PbList<GetEventsResponse> createRepeated() => $pb.PbList<GetEventsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEventsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEventsResponse>(create);
  static GetEventsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $1.EventOperationResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result($1.EventOperationResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  $1.EventOperationResult ensureResult() => $_ensure(0);
}

class WatchEventsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WatchEventsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'eventserver'), createEmptyInstance: create)
    ..aOM<$1.EventsFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter', subBuilder: $1.EventsFilter.create)
    ..hasRequiredFields = false
  ;

  WatchEventsRequest._() : super();
  factory WatchEventsRequest({
    $1.EventsFilter? filter,
  }) {
    final _result = create();
    if (filter != null) {
      _result.filter = filter;
    }
    return _result;
  }
  factory WatchEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WatchEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WatchEventsRequest clone() => WatchEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WatchEventsRequest copyWith(void Function(WatchEventsRequest) updates) => super.copyWith((message) => updates(message as WatchEventsRequest)) as WatchEventsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WatchEventsRequest create() => WatchEventsRequest._();
  WatchEventsRequest createEmptyInstance() => create();
  static $pb.PbList<WatchEventsRequest> createRepeated() => $pb.PbList<WatchEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static WatchEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WatchEventsRequest>(create);
  static WatchEventsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.EventsFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter($1.EventsFilter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  $1.EventsFilter ensureFilter() => $_ensure(0);
}

class WatchEventsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WatchEventsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'eventserver'), createEmptyInstance: create)
    ..aOM<$1.EventStreamItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', subBuilder: $1.EventStreamItem.create)
    ..hasRequiredFields = false
  ;

  WatchEventsResponse._() : super();
  factory WatchEventsResponse({
    $1.EventStreamItem? item,
  }) {
    final _result = create();
    if (item != null) {
      _result.item = item;
    }
    return _result;
  }
  factory WatchEventsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WatchEventsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WatchEventsResponse clone() => WatchEventsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WatchEventsResponse copyWith(void Function(WatchEventsResponse) updates) => super.copyWith((message) => updates(message as WatchEventsResponse)) as WatchEventsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WatchEventsResponse create() => WatchEventsResponse._();
  WatchEventsResponse createEmptyInstance() => create();
  static $pb.PbList<WatchEventsResponse> createRepeated() => $pb.PbList<WatchEventsResponse>();
  @$core.pragma('dart2js:noInline')
  static WatchEventsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WatchEventsResponse>(create);
  static WatchEventsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $1.EventStreamItem get item => $_getN(0);
  @$pb.TagNumber(1)
  set item($1.EventStreamItem v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasItem() => $_has(0);
  @$pb.TagNumber(1)
  void clearItem() => clearField(1);
  @$pb.TagNumber(1)
  $1.EventStreamItem ensureItem() => $_ensure(0);
}

enum SyncEventsRequest_Pushpull {
  event, 
  filter, 
  notSet
}

class SyncEventsRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SyncEventsRequest_Pushpull> _SyncEventsRequest_PushpullByTag = {
    1 : SyncEventsRequest_Pushpull.event,
    2 : SyncEventsRequest_Pushpull.filter,
    0 : SyncEventsRequest_Pushpull.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SyncEventsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'eventserver'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<$1.Event>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'event', subBuilder: $1.Event.create)
    ..aOM<$1.EventsFilter>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter', subBuilder: $1.EventsFilter.create)
    ..hasRequiredFields = false
  ;

  SyncEventsRequest._() : super();
  factory SyncEventsRequest({
    $1.Event? event,
    $1.EventsFilter? filter,
  }) {
    final _result = create();
    if (event != null) {
      _result.event = event;
    }
    if (filter != null) {
      _result.filter = filter;
    }
    return _result;
  }
  factory SyncEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncEventsRequest clone() => SyncEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncEventsRequest copyWith(void Function(SyncEventsRequest) updates) => super.copyWith((message) => updates(message as SyncEventsRequest)) as SyncEventsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SyncEventsRequest create() => SyncEventsRequest._();
  SyncEventsRequest createEmptyInstance() => create();
  static $pb.PbList<SyncEventsRequest> createRepeated() => $pb.PbList<SyncEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncEventsRequest>(create);
  static SyncEventsRequest? _defaultInstance;

  SyncEventsRequest_Pushpull whichPushpull() => _SyncEventsRequest_PushpullByTag[$_whichOneof(0)]!;
  void clearPushpull() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $1.Event get event => $_getN(0);
  @$pb.TagNumber(1)
  set event($1.Event v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => clearField(1);
  @$pb.TagNumber(1)
  $1.Event ensureEvent() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.EventsFilter get filter => $_getN(1);
  @$pb.TagNumber(2)
  set filter($1.EventsFilter v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFilter() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilter() => clearField(2);
  @$pb.TagNumber(2)
  $1.EventsFilter ensureFilter() => $_ensure(1);
}

class SyncEventsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SyncEventsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'eventserver'), createEmptyInstance: create)
    ..aOM<$1.EventOperationResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: $1.EventOperationResult.create)
    ..hasRequiredFields = false
  ;

  SyncEventsResponse._() : super();
  factory SyncEventsResponse({
    $1.EventOperationResult? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory SyncEventsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncEventsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncEventsResponse clone() => SyncEventsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncEventsResponse copyWith(void Function(SyncEventsResponse) updates) => super.copyWith((message) => updates(message as SyncEventsResponse)) as SyncEventsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SyncEventsResponse create() => SyncEventsResponse._();
  SyncEventsResponse createEmptyInstance() => create();
  static $pb.PbList<SyncEventsResponse> createRepeated() => $pb.PbList<SyncEventsResponse>();
  @$core.pragma('dart2js:noInline')
  static SyncEventsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncEventsResponse>(create);
  static SyncEventsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $1.EventOperationResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result($1.EventOperationResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  $1.EventOperationResult ensureResult() => $_ensure(0);
}

