///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use userStateDescriptor instead')
const UserState$json = const {
  '1': 'UserState',
  '2': const [
    const {'1': 'OFFLINE', '2': 0},
    const {'1': 'ONLINE', '2': 1},
    const {'1': 'INVALID', '2': 2},
  ],
};

/// Descriptor for `UserState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List userStateDescriptor = $convert.base64Decode('CglVc2VyU3RhdGUSCwoHT0ZGTElORRAAEgoKBk9OTElORRABEgsKB0lOVkFMSUQQAg==');
@$core.Deprecated('Use messageStateDescriptor instead')
const MessageState$json = const {
  '1': 'MessageState',
  '2': const [
    const {'1': 'NOT_SEND', '2': 0},
    const {'1': 'IN_QUEUE', '2': 1},
    const {'1': 'SENDING', '2': 2},
    const {'1': 'RECEIVED', '2': 3},
    const {'1': 'READ', '2': 4},
  ],
};

/// Descriptor for `MessageState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageStateDescriptor = $convert.base64Decode('CgxNZXNzYWdlU3RhdGUSDAoITk9UX1NFTkQQABIMCghJTl9RVUVVRRABEgsKB1NFTkRJTkcQAhIMCghSRUNFSVZFRBADEggKBFJFQUQQBA==');
@$core.Deprecated('Use messageTypeDescriptor instead')
const MessageType$json = const {
  '1': 'MessageType',
  '2': const [
    const {'1': 'PING', '2': 0},
    const {'1': 'TEXT', '2': 1},
    const {'1': 'FILE', '2': 2},
    const {'1': 'STREAM', '2': 3},
  ],
};

/// Descriptor for `MessageType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageTypeDescriptor = $convert.base64Decode('CgtNZXNzYWdlVHlwZRIICgRQSU5HEAASCAoEVEVYVBABEggKBEZJTEUQAhIKCgZTVFJFQU0QAw==');
@$core.Deprecated('Use getCurrentDateRequestDescriptor instead')
const GetCurrentDateRequest$json = const {
  '1': 'GetCurrentDateRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetCurrentDateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCurrentDateRequestDescriptor = $convert.base64Decode('ChVHZXRDdXJyZW50RGF0ZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use getCurrentDateResponseDescriptor instead')
const GetCurrentDateResponse$json = const {
  '1': 'GetCurrentDateResponse',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'result', '3': 2, '4': 1, '5': 9, '10': 'result'},
  ],
};

/// Descriptor for `GetCurrentDateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCurrentDateResponseDescriptor = $convert.base64Decode('ChZHZXRDdXJyZW50RGF0ZVJlc3BvbnNlEhIKBG5hbWUYASABKAlSBG5hbWUSFgoGcmVzdWx0GAIgASgJUgZyZXN1bHQ=');
@$core.Deprecated('Use authResponseDescriptor instead')
const AuthResponse$json = const {
  '1': 'AuthResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 5, '10': 'result'},
  ],
};

/// Descriptor for `AuthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authResponseDescriptor = $convert.base64Decode('CgxBdXRoUmVzcG9uc2USFgoGcmVzdWx0GAEgASgFUgZyZXN1bHQ=');
@$core.Deprecated('Use authRequestDescriptor instead')
const AuthRequest$json = const {
  '1': 'AuthRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.org.harryng.grpc.demo.User', '10': 'user'},
  ],
};

/// Descriptor for `AuthRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authRequestDescriptor = $convert.base64Decode('CgtBdXRoUmVxdWVzdBIvCgR1c2VyGAEgASgLMhsub3JnLmhhcnJ5bmcuZ3JwYy5kZW1vLlVzZXJSBHVzZXI=');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'state', '3': 3, '4': 1, '5': 14, '6': '.org.harryng.grpc.demo.UserState', '10': 'state'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSNgoFc3RhdGUYAyABKA4yIC5vcmcuaGFycnluZy5ncnBjLmRlbW8uVXNlclN0YXRlUgVzdGF0ZQ==');
@$core.Deprecated('Use chatMessageDescriptor instead')
const ChatMessage$json = const {
  '1': 'ChatMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'senderId', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'receiverId', '3': 3, '4': 1, '5': 9, '10': 'receiverId'},
    const {'1': 'type', '3': 4, '4': 1, '5': 14, '6': '.org.harryng.grpc.demo.MessageType', '10': 'type'},
    const {'1': 'message', '3': 5, '4': 1, '5': 12, '10': 'message'},
    const {'1': 'state', '3': 6, '4': 1, '5': 14, '6': '.org.harryng.grpc.demo.MessageState', '10': 'state'},
  ],
};

/// Descriptor for `ChatMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMessageDescriptor = $convert.base64Decode('CgtDaGF0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSGgoIc2VuZGVySWQYAiABKAlSCHNlbmRlcklkEh4KCnJlY2VpdmVySWQYAyABKAlSCnJlY2VpdmVySWQSNgoEdHlwZRgEIAEoDjIiLm9yZy5oYXJyeW5nLmdycGMuZGVtby5NZXNzYWdlVHlwZVIEdHlwZRIYCgdtZXNzYWdlGAUgASgMUgdtZXNzYWdlEjkKBXN0YXRlGAYgASgOMiMub3JnLmhhcnJ5bmcuZ3JwYy5kZW1vLk1lc3NhZ2VTdGF0ZVIFc3RhdGU=');
@$core.Deprecated('Use chatSignalDescriptor instead')
const ChatSignal$json = const {
  '1': 'ChatSignal',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.org.harryng.grpc.demo.MessageState', '10': 'state'},
  ],
};

/// Descriptor for `ChatSignal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatSignalDescriptor = $convert.base64Decode('CgpDaGF0U2lnbmFsEjkKBXN0YXRlGAEgASgOMiMub3JnLmhhcnJ5bmcuZ3JwYy5kZW1vLk1lc3NhZ2VTdGF0ZVIFc3RhdGU=');
