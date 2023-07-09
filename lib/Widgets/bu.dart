import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBu extends StatelessWidget {
  const MyBu({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  final String text;
  final Function()? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 120,
      height: 50,
      padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
      child: MaterialButton(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: const BorderSide( color: Color(0xFF1B61A9), width: 2),
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
