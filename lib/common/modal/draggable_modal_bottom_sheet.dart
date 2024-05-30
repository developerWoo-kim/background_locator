import 'package:background_locator/common/component/button/enum/round_degree.dart';
import 'package:background_locator/common/component/button/primary_elevated_button.dart';
import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/common/text/body_text.dart';
import 'package:background_locator/common/text/icon_and_text.dart';
import 'package:background_locator/screen/search_map_screen.dart';
import 'package:flutter/material.dart';

class DraggableModalBottomSheet extends StatelessWidget {
  final BuildContext context;
  final ScrollController scrollController;
  final Widget content;


  const DraggableModalBottomSheet({
    required this.context,
    required this.content,
    required this.scrollController,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    return DraggableScrollableSheet(
      // 화면 비율로 높이 조정
      snap: true,
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: _buildBoxDecoration(color: BODY_COLOR_02),
          child: content
        );
        // return SingleChildScrollView(
        //   controller: scrollController,
        //   child: Container(
        //       height: 1500,
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(20),
        //               topRight: Radius.circular(20)),
        //           color: BODY_COLOR_01,
        //       ),
        //       child: Column(
        //         children: [
        //           _ModalBar(),
        //           SizedBox(height: 10.0,),
        //           content,
        //         ],
        //       )
        //   ),
        // );
      },
    );
  }

  Widget _buildModalBar() {
    return FractionallySizedBox(
      widthFactor: 0.20,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: LINE_CLOR_01,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration({required Color color}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
      ),
    );
  }
}
