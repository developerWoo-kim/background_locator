
import 'package:background_locator/common/component/button/enum/round_degree.dart';
import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/common/text/body_text.dart';
import 'package:flutter/material.dart';

class PrimaryElevatedButton extends StatelessWidget {
  final String title;
  final RoundDegree? roundDegree;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback callback;

  const PrimaryElevatedButton({
    required this.title,
    this.roundDegree,
    this.backgroundColor,
    this.textColor,
    required this.callback,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? PRIMARY_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(roundDegree != null ? roundDegree!.value : RoundDegree.NONE.value),
            )
        ),
        onPressed: callback,
        child: BodyText(
          title: title,
          textSize: BodyTextSize.MEDIUM,
          color: textColor ?? BODY_TEXT_COLOR_03,
          fontWeight: FontWeight.w500,
        )
    );
  }
}
