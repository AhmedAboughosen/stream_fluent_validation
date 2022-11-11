import 'dart:async';

import 'package:rxdart/rxdart.dart';

class StreamValidator<T> {
  final _behaviorSubjectController = BehaviorSubject<T>(sync: true);
  final _innerStreamController = BehaviorSubject<T>(sync: true);

  ValueStream<T> get stream => _behaviorSubjectController.stream;

  ValueStream<T> get innerStream => _innerStreamController.stream;

  bool get hasValue => _behaviorSubjectController.hasValue;

  StreamSink<T> get streamSink => _behaviorSubjectController.sink;

  StreamSink<T> get innerStreamSink => _innerStreamController.sink;

  Object get error => _behaviorSubjectController.error;

  T get value => _behaviorSubjectController.value;

  bool get hasError => _behaviorSubjectController.hasError;


  void close(){
    _behaviorSubjectController.close();
    _innerStreamController.close();
  }

  void valueChange(T t) {
    innerStreamSink.add(t);
  }
}
