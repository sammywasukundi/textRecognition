import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_recognition/views/cardscanner_view.dart';
import 'package:text_recognition/views/theme/app_colors.dart';

import 'recognize_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ImagePicker imagePicker;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    initializeCamera();
  }

  late CameraController controller;
  bool isInit = false;
  initializeCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        isInit = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  bool scan = false;
  bool recognize = true;
  bool enhance = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      padding: EdgeInsets.only(top: 30, left: 3, right: 3, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
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
                    onTap: () {
                      setState(() {
                        scan = true;
                        recognize = false;
                        enhance = false;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Icon(
                              size: 25,
                              Icons.scanner,
                              color: scan ? blackColor : whiteColor,
                            ),
                            Text(
                              'Scanner',
                              style: TextStyle(
                                  color: scan ? blackColor : whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        scan = false;
                        recognize = true;
                        enhance = false;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Icon(
                              size: 25,
                              Icons.document_scanner,
                              color: recognize ? blackColor : whiteColor,
                            ),
                            Text(
                              'Reconnaitre',
                              style: TextStyle(
                                  color: recognize ? blackColor : whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        scan = false;
                        recognize = false;
                        enhance = true;
                      });
                    },
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Icon(
                              size: 25,
                              Icons.assignment_sharp,
                              color: enhance ? blackColor : whiteColor,
                            ),
                            Text(
                              'Agrandir',
                              style: TextStyle(
                                  color: enhance ? blackColor : whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: greyColor,
            // child: Stack(
            //   children: [
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height - 260,
                child: isInit
                    ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: CameraPreview(controller))
                    : Container(),
              ),
            ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height - 260,
                //   margin: EdgeInsets.all(2),
                //   child: Image.asset(
                //     'assets/frame.png',
                //     //fit: BoxFit.fill,
                //   ),
                // )
            //   ],
            // ),
          ),
          Card(
            color: blueColor,
            child: SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.rotate_left,
                      size: 35,
                      color: whiteColor,
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Icon(
                      Icons.camera,
                      size: 50,
                      color: whiteColor,
                    ),
                    onTap: () async {
                      await controller.takePicture().then((value) {
                        // ignore: unnecessary_null_comparison
                        if (value != null) {
                          File image = File(value.path);
                          processImage(image);
                        }
                      });
                    },
                  ),
                  InkWell(
                    child: Icon(
                      Icons.image_outlined,
                      size: 35,
                      color: whiteColor,
                    ),
                    onTap: () async {
                      final ImagePicker imagePicker = ImagePicker();
                      XFile? xfile = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (xfile != null) {
                        File image = File(xfile.path);
                        processImage(image);
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  processImage(File image) async {
    final editedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageCropper(
          image: image.readAsBytesSync(), // <-- Uint8List of image
        ),
      ),
    );
    if (editedImage != null && editedImage is List<int>) {
      await image.writeAsBytes(editedImage);
      if (recognize) {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return RecognizeView(image);
        }));
      } else if (scan) {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return CardscannerView(image);
        }));
      }
    }
  }
}
