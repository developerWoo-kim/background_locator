import 'package:json_annotation/json_annotation.dart';

part 'map_info_model.g.dart';

abstract class MapInfoModelBase {}

class MapInfoModelLoading extends MapInfoModelBase {}

class MapInfoModelEmptyData extends MapInfoModelBase {}

class MapInfoModelError extends MapInfoModelBase {
  final String message;

  MapInfoModelError({required this.message});
}

@JsonSerializable()
class MapInfoModel extends MapInfoModelBase{
  String title;
  String address;
  String image;
}