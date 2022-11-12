import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:stream_bloc/src/stream_base.dart';

class StreamValidator<T> extends StreamBase<T>{
  final _behaviorSubjectController = BehaviorSubject<T>(sync: true);
  final _innerStreamController = BehaviorSubject<T>(sync: true);

  @override
  ValueStream<T> get listener => _behaviorSubjectController.stream;

  ValueStream<T> get innerStream => _innerStreamController.stream;

  bool get hasValue => _behaviorSubjectController.hasValue;

  StreamSink<T> get streamSink => _behaviorSubjectController.sink;

  StreamSink<T> get innerStreamSink => _innerStreamController.sink;

  Object get error => _behaviorSubjectController.error;

  T get value => _behaviorSubjectController.value;

  bool get hasError => _behaviorSubjectController.hasError;


  @override
  void onClose(){
    _behaviorSubjectController.close();
    _innerStreamController.close();
  }

  void valueChange(T t) {
    innerStreamSink.add(t);
  }
}
