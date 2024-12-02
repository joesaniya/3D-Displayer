import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_3d_model/controller/provier-common.dart';
import 'package:sample_3d_model/view/Display_3DScreem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: ProviderHelperClass.instance.providerLists,
        // child: ,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
              fontFamily: "Montserrat",
              useMaterial3: false,
            ),
            home: Display3dscreen(),
          );
        });
  }
}
