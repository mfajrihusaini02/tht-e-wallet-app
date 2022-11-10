import 'package:flutter/material.dart';
import 'package:nutech_app/common/constant.dart';

class FiturCard extends StatelessWidget {
  final String nameFitur;
  final IconData iconData;
  const FiturCard(this.nameFitur, this.iconData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 30,
            color: kWhite,
          ),
          Text(
            nameFitur,
            style: kSubtitle.copyWith(color: kWhite),
          ),
        ],
      ),
    );
  }
}
