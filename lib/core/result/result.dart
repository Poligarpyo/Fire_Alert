import 'app_failure.dart';

abstract class Result<T> {
  const Result();
  // ✅ Add these factory constructors
  factory Result.success(T data) => Success(data);
  factory Result.failure(AppFailure error) => Failure(error);
  R when<R>({
    required R Function(T data) success,
    required R Function(AppFailure error) failure,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else {
      return failure((this as Failure<T>).error);
    }
  }
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final AppFailure error;
  const Failure(this.error);
}
