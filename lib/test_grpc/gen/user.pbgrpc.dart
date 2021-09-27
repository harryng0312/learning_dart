///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $1;
export 'user.pb.dart';

class ChatServiceClient extends $grpc.Client {
  static final _$getCurrentDate =
      $grpc.ClientMethod<$1.GetCurrentDateRequest, $1.GetCurrentDateResponse>(
          '/org.harryng.grpc.demo.ChatService/GetCurrentDate',
          ($1.GetCurrentDateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetCurrentDateResponse.fromBuffer(value));
  static final _$loginChat =
      $grpc.ClientMethod<$1.AuthRequest, $1.AuthResponse>(
          '/org.harryng.grpc.demo.ChatService/LoginChat',
          ($1.AuthRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.AuthResponse.fromBuffer(value));
  static final _$logoutChat =
      $grpc.ClientMethod<$1.AuthRequest, $1.AuthResponse>(
          '/org.harryng.grpc.demo.ChatService/LogoutChat',
          ($1.AuthRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.AuthResponse.fromBuffer(value));
  static final _$sendChatStream =
      $grpc.ClientMethod<$1.ChatMessage, $1.ChatSignal>(
          '/org.harryng.grpc.demo.ChatService/SendChatStream',
          ($1.ChatMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.ChatSignal.fromBuffer(value));

  ChatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.GetCurrentDateResponse> getCurrentDate(
      $1.GetCurrentDateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCurrentDate, request, options: options);
  }

  $grpc.ResponseFuture<$1.AuthResponse> loginChat($1.AuthRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$loginChat, request, options: options);
  }

  $grpc.ResponseFuture<$1.AuthResponse> logoutChat($1.AuthRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$logoutChat, request, options: options);
  }

  $grpc.ResponseStream<$1.ChatSignal> sendChatStream(
      $async.Stream<$1.ChatMessage> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendChatStream, request, options: options);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'org.harryng.grpc.demo.ChatService';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.GetCurrentDateRequest,
            $1.GetCurrentDateResponse>(
        'GetCurrentDate',
        getCurrentDate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCurrentDateRequest.fromBuffer(value),
        ($1.GetCurrentDateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AuthRequest, $1.AuthResponse>(
        'LoginChat',
        loginChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AuthRequest.fromBuffer(value),
        ($1.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AuthRequest, $1.AuthResponse>(
        'LogoutChat',
        logoutChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AuthRequest.fromBuffer(value),
        ($1.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChatMessage, $1.ChatSignal>(
        'SendChatStream',
        sendChatStream,
        true,
        true,
        ($core.List<$core.int> value) => $1.ChatMessage.fromBuffer(value),
        ($1.ChatSignal value) => value.writeToBuffer()));
  }

  $async.Future<$1.GetCurrentDateResponse> getCurrentDate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCurrentDateRequest> request) async {
    return getCurrentDate(call, await request);
  }

  $async.Future<$1.AuthResponse> loginChat_Pre(
      $grpc.ServiceCall call, $async.Future<$1.AuthRequest> request) async {
    return loginChat(call, await request);
  }

  $async.Future<$1.AuthResponse> logoutChat_Pre(
      $grpc.ServiceCall call, $async.Future<$1.AuthRequest> request) async {
    return logoutChat(call, await request);
  }

  $async.Future<$1.GetCurrentDateResponse> getCurrentDate(
      $grpc.ServiceCall call, $1.GetCurrentDateRequest request);
  $async.Future<$1.AuthResponse> loginChat(
      $grpc.ServiceCall call, $1.AuthRequest request);
  $async.Future<$1.AuthResponse> logoutChat(
      $grpc.ServiceCall call, $1.AuthRequest request);
  $async.Stream<$1.ChatSignal> sendChatStream(
      $grpc.ServiceCall call, $async.Stream<$1.ChatMessage> request);
}
