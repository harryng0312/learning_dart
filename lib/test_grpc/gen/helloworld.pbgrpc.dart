///
//  Generated code. Do not modify.
//  source: helloworld.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'helloworld.pb.dart' as $0;
export 'helloworld.pb.dart';

class HelloworldServiceClient extends $grpc.Client {
  static final _$getCurrentDate =
      $grpc.ClientMethod<$0.GetCurrentDateRequest, $0.GetCurrentDateResponse>(
          '/org.harryng.dart.HelloworldService/GetCurrentDate',
          ($0.GetCurrentDateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCurrentDateResponse.fromBuffer(value));

  HelloworldServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetCurrentDateResponse> getCurrentDate(
      $0.GetCurrentDateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCurrentDate, request, options: options);
  }
}

abstract class HelloworldServiceBase extends $grpc.Service {
  $core.String get $name => 'org.harryng.dart.HelloworldService';

  HelloworldServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetCurrentDateRequest,
            $0.GetCurrentDateResponse>(
        'GetCurrentDate',
        getCurrentDate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCurrentDateRequest.fromBuffer(value),
        ($0.GetCurrentDateResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetCurrentDateResponse> getCurrentDate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCurrentDateRequest> request) async {
    return getCurrentDate(call, await request);
  }

  $async.Future<$0.GetCurrentDateResponse> getCurrentDate(
      $grpc.ServiceCall call, $0.GetCurrentDateRequest request);
}
