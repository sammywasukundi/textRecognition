// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../models/class_entity.dart';
import 'theme/app_colors.dart';

class CardscannerView extends StatefulWidget {
  late File image;
  CardscannerView(this.image, {super.key});

  @override
  State<CardscannerView> createState() => _CardscannerViewState();
}

class _CardscannerViewState extends State<CardscannerView> {
  late TextRecognizer textRecognizer;
  late EntityExtractor entityExtractor;
  List<EntityDM> entitiesList = [];
  @override
  void initState() {
    super.initState();
    textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    entityExtractor =
        EntityExtractor(language: EntityExtractorLanguage.english);
    doTextRecognizer();
  }

  String results = "";
  void doTextRecognizer() async {
    InputImage inputImage = InputImage.fromFile(widget.image);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    entitiesList.clear();
    results = recognizedText.text;

    final List<EntityAnnotation> annotations =
        await entityExtractor.annotateText(results);

    results = '';
    for (final annotation in annotations) {
      annotation.start;
      annotation.end;
      annotation.text;
      for (final entity in annotation.entities) {
        results += '${entity.type.name}\n${annotation.text}\n\n';
        entitiesList.add(EntityDM(entity.type.name, annotation.text));
      }
    }
    //print(results);
    setState(() {
      results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: whiteColor),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.change_circle_rounded,
                color: whiteColor,
              ),
            )
          ],
          centerTitle: true,
          backgroundColor: blueColor,
          title: Text('Scanner', style: TextStyle(color: whiteColor)),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Image.file(widget.image),
                ListView.builder(
                  itemBuilder: (context, position) {
                    return Card(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      color: blueColor,
                      child: Container(
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                entitiesList[position].iconData,
                                size: 25,
                                color: whiteColor,
                              ),
                              Expanded(
                                child: Text(
                                  entitiesList[position].value,
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text: entitiesList[position].value));
                                  SnackBar sn =
                                      SnackBar(content: Text("Copié dans le presse-papiers"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(sn);
                                },
                                child: Icon(
                                  Icons.copy,
                                  color: whiteColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: entitiesList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                )
                // Card(
                //     margin: EdgeInsets.all(8),
                //     color: whiteColor,
                //     child: Column(
                //       children: [
                //         Container(
                //           decoration: BoxDecoration(
                //               color: blueColor,
                //               borderRadius: BorderRadius.circular(2)),
                //           padding: EdgeInsets.all(8),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Icon(
                //                 Icons.document_scanner,
                //                 color: whiteColor,
                //               ),
                //               Text(
                //                 'Résultats du scannage',
                //                 style: TextStyle(color: whiteColor),
                //               ),
                //               InkWell(
                //                 onTap: () {
                //                   Clipboard.setData(
                //                       ClipboardData(text: results));
                //                   ScaffoldMessenger.of(context)
                //                       .showSnackBar(SnackBar(
                //                     content:
                //                         Text('Copié dans le presse-papiers'),
                //                   ));
                //                 },
                //                 child: Icon(
                //                   Icons.copy,
                //                   color: whiteColor,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Text(
                //           results,
                //           style: TextStyle(fontSize: 16),
                //         ),
                //       ],
                //     ))
              ],
            ),
          ),
        ));
  }
}
