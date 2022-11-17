import 'dart:async';

import 'package:live_stream/src/live_stream.dart';
import 'package:rxdart/rxdart.dart';

class StreamValidator<T> extends StreamBase<T> {
  final _outerStream = BehaviorSubject<T>(sync: true);
  final _innerStreamController = BehaviorSubject<T>(sync: true);

  @override
  ValueStream<T> get listener => _outerStream.stream;

  ValueStream<T> get innerStream => _innerStreamController.stream;

  bool get hasState => _outerStream.hasValue;

  StreamSink<T> get streamSink => _outerStream.sink;

  StreamSink<T> get innerStreamSink => _innerStreamController.sink;

  Object get error => _outerStream.error;

  T get state => _outerStream.value;

  bool get hasError => _outerStream.hasError;

  @override
  void onClose() {
    _outerStream.close();
    _innerStreamController.close();
  }

  void valueChange(T t) {
    innerStreamSink.add(t);
  }
}
