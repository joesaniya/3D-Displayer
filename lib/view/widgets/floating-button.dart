import 'package:flutter/material.dart';
import 'package:sample_3d_model/controller/display_3DControllerProvider.dart';

class FloatingActionButtons extends StatelessWidget {
  final Display3DControllerProvider  provider;

  const FloatingActionButtons({super.key, required this.provider});

  void _handleModelNotLoaded(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Model is still loading. Please wait!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {
            provider.isModelLoaded
                ? provider.playAnimation()
                : _handleModelNotLoaded(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.pause),
          onPressed: () {
            provider.isModelLoaded
                ? provider.pauseAnimation()
                : _handleModelNotLoaded(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay_circle_filled),
          onPressed: () {
            provider.isModelLoaded
                ? provider.resetAnimation()
                : _handleModelNotLoaded(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () {
            provider.isModelLoaded
                ? provider.setCameraOrbit(20, 20, 5)
                : _handleModelNotLoaded(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.cameraswitch_outlined),
          onPressed: () {
            provider.isModelLoaded
                ? provider.resetCameraOrbit()
                : _handleModelNotLoaded(context);
          },
        ),
      ],
    );
  }
}