// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:nutech_app/common/constant.dart';
// import 'package:nutech_app/models/transaction.dart';

// class OrderListItem extends StatelessWidget {
//   final Transaction? transaction;
//   final double? itemWidth;

//   OrderListItem({@required this.transaction, @required this.itemWidth});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 60,
//           height: 60,
//           margin: EdgeInsets.only(right: 12),
//           // decoration: BoxDecoration(
//           //     borderRadius: BorderRadius.circular(8),
//           //     image: DecorationImage(
//           //         image: NetworkImage(transaction!.food!.picturePath!),
//           //         fit: BoxFit.cover)),
//         ),
//         SizedBox(
//           width: (itemWidth! - 182), // (60-12-110)
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 transaction!.id!,
//                 style: blackFontStyle1,
//                 maxLines: 1,
//                 overflow: TextOverflow.clip,
//               ),
//               Text(
//                 "${transaction!.amount} item(s) - " +
//                     NumberFormat.currency(
//                             symbol: 'Rp ', decimalDigits: 0, locale: 'id-ID')
//                         .format(transaction!.amount),
//                 style: greyFontStyle.copyWith(fontSize: 13),
//               )
//             ],
//           ),
//         ),
//         SizedBox(
//           width: 110,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 converDateTime(transaction!.time!),
//                 style: greyFontStyle.copyWith(fontSize: 12),
//               ),
//               (transaction!.type == TransactionType.topup)
//                   ? Text(
//                       'Top Up',
//                       style: GoogleFonts.poppins(
//                           color: Colors.amber, fontSize: 10),
//                     )
//                   : (transaction!.type == TransactionType.transfer)
//                       ? Text(
//                           'Pending',
//                           style: GoogleFonts.poppins(
//                               color: Colors.cyan, fontSize: 10),
//                         )
//                       : SizedBox(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   String converDateTime(DateTime dateTime) {
//     String month;

//     switch (dateTime.month) {
//       case 1:
//         month = 'Jan';
//         break;
//       case 2:
//         month = 'Feb';
//         break;
//       case 3:
//         month = 'Mar';
//         break;
//       case 4:
//         month = 'Apr';
//         break;
//       case 5:
//         month = 'Mei';
//         break;
//       case 6:
//         month = 'Jun';
//         break;
//       case 7:
//         month = 'Jul';
//         break;
//       case 8:
//         month = 'Agus';
//         break;
//       case 9:
//         month = 'Sept';
//         break;
//       case 10:
//         month = 'Okt';
//         break;
//       case 11:
//         month = 'Nov';
//         break;
//       default:
//         month = 'Des';
//     }
//     return month + ' ${dateTime.day}, ${dateTime.hour}:${dateTime.minute} ';
//   }
// }
