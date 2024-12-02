import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:sample_3d_model/controller/home-controller.dart';
import 'package:sample_3d_model/modal/loader.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3D Model Displayer'),
        backgroundColor: Color(0xff0d2039),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              final controller = ModelController(context);
              controller.pickAndLoadModel();
            },
            child: Text('Load 3D Model'),
          ),
          if (Provider.of<HomeProvider>(context).isModelLoaded)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.rotate_left),
                  onPressed: () {
                    final controller = ModelController(context);
                    controller.rotateModel(-0.1, 0);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.rotate_right),
                  onPressed: () {
                    final controller = ModelController(context);
                    controller.rotateModel(0.1, 0);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.zoom_in),
                  onPressed: () {
                    final controller = ModelController(context);
                    controller.zoomModel(0.1);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.zoom_out),
                  onPressed: () {
                    final controller = ModelController(context);
                    controller.zoomModel(-0.1);
                  },
                ),
              ],
            ),
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, modelProvider, child) {
                if (!modelProvider.isModelLoaded) {
                  return Center(child: Text('No 3D Model Loaded'));
                } else {
                  return WebviewScaffold(
                    url: Uri.dataFromString(
                      '''
                      <html>
                        <head>
                          <title>3D Model Viewer</title>
                          <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
                          <script src="https://cdn.jsdelivr.net/npm/three/examples/js/loaders/GLTFLoader.js"></script>
                        </head>
                        <body>
                          <script>
                            var scene = new THREE.Scene();
                            var camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
                            var renderer = new THREE.WebGLRenderer();
                            renderer.setSize(window.innerWidth, window.innerHeight);
                            document.body.appendChild(renderer.domElement);

                            var loader = new THREE.GLTFLoader();
                            loader.load("file:///${modelProvider.modelPath}", function(gltf) {
                              scene.add(gltf.scene);
                              renderer.render(scene, camera);
                            }, undefined, function(error) {
                              console.error(error);
                            });

                            camera.position.z = 5;

                            var animate = function() {
                              requestAnimationFrame(animate);
                              renderer.render(scene, camera);
                            };

                            animate();

                            // Rotate model based on user interaction
                            window.addEventListener("keydown", function(event) {
                              if (event.key === "ArrowLeft") {
                                camera.rotation.y += 0.1;
                              } else if (event.key === "ArrowRight") {
                                camera.rotation.y -= 0.1;
                              }
                            });

                            // Zoom with mouse wheel
                            window.addEventListener("wheel", function(event) {
                              camera.position.z += event.deltaY * 0.05;
                            });
                          </script>
                        </body>
                      </html>
                      ''',
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'),
                    ).toString(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
/*
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider controller;
  @override
  void initState() {
    super.initState();
    // controller = FxControllerStore.put(HomeProvider());
    controller = HomeProvider();
  }

  @override
  Widget build(BuildContext context) {
    /*  return ChangeNotifierProvider<HomeProvider>(
      create: (_) => controller,
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home Screen'),
            ),
            body: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : const Text('data'), // Replace with actual UI
          );
        },
      ),
    );*/
    return Consumer<HomeProvider>(builder: (context, m, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: m.isLoading
            ? const Center(child: CircularProgressIndicator())
            : const Text('data'), // Replace with actual UI
      );
    });
  }
}
*/