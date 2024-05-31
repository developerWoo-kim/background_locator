abstract class OnCameraStateModelBase {}

class OnCameraStateStanByModel extends OnCameraStateModelBase {}

class OnCameraStateActionModel extends OnCameraStateModelBase{
  final bool state;

  OnCameraStateActionModel({
    required this.state
  });



}