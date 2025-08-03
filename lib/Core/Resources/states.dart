sealed class DataState<T> {
  const DataState();
}

final class DataSuccess<T> extends DataState<T> {
  final T data;

  const DataSuccess({required this.data});
}

final class DataFailure<T> extends DataState<T> {
  final String message;
  final Exception? exception;

  const DataFailure({required this.message, this.exception});
}

final class DataLoading<T> extends DataState<T> {
  const DataLoading();
}
