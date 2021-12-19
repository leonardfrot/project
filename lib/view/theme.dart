// cette page est fait pour retourner tous les thèmes réutilisables du projet.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes{
  static final light = ThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.light
      );

      
       static final dark  = ThemeData(
        primaryColor: Colors.red,
        brightness: Brightness.dark

      );
}

TextStyle get subHeadingStyle{

  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 18,

     )
  );


}

TextStyle get HeadingStyle{

  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
     )
  );


}
