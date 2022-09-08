import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:odc_flutter_features/controllers/app_controller.dart';
import 'package:odc_flutter_features/controllers/chat_controller.dart';
import 'package:odc_flutter_features/controllers/gallery_controller.dart';
import 'package:odc_flutter_features/controllers/location_controller.dart';
import 'package:odc_flutter_features/controllers/notification_controller.dart';
import 'package:odc_flutter_features/pages/splash_screen_page.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'controllers/calendar_controller.dart';
import 'utils/const.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );
  AssetPicker.registerObserve();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext ctx) => AppController()),
        ChangeNotifierProvider(
            create: (BuildContext ctx) => GalleryContoller()),
        ChangeNotifierProvider(
            create: (BuildContext ctx) => LocationController()),
        ChangeNotifierProvider(
            create: (BuildContext ctx) => NotificationController()),
        ChangeNotifierProvider(create: (BuildContext ctx) => ChatController()),
        ChangeNotifierProvider(create: (BuildContext ctx) => CalendarController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            scaffoldBackgroundColor: Consts.DEFAULT_SCAFFOLD_BG,
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
            )),
        home: Provider(
            create: (_) => AppController(),
            builder: (context, _) {
              return SplashScreenPage();
            }),
      ),
    );
  }
}
