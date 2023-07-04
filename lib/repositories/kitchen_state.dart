import 'package:flutter_riverpod/flutter_riverpod.dart';

class KitchenStateNotifier extends StateNotifier<bool> {
  KitchenStateNotifier() : super(false);

  void setButtonTap() {
    state = !state;
  }
}

final buttonTapProvider = StateNotifierProvider<KitchenStateNotifier, bool>((ref) {
  return KitchenStateNotifier();
});