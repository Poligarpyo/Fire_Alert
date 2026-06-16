import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final globalLoaderProvider =
    StateNotifierProvider<GlobalLoaderController, bool>(
      (ref) => GlobalLoaderController(),
    );

class GlobalLoaderController extends StateNotifier<bool> {
  GlobalLoaderController() : super(false);

  void show() => state = true;

  void hide() => state = false;
}
