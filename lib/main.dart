import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Key splashAppKey = UniqueKey();
// ignore: constant_identifier_names
const int STARTUP_DELAY_MS = 500;

void main() {
  runApp(SplashAppInternal());
}

class SplashAppInternal extends StatefulWidget {
  SplashAppInternal() : super(key: splashAppKey);

  @override
  _SplashAppInternalState createState() => _SplashAppInternalState();
}

class _SplashAppInternalState extends State<SplashAppInternal> with TickerProviderStateMixin {
  late AnimationController _lottieAnimCtrl;

  @override
  void initState() {
    super.initState();

    _lottieAnimCtrl = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieAnimCtrl.dispose();
    super.dispose();
  }

  bool _startedInitializing = false;

  Future<void> _initializeAsyncDependencies() async {
    if (_startedInitializing) return; // Was already called
    _startedInitializing = true;

    await Future.delayed(const Duration(milliseconds: STARTUP_DELAY_MS));
    _lottieAnimCtrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WidgetsApp(
        color: Colors.blue,
        builder: (ctx, __) => Scaffold(
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints.expand(),
                alignment: Alignment.center,
                color: Colors.white,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Lottie.asset(
                    "assets/lottie/banner.json",
                    fit: BoxFit.contain,
                    controller: _lottieAnimCtrl,
                    onLoaded: (c) {
                      _lottieAnimCtrl.duration = c.duration;
                      _initializeAsyncDependencies();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ActualApp extends StatelessWidget {
  const ActualApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
          body: Center(
        child: Text('Hello :)'),
      )),
    );
  }
}
