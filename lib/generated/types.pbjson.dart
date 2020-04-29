///
//  Generated code. Do not modify.
//  source: types.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Timezone$json = const {
  '1': 'Timezone',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 17, '10': 'offset'},
  ],
};

const Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 12, '10': 'uuid'},
    const {'1': 'account', '3': 2, '4': 1, '5': 12, '10': 'account'},
    const {'1': 'application', '3': 3, '4': 1, '5': 9, '10': 'application'},
    const {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'timestamp', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    const {'1': 'timezone', '3': 8, '4': 1, '5': 11, '6': '.eventserver.Timezone', '10': 'timezone'},
    const {'1': 'real_time', '3': 9, '4': 1, '5': 8, '10': 'realTime'},
    const {'1': 'synced', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'synced'},
    const {'1': 'additional_bytes', '3': 11, '4': 1, '5': 12, '9': 0, '10': 'additionalBytes'},
    const {'1': 'additional_str', '3': 12, '4': 1, '5': 9, '9': 0, '10': 'additionalStr'},
    const {'1': 'additional_yaml', '3': 13, '4': 1, '5': 9, '9': 0, '10': 'additionalYaml'},
  ],
  '8': const [
    const {'1': 'additional'},
  ],
};

const ErrorDetails$json = const {
  '1': 'ErrorDetails',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 13, '10': 'code'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

const EventStreamItem$json = const {
  '1': 'EventStreamItem',
  '2': const [
    const {'1': 'event', '3': 1, '4': 1, '5': 11, '6': '.eventserver.Event', '9': 0, '10': 'event'},
    const {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.eventserver.ErrorDetails', '9': 0, '10': 'error'},
    const {'1': 'no_more', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '9': 0, '10': 'noMore'},
  ],
  '8': const [
    const {'1': 'item_content'},
  ],
};

const EventOperationResult$json = const {
  '1': 'EventOperationResult',
  '2': const [
    const {'1': 'event', '3': 1, '4': 1, '5': 11, '6': '.eventserver.Event', '9': 0, '10': 'event'},
    const {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.eventserver.ErrorDetails', '9': 0, '10': 'error'},
  ],
  '8': const [
    const {'1': 'item_content'},
  ],
};

const EventsFilter$json = const {
  '1': 'EventsFilter',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 12, '10': 'account'},
    const {'1': 'application', '3': 2, '4': 1, '5': 9, '10': 'application'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'since', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'since'},
  ],
};

