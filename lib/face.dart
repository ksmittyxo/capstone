import 'package:flutter/material.dart';

class Face {
  late int type;
  late String title;
  late String rawSVG;
  late int isFront;

  getType() {
    return type;
  }

  getTitle() {
    return title;
  }

  getSvg() {
    return rawSVG;
  }

  getIsFront() {
    return isFront;
  }

  Face(this.type, this.title, this.rawSVG, this.isFront);
}