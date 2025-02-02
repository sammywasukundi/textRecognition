import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_recognition/views/theme/app_colors.dart';
import 'package:text_recognition/views/widgets/card_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

late ImagePicker imagePicker;
@override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      padding: const EdgeInsets.only(top: 30, left: 3, right: 3,bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          cardTop(),
          cardMiddle(context),
          cardBottom(context),
        ],
      ),
    );
  }
}
