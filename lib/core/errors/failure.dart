import 'dart:async';
import 'dart:io';

import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/common.dart';
import '../services/crash_service.dart';
import '../utils/helper_util.dart';
import 'error.dart';

abstract class Failure extends Equatable {
  const Failure();
  @override
  List<Object?> get props => [];
}

class NoInternetFailure extends Failure {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'No internet';
}

class ServerFailure extends Failure {
  const ServerFailure({
    this.message = 'Something went wrong. Try again in a while.',
  });
  final String message;

  @override
  List<Object> get props => [message];
}

class Maintenance extends Failure {
  const Maintenance({
    required this.message,
  });
  final String message;

  @override
  List<Object> get props => [message];
}

class TimeOutFailure extends Failure {
  const TimeOutFailure({
    this.message,
  });
  final String? message;

  @override
  List<Object> get props => [message ?? ''];

  @override
  String toString() => 'Request Timeout';
}

class NullFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    required this.message,
  });
  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Unknown Failure';
}

class FailureToMessage {
  static String mapFailureToMessage(Failure failure) {
    if (failure is NoInternetFailure) {
      return 'Please check your internet connection and try again.';
    }
    if (failure is ServerFailure) {
      return failure.message;
    }
    if (failure is TimeOutFailure) {
      return 'Opps! Your internet connection is slow. Check and try again.';
    }

    return 'Something went wrong. Try again in a while.';
  }

  static dynamic returnLeftError(Object e,
      [StackTrace? stack, dynamic reason]) {
    if (e is NoInternetException) {
      return NoInternetFailure();
    }

    if (e is FirebaseAuthException) {
      return ServerFailure(message: e.message.toString());
    }

    if (e is DioException) {
      ZLoggerService.logOnDebug('### ERROR ###');
      ZLoggerService.logOnDebug(
          '### STATUS CODE: ${e.response?.statusCode} ###');
      ZLoggerService.logOnDebug('### ERROR RESPONSE: ${e.response} ###');

      if (e.response != null &&
          e.response!.statusCode == HttpStatus.unauthorized) {
        if ((e.response?.data?['message'] ?? '').toString().toLowerCase() ==
            kAuthentication) HelperUtil.logOut();
        return ServerFailure(
            message: e.response?.data?['message'] ?? kAuthentication);
      }

      if (e.response != null && e.response!.statusCode == HttpStatus.notFound) {
        return ServerFailure(
            message: e.response!.data?['message'] ?? 'Not found');
      }

      if (e.response != null &&
          e.response!.statusCode == HttpStatus.unprocessableEntity) {
        return ServerFailure(
          message: (e.response!.data?['errors'] != null &&
                  (e.response!.data?['errors'] ?? []).length != 0)
              ? (getValidationMessageFromMap(e.response!.data?['errors'] ?? {}))
              : e.response!.data?['message'] ?? '',
        );
      }

      if (e.response != null &&
          e.response!.statusCode == HttpStatus.internalServerError) {
        CrashService.recordCrashError(e, stack, reason: reason, fatal: true);
        return ServerFailure(
            message: (e.response!.data?['errors'] ?? []).length != 0
                ? (getValidationMessageFromMap(
                    e.response!.data?['errors'] ?? {}))
                : 'Something went wrong, please try again later');
      }

      CrashService.recordCrashError(e, stack, reason: reason, fatal: true);
      return const ServerFailure();
    }

    if (e is ServerException) {
      CrashService.recordCrashError(e, stack, reason: reason, fatal: true);
      return ServerFailure(message: e.message);
    }

    if (e is TimeoutException) {
      return const TimeOutFailure();
    }

    return UnknownFailure(message: e.toString());
  }

  static String getValidationMessageFromMap(var messages) {
    if (messages.isEmpty) return 'All fields are required';

    String message = '';
    if (messages.runtimeType == List) {
      for (int i = 0; i < (messages as List).length; i++) {
        message += '${messages[i]}\n';
      }
    } else {
      messages.forEach((key, value) {
        if (value.runtimeType == List) {
          for (String item in value) {
            message += '$item\n';
          }
        } else {
          message += '$value\n';
        }
      });
    }

    return message;
  }
}
