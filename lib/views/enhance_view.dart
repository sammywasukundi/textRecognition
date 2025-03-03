// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_editor_plus/image_editor_plus.dart';
//import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'theme/app_colors.dart';

// ignore: must_be_immutable
class EnhanceView extends StatefulWidget {
  File image;
  EnhanceView(this.image, {super.key});

  @override
  State<EnhanceView> createState() => _RecognizeViewState();
}

class _RecognizeViewState extends State<EnhanceView> {
  late img.Image inputImage;
  @override
  void initState() {
    super.initState();
    inputImage = img.decodeImage(widget.image.readAsBytesSync())!;
    enhanceImage();
  }

  enhanceImage() {
    img.Image temp = img.decodeImage(widget.image.readAsBytesSync())!;
    inputImage = img.adjustColor(temp, brightness: brightness);
    inputImage = img.contrast(inputImage, contrast: contrast);
    setState(() {
      inputImage;
    });
  }

  double contrast = 150;
  double brightness = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: whiteColor),
          actions: [
            InkWell(
              // onTap: () async {
              //   final result = await ImageGallerySaver.saveImage(
              //       Uint8List.fromList(img.encodePng(inputImage)));
              //   print(result);
              // },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.save_alt, color: whiteColor),
              ),
            ),
            InkWell(
              onTap: () async {
                final editedImage = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageFilters(
                      image: Uint8List.fromList(img.encodePng(inputImage)), // <-- Uint8List of image
                    ),
                  ),
                );
                inputImage = img.decodeImage(editedImage)!;
                setState(() {
                  inputImage;
                });
                enhanceImage();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.filter, color: whiteColor),
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: blueColor,
          title: Text('Améliorer', style: TextStyle(color: whiteColor)),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Image.memory(Uint8List.fromList(img.encodeBmp(inputImage))),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.contrast, color: blueColor),
                      Expanded(
                        child: Slider(
                          value: contrast,
                          onChanged: (v) {
                            contrast = v;
                            enhanceImage();
                            setState(() {
                              contrast;
                            });
                          },
                          min: 80,
                          max: 200,
                          divisions: 12,
                          label: contrast.toStringAsFixed(2),
                          activeColor: blueColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.brightness_1,
                        color: blueColor,
                      ),
                      Expanded(
                        child: Slider(
                            value: brightness,
                            onChanged: (v) {
                              brightness = v;
                              enhanceImage();
                              setState(() {
                                brightness;
                              });
                            },
                            min: 1,
                            max: 10,
                            divisions: 10,
                            label: brightness.toStringAsFixed(2),
                            activeColor: blueColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
