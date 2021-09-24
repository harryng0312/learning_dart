///
//  Generated code. Do not modify.
//  source: helloworld.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class UserState extends $pb.ProtobufEnum {
  static const UserState OFFLINE = UserState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OFFLINE');
  static const UserState ONLINE = UserState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ONLINE');
  static const UserState INVALID = UserState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVALID');

  static const $core.List<UserState> values = <UserState> [
    OFFLINE,
    ONLINE,
    INVALID,
  ];

  static final $core.Map<$core.int, UserState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UserState? valueOf($core.int value) => _byValue[value];

  const UserState._($core.int v, $core.String n) : super(v, n);
}

class MessageState extends $pb.ProtobufEnum {
  static const MessageState NOT_SEND = MessageState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOT_SEND');
  static const MessageState IN_QUEUE = MessageState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IN_QUEUE');
  static const MessageState SENDING = MessageState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENDING');
  static const MessageState RECEIVED = MessageState._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECEIVED');
  static const MessageState READ = MessageState._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'READ');

  static const $core.List<MessageState> values = <MessageState> [
    NOT_SEND,
    IN_QUEUE,
    SENDING,
    RECEIVED,
    READ,
  ];

  static final $core.Map<$core.int, MessageState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageState? valueOf($core.int value) => _byValue[value];

  const MessageState._($core.int v, $core.String n) : super(v, n);
}

class MessageType extends $pb.ProtobufEnum {
  static const MessageType PING = MessageType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PING');
  static const MessageType TEXT = MessageType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEXT');
  static const MessageType FILE = MessageType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FILE');
  static const MessageType STREAM = MessageType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STREAM');

  static const $core.List<MessageType> values = <MessageType> [
    PING,
    TEXT,
    FILE,
    STREAM,
  ];

  static final $core.Map<$core.int, MessageType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageType? valueOf($core.int value) => _byValue[value];

  const MessageType._($core.int v, $core.String n) : super(v, n);
}

