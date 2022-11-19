import 'dart:async';

import 'package:live_stream/src/live_stream.dart';
import 'package:rxdart/rxdart.dart';

class StreamValidator<T extends Object> extends StreamBase<T> {
  final _outerStream = BehaviorSubject<T>(sync: true);
  final _innerStream = BehaviorSubject<T>(sync: true);

  @override
  ValueStream<T> get stream => _outerStream.stream;

  Stream<T> get innerStream => _innerStream.stream;

  StreamSink<T> get streamSink => _outerStream.sink;

  StreamSink<T> get innerStreamSink => _innerStream.sink;

  Object? get error => _outerStream.errorOrNull;

  T? get state => _outerStream.valueOrNull;

  bool get hasError => _outerStream.hasError;

  bool get hasState => _outerStream.hasValue;

  bool get hasListener => _innerStream.hasListener;

  @override
  void onClose() {
    _outerStream.close();
    _innerStream.close();
  }

  void valueChange(T t) {

    innerStreamSink.add(t);
  }
}
