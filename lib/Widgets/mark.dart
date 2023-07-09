import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/button.dart';

class MarkAttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mark Attendance'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Attendance Marked!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            MyButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Back',
              icon: Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
    );
  }
}
