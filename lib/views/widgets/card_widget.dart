import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../recognize_view.dart';
import '../theme/app_colors.dart';

Widget cardTop() {
  return Card(
    elevation: 1,
    color: blueColor,
    child: Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(
                      size: 25,
                      Icons.scanner,
                      color: whiteColor,
                    ),
                    Text(
                      'Scanner',
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(
                      size: 25,
                      Icons.document_scanner,
                      color: whiteColor,
                    ),
                    Text(
                      'Reconnaitre',
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(
                      size: 25,
                      Icons.assignment_sharp,
                      color: whiteColor,
                    ),
                    Text(
                      'Agrandir',
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
          ),
        ],
      ),
    ),
  );
}

Widget cardMiddle(BuildContext context) {
  return Card(
    color: greyColor,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.height - 260,
    ),
  );
}

Widget cardBottom(BuildContext context) {
  return Card(
    elevation: 1,
    color: blueColor,
    child: Container(
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Icon(
                size: 35,
                Icons.rotate_left,
                color: whiteColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Icon(
                size: 50,
                Icons.camera_alt,
                color: whiteColor,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final ImagePicker imagePicker = ImagePicker();
              XFile? xfile = await imagePicker.pickImage(
                source: ImageSource.gallery,
              );
              if (xfile != null) {
                File image = File(xfile.path);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecognizeView(image: image),
                  ),
                );
                
              } else {
                
              }
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Icon(
                size: 35,
                Icons.image,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
