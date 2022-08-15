import 'package:flutter/material.dart';
import 'package:odc_flutter_features/pages/home_page.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: WidgetAnimator(
              onIncomingAnimationComplete: finAnimation1,
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
                  duration: Duration(milliseconds: 800)),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.orange,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          if (showText)
            WidgetAnimator(
                onIncomingAnimationComplete: finAnimation2,
                incomingEffect: WidgetTransitionEffects.incomingScaleDown(
                    duration: Duration(milliseconds: 500)),
                child: Text(
                  'ODC Flutter',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ))
        ],
      )),
    );
  }

  finAnimation1(Key? p1) async {
    print("Fin Animation 1");
    showText = true;
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {});
  }

  finAnimation2(Key? p1) async {
    print("Fin Animation 2");
    await Future.delayed(Duration(milliseconds: 300));
    // navigation avec animation
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return HomePage();
          },
          transitionsBuilder:
              (_, Animation<double> animation, Animation<double> __, child) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 700),
        ));
  }
}
