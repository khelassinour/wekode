import 'package:flutter/material.dart';
import 'passwordchanged.dart'; // Import the NewPasswordPage

class OTPVerificationPage extends StatefulWidget {
  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _nextField(String value, int index) {
    if (value.length == 1) {
      if (index < _focusNodes.length - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus(); // Close keyboard on the last field
      }
    }
  }

  void _verifyOTP() {
    String otpCode = _controllers.map((c) => c.text).join();
    print("Entered OTP: $otpCode");
    // Here you can add your OTP verification logic
    // If OTP is correct, navigate to the NewPasswordPage

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPasswordPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            Text(
              "OTP verification",
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Enter the validation code that we have just sent to your email address",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: screenWidth * 0.15,
                  height: screenWidth * 0.15,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    onChanged: (value) => _nextField(value, index),
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: screenHeight * 0.05),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: Text(
                "Verify",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6D57FC),
                minimumSize: Size(double.infinity, screenHeight * 0.065),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                // Add code to re-send OTP here
              },
              child: Text.rich(
                TextSpan(
                  text: "Didn’t get a code? ",
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: "Re-send now",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
