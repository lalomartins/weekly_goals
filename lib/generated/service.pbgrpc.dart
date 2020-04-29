///
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'service.pb.dart' as $0;
export 'service.pb.dart';

class EventServerClient extends $grpc.Client {
  static final _$pushEvents =
      $grpc.ClientMethod<$0.PushEventsRequest, $0.PushEventsResponse>(
          '/eventserver.EventServer/PushEvents',
          ($0.PushEventsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PushEventsResponse.fromBuffer(value));
  static final _$getEvents =
      $grpc.ClientMethod<$0.GetEventsRequest, $0.GetEventsResponse>(
          '/eventserver.EventServer/GetEvents',
          ($0.GetEventsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetEventsResponse.fromBuffer(value));
  static final _$watchEvents =
      $grpc.ClientMethod<$0.WatchEventsRequest, $0.WatchEventsResponse>(
          '/eventserver.EventServer/WatchEvents',
          ($0.WatchEventsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.WatchEventsResponse.fromBuffer(value));

  EventServerClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseStream<$0.PushEventsResponse> pushEvents(
      $async.Stream<$0.PushEventsRequest> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$pushEvents, request, options: options);
    return $grpc.ResponseStream(call);
  }

  $grpc.ResponseStream<$0.GetEventsResponse> getEvents(
      $0.GetEventsRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getEvents, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }

  $grpc.ResponseStream<$0.WatchEventsResponse> watchEvents(
      $0.WatchEventsRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$watchEvents, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class EventServerServiceBase extends $grpc.Service {
  $core.String get $name => 'eventserver.EventServer';

  EventServerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PushEventsRequest, $0.PushEventsResponse>(
        'PushEvents',
        pushEvents,
        true,
        true,
        ($core.List<$core.int> value) => $0.PushEventsRequest.fromBuffer(value),
        ($0.PushEventsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEventsRequest, $0.GetEventsResponse>(
        'GetEvents',
        getEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.GetEventsRequest.fromBuffer(value),
        ($0.GetEventsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.WatchEventsRequest, $0.WatchEventsResponse>(
            'WatchEvents',
            watchEvents_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.WatchEventsRequest.fromBuffer(value),
            ($0.WatchEventsResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.GetEventsResponse> getEvents_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetEventsRequest> request) async* {
    yield* getEvents(call, await request);
  }

  $async.Stream<$0.WatchEventsResponse> watchEvents_Pre($grpc.ServiceCall call,
      $async.Future<$0.WatchEventsRequest> request) async* {
    yield* watchEvents(call, await request);
  }

  $async.Stream<$0.PushEventsResponse> pushEvents(
      $grpc.ServiceCall call, $async.Stream<$0.PushEventsRequest> request);
  $async.Stream<$0.GetEventsResponse> getEvents(
      $grpc.ServiceCall call, $0.GetEventsRequest request);
  $async.Stream<$0.WatchEventsResponse> watchEvents(
      $grpc.ServiceCall call, $0.WatchEventsRequest request);
}
