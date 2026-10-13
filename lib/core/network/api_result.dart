/// Functional result type for clean error handling across layers
abstract class ApiResult<T> {
  const ApiResult();
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
