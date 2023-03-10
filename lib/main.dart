import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'features/bpm/page/bp_home_view.dart';
import 'product/navigator/navigation_manager.dart';
import 'product/navigator/navigator_custom.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget with NavigatorCustom {
  static const String title = 'Notes SQLite';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.blueGrey.shade900,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return const BPHomePage();
            },
          );
        },
        initialRoute: '/',
        onGenerateRoute: onGenerareRoute,
        navigatorKey: NavigatorManager.instance.navigatorGlobalKey,
      );
}
