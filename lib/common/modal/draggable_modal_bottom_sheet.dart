import 'package:background_locator/common/component/button/enum/round_degree.dart';
import 'package:background_locator/common/component/button/primary_elevated_button.dart';
import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/common/text/body_text.dart';
import 'package:background_locator/common/text/icon_and_text.dart';
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
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: _buildBoxDecoration(color: BODY_COLOR_01),
                      child: _buildModalBar(),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: BODY_COLOR_01,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BodyText(
                                          title: '운행 시작 전 목적지를 입력해주세요!',
                                          textSize: BodyTextSize.MEDIUM,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0,),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: PRIMARY_COLOR_06,
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(
                                              width: 1,
                                              color: PRIMARY_COLOR_07.withOpacity(0.2)
                                          )
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Icon(Icons.local_activity),
                                              BodyText(title: '목적지 입력', color: PRIMARY_COLOR_07, textSize: BodyTextSize.SMALL, fontWeight: FontWeight.w500,),
                                              Icon(Icons.search_outlined, size: 18, color: PRIMARY_COLOR_07,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.0,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BodyText(
                                                title: '자주가는 목적지',
                                                textSize: BodyTextSize.REGULAR,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              Icon(Icons.settings,
                                                size: 20,
                                                color: PRIMARY_COLOR_05,
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              IconAndText(
                                                iconData: Icons.home_outlined,
                                                title: '집',
                                              ),
                                              SizedBox(width: 25.0,),
                                              IconAndText(
                                                iconData: Icons.star_border_outlined,
                                                title: '물류창고1',
                                              ),
                                              SizedBox(width: 25.0,),
                                              IconAndText(
                                                iconData: Icons.star_border_outlined,
                                                title: '물류창고2',
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ),
                                  ],
                                )
                              )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                color: BODY_COLOR_01,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            BodyText(
                                              title: '진행 중인 광고',
                                              textSize: BodyTextSize.MEDIUM,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                      ],
                                    )
                                )
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: PrimaryElevatedButton(
                          title: '운행 시작',
                          roundDegree: RoundDegree.LOW,
                          backgroundColor: PRIMARY_COLOR_05,
                          textColor: PRIMARY_COLOR_04,
                          callback: () {},
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(height: 20,)
            ],
          ),
        );
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
