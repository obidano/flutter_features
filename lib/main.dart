import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:odc_flutter_features/controllers/app_controller.dart';
import 'package:odc_flutter_features/controllers/chat_controller.dart';
import 'package:odc_flutter_features/controllers/gallery_controller.dart';
import 'package:odc_flutter_features/controllers/location_controller.dart';
import 'package:odc_flutter_features/controllers/notification_controller.dart';
import 'package:odc_flutter_features/pages/splash_screen_page.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'controllers/calendar_controller.dart';
import 'controllers/socket_controller.dart';
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

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale= Locale('sw') ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  setLocale(Locale locale) {
    _locale = locale;
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext ctx) => SocketController()),
        ChangeNotifierProvider(create: (BuildContext ctx) => AppController()),
        ChangeNotifierProvider(
            create: (BuildContext ctx) => GalleryContoller()),
        ChangeNotifierProvider(
            create: (BuildContext ctx) => LocationController()),
        ChangeNotifierProvider(
            create: (BuildContext ctx) => NotificationController()),
        ChangeNotifierProvider(create: (BuildContext ctx) => ChatController()),
        ChangeNotifierProvider(
            create: (BuildContext ctx) => CalendarController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale:_locale,
        /*localeResolutionCallback: (deviceLocale, supportedLocales) {
          print('devicle locale ${deviceLocale?.languageCode}');
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale?.languageCode) {
              return deviceLocale;
            }
          }
          print('Ln not supported');
          return Locale('en');
          //return supportedLocales.first;
        },*/
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
