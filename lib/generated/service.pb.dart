///
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'types.pb.dart' as $2;

class PushEventsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PushEventsRequest', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..aOM<$2.Event>(1, 'event', subBuilder: $2.Event.create)
    ..hasRequiredFields = false
  ;

  PushEventsRequest._() : super();
  factory PushEventsRequest() => create();
  factory PushEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PushEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PushEventsRequest clone() => PushEventsRequest()..mergeFromMessage(this);
  PushEventsRequest copyWith(void Function(PushEventsRequest) updates) => super.copyWith((message) => updates(message as PushEventsRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PushEventsRequest create() => PushEventsRequest._();
  PushEventsRequest createEmptyInstance() => create();
  static $pb.PbList<PushEventsRequest> createRepeated() => $pb.PbList<PushEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static PushEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushEventsRequest>(create);
  static PushEventsRequest _defaultInstance;

  @$pb.TagNumber(1)
  $2.Event get event => $_getN(0);
  @$pb.TagNumber(1)
  set event($2.Event v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => clearField(1);
  @$pb.TagNumber(1)
  $2.Event ensureEvent() => $_ensure(0);
}

class PushEventsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PushEventsResponse', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..aOM<$2.EventOperationResult>(1, 'result', subBuilder: $2.EventOperationResult.create)
    ..hasRequiredFields = false
  ;

  PushEventsResponse._() : super();
  factory PushEventsResponse() => create();
  factory PushEventsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PushEventsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PushEventsResponse clone() => PushEventsResponse()..mergeFromMessage(this);
  PushEventsResponse copyWith(void Function(PushEventsResponse) updates) => super.copyWith((message) => updates(message as PushEventsResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PushEventsResponse create() => PushEventsResponse._();
  PushEventsResponse createEmptyInstance() => create();
  static $pb.PbList<PushEventsResponse> createRepeated() => $pb.PbList<PushEventsResponse>();
  @$core.pragma('dart2js:noInline')
  static PushEventsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushEventsResponse>(create);
  static PushEventsResponse _defaultInstance;

  @$pb.TagNumber(1)
  $2.EventOperationResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result($2.EventOperationResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  $2.EventOperationResult ensureResult() => $_ensure(0);
}

class GetEventsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetEventsRequest', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..aOM<$2.EventsFilter>(1, 'filter', subBuilder: $2.EventsFilter.create)
    ..hasRequiredFields = false
  ;

  GetEventsRequest._() : super();
  factory GetEventsRequest() => create();
  factory GetEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetEventsRequest clone() => GetEventsRequest()..mergeFromMessage(this);
  GetEventsRequest copyWith(void Function(GetEventsRequest) updates) => super.copyWith((message) => updates(message as GetEventsRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEventsRequest create() => GetEventsRequest._();
  GetEventsRequest createEmptyInstance() => create();
  static $pb.PbList<GetEventsRequest> createRepeated() => $pb.PbList<GetEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEventsRequest>(create);
  static GetEventsRequest _defaultInstance;

  @$pb.TagNumber(1)
  $2.EventsFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter($2.EventsFilter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  $2.EventsFilter ensureFilter() => $_ensure(0);
}

class GetEventsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetEventsResponse', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..aOM<$2.EventOperationResult>(1, 'result', subBuilder: $2.EventOperationResult.create)
    ..hasRequiredFields = false
  ;

  GetEventsResponse._() : super();
  factory GetEventsResponse() => create();
  factory GetEventsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEventsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetEventsResponse clone() => GetEventsResponse()..mergeFromMessage(this);
  GetEventsResponse copyWith(void Function(GetEventsResponse) updates) => super.copyWith((message) => updates(message as GetEventsResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEventsResponse create() => GetEventsResponse._();
  GetEventsResponse createEmptyInstance() => create();
  static $pb.PbList<GetEventsResponse> createRepeated() => $pb.PbList<GetEventsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEventsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEventsResponse>(create);
  static GetEventsResponse _defaultInstance;

  @$pb.TagNumber(1)
  $2.EventOperationResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result($2.EventOperationResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  $2.EventOperationResult ensureResult() => $_ensure(0);
}

class WatchEventsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WatchEventsRequest', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..aOM<$2.EventsFilter>(1, 'filter', subBuilder: $2.EventsFilter.create)
    ..hasRequiredFields = false
  ;

  WatchEventsRequest._() : super();
  factory WatchEventsRequest() => create();
  factory WatchEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WatchEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WatchEventsRequest clone() => WatchEventsRequest()..mergeFromMessage(this);
  WatchEventsRequest copyWith(void Function(WatchEventsRequest) updates) => super.copyWith((message) => updates(message as WatchEventsRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WatchEventsRequest create() => WatchEventsRequest._();
  WatchEventsRequest createEmptyInstance() => create();
  static $pb.PbList<WatchEventsRequest> createRepeated() => $pb.PbList<WatchEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static WatchEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WatchEventsRequest>(create);
  static WatchEventsRequest _defaultInstance;

  @$pb.TagNumber(1)
  $2.EventsFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter($2.EventsFilter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  $2.EventsFilter ensureFilter() => $_ensure(0);
}

class WatchEventsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WatchEventsResponse', package: const $pb.PackageName('eventserver'), createEmptyInstance: create)
    ..aOM<$2.EventStreamItem>(1, 'item', subBuilder: $2.EventStreamItem.create)
    ..hasRequiredFields = false
  ;

  WatchEventsResponse._() : super();
  factory WatchEventsResponse() => create();
  factory WatchEventsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WatchEventsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WatchEventsResponse clone() => WatchEventsResponse()..mergeFromMessage(this);
  WatchEventsResponse copyWith(void Function(WatchEventsResponse) updates) => super.copyWith((message) => updates(message as WatchEventsResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WatchEventsResponse create() => WatchEventsResponse._();
  WatchEventsResponse createEmptyInstance() => create();
  static $pb.PbList<WatchEventsResponse> createRepeated() => $pb.PbList<WatchEventsResponse>();
  @$core.pragma('dart2js:noInline')
  static WatchEventsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WatchEventsResponse>(create);
  static WatchEventsResponse _defaultInstance;

  @$pb.TagNumber(1)
  $2.EventStreamItem get item => $_getN(0);
  @$pb.TagNumber(1)
  set item($2.EventStreamItem v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasItem() => $_has(0);
  @$pb.TagNumber(1)
  void clearItem() => clearField(1);
  @$pb.TagNumber(1)
  $2.EventStreamItem ensureItem() => $_ensure(0);
}

