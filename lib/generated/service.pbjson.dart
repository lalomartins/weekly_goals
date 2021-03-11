///
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use pushEventsRequestDescriptor instead')
const PushEventsRequest$json = const {
  '1': 'PushEventsRequest',
  '2': const [
    const {'1': 'event', '3': 1, '4': 1, '5': 11, '6': '.eventserver.Event', '10': 'event'},
  ],
};

/// Descriptor for `PushEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pushEventsRequestDescriptor = $convert.base64Decode('ChFQdXNoRXZlbnRzUmVxdWVzdBIoCgVldmVudBgBIAEoCzISLmV2ZW50c2VydmVyLkV2ZW50UgVldmVudA==');
@$core.Deprecated('Use pushEventsResponseDescriptor instead')
const PushEventsResponse$json = const {
  '1': 'PushEventsResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.eventserver.EventOperationResult', '10': 'result'},
  ],
};

/// Descriptor for `PushEventsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pushEventsResponseDescriptor = $convert.base64Decode('ChJQdXNoRXZlbnRzUmVzcG9uc2USOQoGcmVzdWx0GAEgASgLMiEuZXZlbnRzZXJ2ZXIuRXZlbnRPcGVyYXRpb25SZXN1bHRSBnJlc3VsdA==');
@$core.Deprecated('Use getEventsRequestDescriptor instead')
const GetEventsRequest$json = const {
  '1': 'GetEventsRequest',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 11, '6': '.eventserver.EventsFilter', '10': 'filter'},
  ],
};

/// Descriptor for `GetEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEventsRequestDescriptor = $convert.base64Decode('ChBHZXRFdmVudHNSZXF1ZXN0EjEKBmZpbHRlchgBIAEoCzIZLmV2ZW50c2VydmVyLkV2ZW50c0ZpbHRlclIGZmlsdGVy');
@$core.Deprecated('Use getEventsResponseDescriptor instead')
const GetEventsResponse$json = const {
  '1': 'GetEventsResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.eventserver.EventOperationResult', '10': 'result'},
  ],
};

/// Descriptor for `GetEventsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEventsResponseDescriptor = $convert.base64Decode('ChFHZXRFdmVudHNSZXNwb25zZRI5CgZyZXN1bHQYASABKAsyIS5ldmVudHNlcnZlci5FdmVudE9wZXJhdGlvblJlc3VsdFIGcmVzdWx0');
@$core.Deprecated('Use watchEventsRequestDescriptor instead')
const WatchEventsRequest$json = const {
  '1': 'WatchEventsRequest',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 11, '6': '.eventserver.EventsFilter', '10': 'filter'},
  ],
};

/// Descriptor for `WatchEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watchEventsRequestDescriptor = $convert.base64Decode('ChJXYXRjaEV2ZW50c1JlcXVlc3QSMQoGZmlsdGVyGAEgASgLMhkuZXZlbnRzZXJ2ZXIuRXZlbnRzRmlsdGVyUgZmaWx0ZXI=');
@$core.Deprecated('Use watchEventsResponseDescriptor instead')
const WatchEventsResponse$json = const {
  '1': 'WatchEventsResponse',
  '2': const [
    const {'1': 'item', '3': 1, '4': 1, '5': 11, '6': '.eventserver.EventStreamItem', '10': 'item'},
  ],
};

/// Descriptor for `WatchEventsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watchEventsResponseDescriptor = $convert.base64Decode('ChNXYXRjaEV2ZW50c1Jlc3BvbnNlEjAKBGl0ZW0YASABKAsyHC5ldmVudHNlcnZlci5FdmVudFN0cmVhbUl0ZW1SBGl0ZW0=');
@$core.Deprecated('Use syncEventsRequestDescriptor instead')
const SyncEventsRequest$json = const {
  '1': 'SyncEventsRequest',
  '2': const [
    const {'1': 'event', '3': 1, '4': 1, '5': 11, '6': '.eventserver.Event', '9': 0, '10': 'event'},
    const {'1': 'filter', '3': 2, '4': 1, '5': 11, '6': '.eventserver.EventsFilter', '9': 0, '10': 'filter'},
  ],
  '8': const [
    const {'1': 'pushpull'},
  ],
};

/// Descriptor for `SyncEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncEventsRequestDescriptor = $convert.base64Decode('ChFTeW5jRXZlbnRzUmVxdWVzdBIqCgVldmVudBgBIAEoCzISLmV2ZW50c2VydmVyLkV2ZW50SABSBWV2ZW50EjMKBmZpbHRlchgCIAEoCzIZLmV2ZW50c2VydmVyLkV2ZW50c0ZpbHRlckgAUgZmaWx0ZXJCCgoIcHVzaHB1bGw=');
@$core.Deprecated('Use syncEventsResponseDescriptor instead')
const SyncEventsResponse$json = const {
  '1': 'SyncEventsResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.eventserver.EventOperationResult', '10': 'result'},
  ],
};

/// Descriptor for `SyncEventsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncEventsResponseDescriptor = $convert.base64Decode('ChJTeW5jRXZlbnRzUmVzcG9uc2USOQoGcmVzdWx0GAEgASgLMiEuZXZlbnRzZXJ2ZXIuRXZlbnRPcGVyYXRpb25SZXN1bHRSBnJlc3VsdA==');
