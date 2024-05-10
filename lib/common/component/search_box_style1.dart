import 'package:background_locator/common/const/colors.dart';
import 'package:flutter/material.dart';

class SearchBoxStyle1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: BODY_TEXT_COLOR5
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.search_outlined),
            SizedBox(width: 8,),
            Text('원하시는 지역을 검색해주세요.')
          ],
        ),
      )
    );
  }
  
}