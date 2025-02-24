// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../recognize_view.dart';
// import '../theme/app_colors.dart';

// class CardBottomWidget extends StatefulWidget {
//   final File image;
//   const CardBottomWidget({super.key, required this.image});

//   @override
//   State<CardBottomWidget> createState() => _CardBottomWidgetState();
// }

// class _CardBottomWidgetState extends State<CardBottomWidget> {
//   bool scan = false;
//   bool recognize = false;
//   bool enhance = false;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 1,
//       color: blueColor,
//       child: Container(
//         height: 90,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             InkWell(
//               onTap: () {},
//               child: Container(
//                 margin: const EdgeInsets.all(10),
//                 child: Icon(
//                   size: 35,
//                   Icons.rotate_left,
//                   color: whiteColor,
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Container(
//                 margin: const EdgeInsets.all(10),
//                 child: Icon(
//                   size: 50,
//                   Icons.camera_alt,
//                   color: whiteColor,
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () async {
//                 final ImagePicker imagePicker = ImagePicker();
//                 XFile? xfile = await imagePicker.pickImage(
//                   source: ImageSource.gallery,
//                 );
//                 if (xfile != null) {
//                   File image = File(xfile.path);
//                   if (recognize) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => RecognizeView(image: image),
//                       ),
//                     );
//                   } else if (scan) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CardBottomWidget(image: image),
//                       ),
//                     );
//                   }
//                 } else {}
//               },
//               child: Container(
//                 margin: const EdgeInsets.all(10),
//                 child: Icon(
//                   size: 35,
//                   Icons.image,
//                   color: whiteColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
