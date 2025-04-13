import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtfo_rundown_roulette/public.dart';

/// the defacto look of boxed items in gtfo where the left border is thicker than the others
///
/// it can be a multitude of colors, but the ones i was able to gather are located in [PublicTheme]
///
/// it used for buttons primarily as well as information boxes. for the usage on buttons primarily
/// see its alternate: [UINormalBoxButton].
class UINormalBox extends StatelessWidget {
  final Widget child;
  final Color? foregroundColor;
  final bool thick;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  const UINormalBox({
    super.key,
    required this.child,
    this.foregroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.thick = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: foregroundColor ?? PublicTheme.normalWhite),
      child: DefaultTextStyle(
        style: TextStyle(
          fontFamily: "Shared Tech",
          color: foregroundColor ?? PublicTheme.normalWhite,
          fontSize: 18,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: foregroundColor ?? PublicTheme.normalWhite,
                width: thick ? 7 : 5,
              ),
              bottom: BorderSide(color: foregroundColor ?? PublicTheme.normalWhite, width: 2),
              top: BorderSide(color: foregroundColor ?? PublicTheme.normalWhite, width: 2),
              right: BorderSide(color: foregroundColor ?? PublicTheme.normalWhite, width: 2),
            ),
            color: backgroundColor ?? PublicTheme.abyssBlack,
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class UINormalBoxButton extends StatelessWidget {
  final Widget child;
  final Color? foregroundColor;
  final bool thick;
  final void Function() onTap;
  final EdgeInsetsGeometry padding;

  const UINormalBoxButton({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    required this.child,
    this.foregroundColor,
    required this.onTap,
    this.thick = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: UINormalBox(
        padding: padding,
        foregroundColor: foregroundColor,
        thick: thick,
        child: child,
      ),
    );
  }
}

class UINormalBoxInput extends StatefulWidget {
  final Color? foregroundColor;
  final void Function(String) onChanged;
  final String title;
  const UINormalBoxInput({
    super.key,
    this.foregroundColor,
    required this.onChanged,
    required this.title,
  });

  @override
  State<UINormalBoxInput> createState() => _UINormalBoxInputState();
}

class _UINormalBoxInputState extends State<UINormalBoxInput> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: PublicTheme.normalWhite, fontFamily: "Fira Code"),
      cursorRadius: Radius.zero,
      cursorColor: PublicTheme.normalWhite,
      cursorWidth: 10,
      cursorOpacityAnimates: false,
      controller: controller,
      onChanged: widget.onChanged,
      autocorrect: false,
      enableSuggestions: false,
      maxLength: 9,
      enableInteractiveSelection: true,
      enableIMEPersonalizedLearning: false,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(hintText: widget.title),
    );
  }
}
