// /// Functional result type for clean error handling across layers
// abstract class ApiResult<T> {
//   const ApiResult();
// }

// class Success<T> extends ApiResult<T> {
//   final T data;
//   const Success(this.data);
// }

// class Failure<T> extends ApiResult<T> {
//   final String errorMessage;
//   final int? statusCode;
//   const Failure(this.errorMessage, {this.statusCode});
// }


abstract class ApiResult<T> {
  const ApiResult();

  factory ApiResult.success(T data) = Success<T>;

  factory ApiResult.failure(
    String errorMessage, {
    int? statusCode,
  }) = Failure<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else if (this is Failure<T>) {
      return failure((this as Failure<T>).errorMessage);
    }

    throw StateError('Unknown ApiResult type');
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> extends ApiResult<T> {
  final String errorMessage;
  final int? statusCode;

  const Failure(this.errorMessage, {this.statusCode});
}