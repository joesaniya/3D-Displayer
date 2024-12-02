import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sample_3d_model/controller/display_3DControllerProvider.dart';
import 'package:sample_3d_model/controller/home-controller.dart';

class ProviderHelperClass {
  static ProviderHelperClass? _instance;

  static ProviderHelperClass get instance {
    _instance ??= ProviderHelperClass();
    return _instance!;
  }

  List<SingleChildWidget> providerLists = [
    ChangeNotifierProvider(create: (context) => HomeProvider()),
    ChangeNotifierProvider(create: (context) => Display3DControllerProvider()),
  ];
}
