import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CardtopWidget extends StatefulWidget {
  const CardtopWidget({super.key});

  @override
  State<CardtopWidget> createState() => _CardtopWidgetState();
}

class _CardtopWidgetState extends State<CardtopWidget> {

  bool scan = false;
  bool recognize = false;
  bool enhance = false;

  @override
  Widget build(BuildContext context) {
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
                        color: scan?blackColor:whiteColor,
                      ),
                      Text(
                        'Scanner',
                        style: TextStyle(
                            color: scan?blackColor:whiteColor,
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
                        color: recognize?blackColor:whiteColor,
                      ),
                      Text(
                        'Reconnaitre',
                        style: TextStyle(
                            color: recognize?blackColor:whiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  scan = false ;
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
                        color: enhance?blackColor:whiteColor,
                      ),
                      Text(
                        'Agrandir',
                        style: TextStyle(
                            color: enhance?blackColor:whiteColor,
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
}
