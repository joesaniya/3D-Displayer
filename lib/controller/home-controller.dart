import 'package:flutter/material.dart';

/*class HomeProvider extends ChangeNotifier {
void goBack(BuildContext context) {
    Navigator.pop(context);
  }
  
   @override
  notifyListeners();
}

*/

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _modelPath = '';
  bool _isModelLoaded = false;
  double _rotationX = 0.0;
  double _rotationY = 0.0;
  double _zoom = 1.0;

  String get modelPath => _modelPath;
  bool get isModelLoaded => _isModelLoaded;
  double get rotationX => _rotationX;
  double get rotationY => _rotationY;
  double get zoom => _zoom;

  void loadModel(String path) {
    _modelPath = path;
    _isModelLoaded = true;
    notifyListeners();
  }

  void updateRotation(double x, double y) {
    _rotationX += x;
    _rotationY += y;
    notifyListeners();
  }

  void updateZoom(double delta) {
    _zoom += delta;
    notifyListeners();
  }

  void loadData() {
    _isLoading = true;
    notifyListeners();

    // Simulate data fetching
    Future.delayed(const Duration(seconds: 2), () {
      _isLoading = false;
      notifyListeners();
    });
  }
}
