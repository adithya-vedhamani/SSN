import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_code/Screens/qr_screen_result.dart';
import 'package:qr_code/user_role.dart';
import '../globals.dart';
import 'package:qr_code/Screens/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRScannerPage extends StatefulWidget {
  final String username;
  final String role;

  QRScannerPage({required this.username, required this.role, Key? key})
      : super(key: key) {
    Globals.username = username;
  } // Set the global username value

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool isScanComplete = false;

  void closeScanner() {
    setState(() {
      isScanComplete = false;
    });
  }

  void scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (barcode != '-1') {
        setState(() {
          isScanComplete = true;
          UserRole userRole = _getUserRole(widget.role);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QrResultPage(
                closeScreen: closeScanner,
                qrResult: barcode,
                userRole: userRole,
              ),
            ),
          );
        });
      }
    } on PlatformException {
      // Handle platform exception if any
    }
  }

  UserRole _getUserRole(String role) {
    switch (role) {
      case 'Verifier':
        return UserRole.Verifier;
      case 'Proctor':
        return UserRole.Proctor;
      case 'Interviewer':
        return UserRole.Interviewer;
      default:
        return UserRole.General; // Default role in case of unknown or unsupported roles
    }
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Globals.username = '';

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => IntroPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Scanner',
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: _logout,
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Username: ${widget.username}',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Role: ${widget.role}',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Press the button to scan QR',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: scanBarcode,
                child: Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 100,
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF1B61A9),
                  padding: const EdgeInsets.all(14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}