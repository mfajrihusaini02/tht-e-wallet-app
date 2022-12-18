import 'package:flutter/material.dart';
import 'package:nutech_app/common/constant.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);
  static const routeName = '/done';

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/signin');
    });
  }

  

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Success',
          style: kHeading6,
        ),
      ),
    );
  }
}
