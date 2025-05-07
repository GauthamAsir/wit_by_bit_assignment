import 'package:amerika_foods/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.useScaffold = false,
  });

  final bool useScaffold;

  @override
  Widget build(BuildContext context) {
    return useScaffold
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(context.cs.primary),
                strokeWidth: 5,
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(context.cs.primary),
              strokeWidth: 5,
            ),
          );
  }
}
