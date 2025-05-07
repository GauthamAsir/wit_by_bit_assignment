import 'package:flutter/material.dart';

typedef CustomBuilderFunction = Widget Function(
  BuildContext context,
  Widget? child,
  Widget? child2,
);

class CustomBuilder extends StatelessWidget {
  const CustomBuilder({required CustomBuilderFunction builder, super.key,
      Widget? child,
    Widget? child2,
  })  : _child = child,
        _builder = builder,
        _child2 = child2;

  final CustomBuilderFunction _builder;
  final Widget? _child, _child2;

  @override
  Widget build(BuildContext context) => _builder(context, _child, _child2);
}