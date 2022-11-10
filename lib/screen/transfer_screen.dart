import 'package:flutter/material.dart';
import 'package:nutech_app/common/constant.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);
  static const routeName = '/transfer';

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  TextEditingController transferController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                child: Text('Amount*', style: kSubtitle),
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: transferController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    helperText: '*Minimal \$50',
                    helperStyle: kSubtitle.copyWith(color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    hintText: 'Transfer amount',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => transferController.text = '');
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ),
                  style: kSubtitle,
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                children: [
                  _card('\$100'),
                  _card('\$200'),
                  _card('\$500'),
                  _card('\$1000'),
                  _card('\$1500'),
                  _card('\$2000'),
                  _card('\$3000'),
                  _card('\$4000'),
                  _card('\$5000'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      margin: const EdgeInsets.only(right: 15, bottom: 15),
      // height: 50,
      width: MediaQuery.of(context).size.width / 3 - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: kSubtitle.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
