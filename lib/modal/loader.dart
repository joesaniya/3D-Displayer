import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_3d_model/controller/home-controller.dart';

class ModelController {
  final BuildContext context;

  ModelController(this.context);

  Future<void> pickAndLoadModel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['obj', 'stl', 'glb', 'gltf'],
    );

    if (result != null) {
      String path = result.files.single.path!;
      Provider.of<HomeProvider>(context, listen: false).loadModel(path);
      print('Model Loaded: $path');
    }
  }

  void rotateModel(double x, double y) {
    Provider.of<HomeProvider>(context, listen: false).updateRotation(x, y);
  }

  void zoomModel(double delta) {
    Provider.of<HomeProvider>(context, listen: false).updateZoom(delta);
  }
}
