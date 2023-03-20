import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spacetools/main_page.dart';
import 'package:spacetools/provider/app_provider.dart';
import './pages/login_screen1.dart';
import 'constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  await Hive.initFlutter();
  await Hive.openBox('address');
  await Hive.openBox('worth');
  ErrorWidget.builder = (details) {
    if (kDebugMode) {
      return ErrorWidget(details);
    }
    return const Center(
      child: Text('Something went wrong :('),
    );
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('address');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Inter',
          scaffoldBackgroundColor: Colors.transparent,
          useMaterial3: true,
          iconTheme: const IconThemeData(color: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kLighterColor,
              foregroundColor: Colors.white,
              surfaceTintColor: kGreyColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(width: 0),
            ),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            bodyLarge: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            labelMedium: TextStyle(
              fontSize: 15,
              color: kGreyColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        home: box.isEmpty
            ? const LoginScreen1()
            : MainPage(address: box.get('address')),
      ),
    );
  }
}
