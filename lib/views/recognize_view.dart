// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, unused_local_variable

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'theme/app_colors.dart';

class RecognizeView extends StatefulWidget {
  final File image;
  const RecognizeView({required this.image, super.key});

  @override
  State<RecognizeView> createState() => _RecognizeViewState();
}

class _RecognizeViewState extends State<RecognizeView> {
  late TextRecognizer textRecognizer;
  @override
  void initState() {
    super.initState();
    textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    doTextRecognizer();
  }

  String results = "";
  void doTextRecognizer() async {
    InputImage inputImage = InputImage.fromFile(widget.image);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    results = recognizedText.text;
    print(results);
    setState(() {
      results;
    });
    for (TextBlock block in recognizedText.blocks) {
      final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: blueColor,
          title: Text('Reconnaissance', style: TextStyle(color: blackColor)),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Image.file(widget.image),
                Card(
                  margin: EdgeInsets.all(8),
                  color: whiteColor,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(2)
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.document_scanner, color: whiteColor,),
                            Text('Résultats de la reconnaissance',style: TextStyle(color: whiteColor),),
                            Icon(Icons.copy, color: whiteColor,),
                          ],
                        ),
                      ),
                      Text(results,style: TextStyle(fontSize: 16),),
                    ],
                  )
                )
              ],
            ),
          ),
        ));
  }
}
