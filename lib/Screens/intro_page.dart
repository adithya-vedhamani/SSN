import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code/Screens/qr_scanner.dart';
import '../user_role.dart';
import '../auth_api.dart';
import 'package:qr_code/Widgets/bu.dart';
import '../globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkPersistentLogin();
    // Lock rotation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Re-enable rotation when the page is disposed
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  void checkPersistentLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? role = prefs.getString('role');

    if (username != null && role != null) {
      Globals.username = username;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QRScannerPage(username: username, role: role),
        ),
      );
    }
  }

  void _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      String? role = await AuthApi.login(username, password);

      if (role != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);
        await prefs.setString('role', role);

        Globals.username = username;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QRScannerPage(username: username, role: role),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid Login'),
            content: Text('Please enter valid credentials.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ad.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 60),
              Image.asset(
                'assets/ssnlogo.png',
                height: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(1.0),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Color(0xFF1B61A9),
                              width: 2.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(12.0),
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Color(0xFF1B61A9),
                              ),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(12.0),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    MyBu(
                      text: "Login",
                      onPressed: _login,
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 55.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
