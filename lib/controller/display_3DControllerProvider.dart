import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class Display3DControllerProvider extends ChangeNotifier {
  final Flutter3DController controller = Flutter3DController();
  bool isModelLoaded = false;
  String? chosenAnimation;
  String? chosenTexture;

  Display3DControllerProvider() {
    _initializePlatform();
    controller.onModelLoaded.addListener(() {
      isModelLoaded = controller.onModelLoaded.value;
      notifyListeners();
    });
  }
  void _initializePlatform() {
    if (WebViewPlatform.instance == null) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        // WebViewPlatform.instance = AndroidWebView();
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        // WebViewPlatform.instance = WebKitWebView();
      }
    }
  }

  Future<void> playAnimation([String? animationName]) async {
    if (isModelLoaded) {
      controller.playAnimation(animationName: animationName);
    }
  }

  Future<void> pauseAnimation() async {
    if (isModelLoaded) {
      controller.pauseAnimation();
    }
  }

  Future<void> resetAnimation() async {
    if (isModelLoaded) {
      controller.resetAnimation();
    }
  }

  Future<void> setCameraOrbit(double x, double y, double z) async {
    if (isModelLoaded) {
      controller.setCameraOrbit(x, y, z);
    }
  }

  Future<void> resetCameraOrbit() async {
    if (isModelLoaded) {
      controller.resetCameraOrbit();
    }
  }

  Future<List<String>> getAvailableAnimations() async {
    return isModelLoaded ? await controller.getAvailableAnimations() : [];
  }

  Future<List<String>> getAvailableTextures() async {
    return isModelLoaded ? await controller.getAvailableTextures() : [];
  }

  void setTexture(String textureName) {
    if (isModelLoaded) {
      controller.setTexture(textureName: textureName);
    }
  }
}
