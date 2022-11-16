import 'dart:async';

import 'package:live_stream_base/live_stream.dart';
import 'package:rxdart/rxdart.dart';

class StreamValidator<T> extends StreamBase<T>{
  final _behaviorSubjectController = BehaviorSubject<T>(sync: true);
  final _innerStreamController = BehaviorSubject<T>(sync: true);

  @override
  ValueStream<T> get listener => _behaviorSubjectController.stream;

  ValueStream<T> get innerStream => _innerStreamController.stream;

  bool get hasState => _behaviorSubjectController.hasValue;

  StreamSink<T> get streamSink => _behaviorSubjectController.sink;

  StreamSink<T> get innerStreamSink => _innerStreamController.sink;

  Object get error => _behaviorSubjectController.error;

  T get state => _behaviorSubjectController.value;

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
