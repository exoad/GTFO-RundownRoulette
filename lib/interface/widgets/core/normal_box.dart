import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/public.dart';

class UINormalBox extends StatelessWidget {
  final Widget child;
  final Color? foregroundColor;
  final bool thick;

  const UINormalBox({
    super.key,
    required this.child,
    this.foregroundColor,
    this.thick = false,
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
              bottom: BorderSide(
                color: foregroundColor ?? PublicTheme.normalWhite,
                width: 2,
              ),
              top: BorderSide(
                color: foregroundColor ?? PublicTheme.normalWhite,
                width: 2,
              ),
              right: BorderSide(
                color: foregroundColor ?? PublicTheme.normalWhite,
                width: 2,
              ),
            ),
            color: PublicTheme.abyssBlack,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: child,
        ),
      ),
    );
  }
}
