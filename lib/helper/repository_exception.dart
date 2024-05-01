import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../core/app_error.dart';

mixin RepositoryExceptionMixin {
  Future<Either<AppError, Type>> exceptionHandler<Type>(
      FutureOr computation) async {
    try {
      final result = await computation;
      return Right(result as Type);
    } on DioException catch (e) {
      return Left(AppError(exception: e, message: e.message));
    } catch (e) {
      return Left(AppError(exception: e, message: e.toString()));
    }
  }
}
