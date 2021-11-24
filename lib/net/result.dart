import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';

class Result {}

class Success<T> extends Result {
  T? _data;

  T? get data => _data;

  Success();

  Success.create(T? data) {
    _data = data;
  }
}

class Error extends Result {
  late BaseException _exception;

  BaseException get exception => _exception;

  Error.create(BaseException exception) {
    _exception = exception;
  }
}

extension CheckResultExt on Result {
  void checkResult<T>(
      {required Function(T data) onSuccess,
      required Function(BaseException exception) onError}) {
    if (this is Success<T>) {
      onSuccess((this as Success).data);
    } else if (this is Error) {
      onError((this as Error).exception);
    }
  }
}
