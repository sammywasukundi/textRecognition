import 'package:flutter/material.dart';

class EntityDM {
  String name;
  String value;
  IconData? iconData;

  EntityDM(this.name, this.value) {
    if(name == "phone"){
      iconData = Icons.phone;
    }else if(name == "address"){
      iconData = Icons.location_on;
    }else if(name == "email"){
      iconData = Icons.mail;
    }else if(name == "url"){
      iconData = Icons.web;
    }else{
      iconData = Icons.ac_unit_outlined;
    }
  }
}