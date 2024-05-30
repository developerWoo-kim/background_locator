import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/common/text/body_text.dart';
import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final IconData iconData;
  final String title;
  const IconAndText({
    required this.iconData,
    required this.title,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            iconData,
            color: PRIMARY_COLOR_05,
            size: 20,
          ),
          SizedBox(width: 6.0,),
          BodyText(
            title: title,
            textSize: BodyTextSize.SMALL,
          )
        ],
      ),
    );
  }
}
