import 'package:flutter/material.dart';

class CatapultaScrollView extends StatelessWidget {
  CatapultaScrollView({this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: SafeArea(child: child),
              ),
            ),
          );
        },
      ),
    );
  }
}
