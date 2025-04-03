import 'package:flutter/material.dart';
import 'package:gtfo_rundown_roulette/public.dart';

extension SanctionedWidget on Widget {
  Widget get sanctioned {
    return !Public.isRelease
        ? this
        : const Center(
          child: Text(
            "This place is still being developed... check back later!",
            style: TextStyle(
              fontFamily: "Shared Tech",
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
        );
  }
}
