import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:verifyemail/welcome.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red, scaffoldBackgroundColor: Colors.white),
      home: Login(),
    ));

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _otpController = new TextEditingController();

  void sendOTP() async {
    EmailAuth.sessionName = "Test Session";
    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('OTP Sent'),
        duration: Duration(seconds: 3),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Can not send OTP'), duration: Duration(seconds: 3)));
    }
  }

  void verifyOTP() {
    var res = EmailAuth.validate(
        receiverMail: _emailController.text, userOTP: _otpController.text);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('OTP Verified'),
        duration: Duration(seconds: 1),
      ));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid OTP'), duration: Duration(seconds: 3)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Email Verification')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    suffixIcon: TextButton(
                      child: Text('Send OTP'),
                      onPressed: () {
                        sendOTP();
                      },
                    )),
              ),
              TextField(
                controller: _otpController,
                decoration: InputDecoration(labelText: "OTP"),
              ),
              GestureDetector(
                onTap: () {
                  verifyOTP();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 25),
                  width: 90,
                  height: 40,
                  color: Colors.redAccent,
                  child: Center(
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
