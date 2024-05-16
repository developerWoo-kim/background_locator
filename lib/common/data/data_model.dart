
class DataModel {
  final String name;
  final String title;
  final String address;
  final String image;
  final double lat;
  final double lot;
  final int viewLevel;
  final String? count;

  DataModel({
    required this.name,
    required this.title,
    required this.address,
    required this.image,
    required this.lat,
    required this.lot,
    required this.viewLevel,
    this.count,
  });

}