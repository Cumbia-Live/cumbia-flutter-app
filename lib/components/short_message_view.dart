import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:flutter/material.dart';

class ShortMessageView extends StatelessWidget {
  final Widget topWidget;
  final String title;
  final String label;
  final String buttonLabel;
  final Function onPressed;
  final bool withoutLabel;
  final bool isDark;

  const ShortMessageView({
    this.topWidget,
    this.title,
    this.label,
    this.buttonLabel,
    this.onPressed,
    this.withoutLabel,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        topWidget ?? const SizedBox.shrink(),
        topWidget == null ? SizedBox.shrink() : SizedBox(height: 36),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            title ?? "Sin resultados",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Palette.white : Palette.black,
            ),
          ),
        ),
        withoutLabel ?? true
            ? const SizedBox(height: 16)
            : const SizedBox.shrink(),
        withoutLabel ?? true
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Text(
                  label ?? "Parece que no hay nada por mostrar.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark
                        ? Palette.white.withOpacity(0.7)
                        : Palette.black.withOpacity(0.5),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        buttonLabel == null
            ? SizedBox.shrink()
            : CumbiaTextButton(
                title: buttonLabel,
                onPressed: onPressed,
              ),
      ],
    );
  }
}
