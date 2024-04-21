import 'package:flutter/material.dart';
import 'package:stream_fluent_validation/fluent_validation.dart';

typedef AsyncWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot);

class ValidationState extends StatelessWidget {
  final StreamValidator validator;

  /// The build strategy currently used by this builder.
  ///
  /// This builder must only return a widget and should not have any side
  /// effects as it may be called multiple times.
  final AsyncWidgetBuilder builder;

  const ValidationState(
      {Key? key, required this.validator, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: validator.stream,
      builder: (context, snap) {
        return builder(context, snap);
      },
    );
  }
}
