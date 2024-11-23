import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: const TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: 'Quiz',
            style:
                TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
        TextSpan(
            text: 'Me',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.lightGreen)),
      ],
    ),
  );
}

// Widget mainButton(BuildContext context, String label) {
//   return Container(
//     height: 50,
//     padding: const EdgeInsets.symmetric(vertical: 14),
//     decoration: BoxDecoration(
//       color: Colors.lightGreen,
//       borderRadius: BorderRadius.circular(30),
//     ),
//     alignment: Alignment.center,
//     width: MediaQuery.of(context).size.width - 48,
//     child: Text(label,
//         style: const TextStyle(
//             color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
//   );
// }

Widget mainButton({required BuildContext context,required String label, buttonWidth}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      color: Colors.lightGreen,
      borderRadius: BorderRadius.circular(30),
    ),
    alignment: Alignment.center,
    width: buttonWidth ?? MediaQuery.of(context).size.width - 48,
    child: Text(label,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
  );
}
