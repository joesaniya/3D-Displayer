import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:provider/provider.dart';
import 'package:sample_3d_model/controller/display_3DControllerProvider.dart';
import 'package:sample_3d_model/view/home-screen.dart';
import 'package:sample_3d_model/view/widgets/floating-button.dart';

class Display3dscreen extends StatelessWidget {
  const Display3dscreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Display3DControllerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Display3dscreen'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              icon: Icon(Icons.upload))
        ],
        backgroundColor: const Color(0xff0d2039),
      ),
      floatingActionButton: FloatingActionButtons(provider: provider),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Flutter3DViewer.obj(
              src: 'assets/3d_models/heart.obj',
              scale: 5,
              cameraX: 0,
              cameraY: 0,
              cameraZ: 10,
              onProgress: (double progressValue) {
                debugPrint('Model loading progress: $progressValue');
              },
              onLoad: (String modelAddress) {
                debugPrint('Model loaded: $modelAddress');
              },
              onError: (String error) {
                debugPrint('Model failed to load: $error');
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: Flutter3DViewer(
              activeGestureInterceptor: true,
              enableTouch: true,
              controller: provider.controller,
              src: 'assets/3d_models/business_man.glb',
              onProgress: (double progressValue) {
                debugPrint('Model loading progress: $progressValue');
              },
              onLoad: (String modelAddress) {
                debugPrint('Model loaded: $modelAddress');
              },
              onError: (String error) {
                debugPrint('Model failed to load: $error');
              },
            ),
          ),
        ],
      ),
    );
  }
}
