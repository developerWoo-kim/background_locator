import 'package:background_locator/model/on_camera_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onCameraChangeProvider = AutoDisposeStateNotifierProvider<OnCameraChangeNotifier, OnCameraStateModelBase>
  ((ref) => OnCameraChangeNotifier());

class OnCameraChangeNotifier extends StateNotifier<OnCameraStateModelBase> {
  OnCameraChangeNotifier() : super(OnCameraStateStanByModel());

  void action() {
    state = OnCameraStateActionModel(state: false);
  }

  void move() {
    if(state is OnCameraStateActionModel) {
      final pState = state as OnCameraStateActionModel;
      if(!pState.state) {
        state = OnCameraStateActionModel(state: true);
      };
    }
  }

  void stop() {
    if(state is OnCameraStateActionModel) {
      final pState = state as OnCameraStateActionModel;
      state = OnCameraStateActionModel(state: false);
    }
  }
}