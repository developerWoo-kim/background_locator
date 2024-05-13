import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/common/util/app_bar_util.dart';
import 'package:background_locator/layout/default_layout.dart';
import 'package:background_locator/provider/location_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchMapScreen extends ConsumerStatefulWidget {
  const SearchMapScreen({super.key});

  @override
  ConsumerState<SearchMapScreen> createState() => _SearchMapScreenState();
}

class _SearchMapScreenState extends ConsumerState<SearchMapScreen> {
  final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: BODY_TEXT_COLOR5)
  );

  bool _showClearIcon = false;

  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _textEditingController.addListener(() {
      setState(() {
        _showClearIcon = _textEditingController.text.isNotEmpty;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Container(
        color: BODY_TEXT_COLOR5,
        child: Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: ListView.separated(
                controller: _scrollController,
                itemCount: 2,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, {'lat': 36.33618408, 'lot': 127.394369});
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('유천동',
                          style: TextStyle(
                              color: PRIMARY_COLOR,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Text('대전광역시 중구 유천동',
                          style: TextStyle(
                              color: BODY_TEXT_COLOR,
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return Column(
                    children: [
                      SizedBox(height: 5.0),
                      Divider(color: GREY_01, thickness: 1.0),
                      SizedBox(height: 5.0),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void search() async {
    final dio = Dio();

    final resp = await dio.get(
        'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=',
        options: Options(
          headers: {
            'X-NCP-APIGW-API-KEY-ID' : 'zrdf8d2wts',
            'X-NCP-APIGW-API-KEY' : 'JqW8OkxjaDistI7ivR1HZpdmkWTmXOFnVAGF6ual',
          }
        )
    );
  }

  String? searchText = '';

  AppBar renderAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(
          right: 5.0,
        ),
        child: Container(
          child: Center(
            child: TextFormField(
              controller: _textEditingController,
              autofocus: false,
              onFieldSubmitted: (value) async {
                search();
              },
              onChanged: (String value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                isDense: true,
                fillColor: BODY_TEXT_COLOR5,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                filled: true,
                hintText: '원하시는 지역을 검색하세요.',
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: BODY_TEXT_COLOR2,
                    fontWeight: FontWeight.w500
                ),
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
                prefixIcon: Icon(Icons.search_outlined),
                suffixIcon: _showClearIcon
                    ? IconButton(
                    onPressed: () {
                      searchText = '';
                      _textEditingController.clear();
                    },
                    icon: Icon(Icons.clear_outlined)
                )
                    : null,
              ),
              cursorHeight: 18,
            ),
          ),
        ),
      ),
    );
  }
}
