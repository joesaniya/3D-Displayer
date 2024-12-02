import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class Display3DControllerProvider extends ChangeNotifier {
  late Object earth;
  final Flutter3DController controller = Flutter3DController();
  bool isModelLoaded = false;
  String? chosenAnimation;
  String? chosenTexture;
  late WebViewController _webViewController;

  Display3DControllerProvider() {
    earth = Object(fileName: "assets/3d_models/cat.obj");
    // _initializePlatform();
    initializeWebViewController();
    controller.onModelLoaded.addListener(() {
      isModelLoaded = controller.onModelLoaded.value;
      notifyListeners();
    });
  }

  void initializeObjects() {
    earth = Object(fileName: "assets/earth/earth_ball.obj");

    notifyListeners();
  }

  void addObjectToScene(Scene scene, Object object) {
    scene.world.add(object);
    scene.camera.zoom = 10;
    notifyListeners();
  }

  void _initializePlatform() {
    if (WebViewPlatform.instance == null) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        // WebViewPlatform.instance = SurfaceAndroidWebView();
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        // WebViewPlatform.instance = WKWebView();
      }
    }
  }

  Future<void> initializeWebViewController() async {
    late final PlatformWebViewControllerCreationParams params;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _webViewController = WebViewController.fromPlatformCreationParams(params);

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
            ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('Blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('Allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          /*  ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );*/
        },
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
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

  //
  final List<String> modelPaths = [
    'assets/3d_models/heart.obj',
    'assets/3d_models/flutter_dash.obj',
    'assets/3d_models/cat.obj',
  ];
  String? _selectedModelPath;

  String? get selectedModelPath => _selectedModelPath;

  void selectModel(String modelPath) {
    _selectedModelPath = modelPath;
    notifyListeners();
  }
}
