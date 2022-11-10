// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/cubit/balance_cubit.dart';
import 'package:nutech_app/cubit/user_cubit.dart';
import 'package:nutech_app/screen/done_screen.dart';
import 'package:nutech_app/screen/topup_screen.dart';
import 'package:nutech_app/screen/transfer_screen.dart';
import 'package:nutech_app/widget/fitur_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController transferController = TextEditingController();
  TextEditingController topupController = TextEditingController();
  late FToast fToast;
  bool isLoading = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.blue,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.notifications_active_outlined,
            color: kWhite,
          ),
          const SizedBox(width: 12),
          Text(
            'Notification',
            style: kSubtitle.copyWith(color: kWhite),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/nutech-1.jpg',
      'assets/nutech-2.jpg',
      'assets/nutech-3.jpg',
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: [
                    Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
            ))
        .toList();

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<UserCubit>().getUser();
        await context.read<BalanceCubit>().getBalances();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SafeArea(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'NUTech Wallet',
                                        style: kHeading6.copyWith(
                                          color: kWhite,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => _showToast(),
                                        icon: const Icon(
                                          Icons.notifications_outlined,
                                          color: kWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Hi, ${(context.read<UserCubit>().state as UserLoaded).user!.firstName!} ${(context.read<UserCubit>().state as UserLoaded).user!.lastName!}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: kWhite,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'My balance',
                                        style: kHeading6.copyWith(
                                          color: kWhite,
                                        ),
                                      ),
                                      Text(
                                        // "\$ ${NumberFormat.currency(
                                        //   symbol: '',
                                        //   decimalDigits: 0,
                                        //   locale: 'en-US',
                                        // ).format((context.read<BalanceCubit>().state as BalanceLoaded).balance!.balance ?? '0')}",
                                        "\$ ${(context.read<BalanceCubit>().state as BalanceLoaded).balance!.balance ?? '0'}",
                                        style: kHeading6.copyWith(
                                          color: kWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          margin: const EdgeInsets.only(top: 210),
                          decoration: const BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 50,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, TransferScreen.routeName),
                                child: const FiturCard(
                                  'Transfer',
                                  Icons.send_outlined,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, TopupScreen.routeName);
                                },
                                child: const FiturCard(
                                  'Top Up',
                                  Icons.upload_outlined,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DoneScreen.routeName);
                                },
                                child: const FiturCard(
                                  'Scan',
                                  Icons.qr_code_scanner_outlined,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'E-Payment',
                          style: kHeading6,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _card('Phone', Icons.mobile_screen_share_sharp),
                            _card('Paket Data', Icons.brightness_6),
                            _card('PDAM', Icons.agriculture_outlined)
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _card('Wifi', Icons.wifi),
                            _card('PLN', Icons.ac_unit),
                            _card('More', Icons.abc)
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Promo',
                          style: kHeading6,
                        ),
                        Text(
                          'See all',
                          style: kSubtitle,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 160,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                ),
                                items: imageSliders,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:
                                      imgList.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: 7.0,
                                        height: 7.0,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              (Theme.of(context).brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.blue)
                                                  .withOpacity(
                                            _current == entry.key ? 0.9 : 0.3,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(String text, IconData icon) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
          ),
          Text(text),
        ],
      ),
    );
  }
}
