import 'package:flutter/material.dart';
import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/main.dart';
import 'package:nutech_app/screen/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      email == null
          ? Navigator.pushReplacementNamed(context, SigninScreen.routeName)
          : Navigator.pushReplacementNamed(context, SigninScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/logo.png')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
