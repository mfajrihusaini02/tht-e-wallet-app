import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/cubit/balance_cubit.dart';
import 'package:nutech_app/cubit/topup_cubit.dart';
import 'package:nutech_app/cubit/transaction_cubit.dart';
import 'package:nutech_app/cubit/transfer_cubit.dart';
import 'package:nutech_app/cubit/user_cubit.dart';
import 'package:nutech_app/screen/done_screen.dart';
import 'package:nutech_app/screen/home_screen.dart';
import 'package:nutech_app/screen/main_screen.dart';
import 'package:nutech_app/screen/signin_screen.dart';
import 'package:nutech_app/screen/signup_screen.dart';
import 'package:nutech_app/screen/splash_screen.dart';
import 'package:nutech_app/screen/topup_screen.dart';
import 'package:nutech_app/screen/transfer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? email = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => BalanceCubit()),
        BlocProvider(create: (_) => TransactionCubit()),
        BlocProvider(create: (_) => TransferCubit()),
        BlocProvider(create: (_) => TopupCubit()),
      ],
      child: GetMaterialApp(
        title: 'Nutech Wallet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: kTextTheme,
        ),
        home: const SplashScreen(),
        onGenerateRoute: (RouteSettings route) {
          switch (route.name) {
            case '/signin':
              return MaterialPageRoute(builder: (_) => const SigninScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) => const SignupScreen());
            case '/done':
              return MaterialPageRoute(builder: (_) => const DoneScreen());
            case '/main':
              return MaterialPageRoute(builder: (_) => const MainScreen());
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeScreen());
            case '/topup':
              return MaterialPageRoute(builder: (_) => const TopupScreen());
            case '/transfer':
              return MaterialPageRoute(builder: (_) => const TransferScreen());
            case '/account':
              return MaterialPageRoute(builder: (_) => const HomeScreen());
            case '/accountEdit':
              return MaterialPageRoute(builder: (_) => const HomeScreen());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
