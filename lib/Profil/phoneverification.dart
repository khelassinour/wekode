import 'package:flutter/material.dart';
import 'package:mobiledev/Profil/OTPverification_phone.dart';
import '../Paasword/OTPVerificationPage.dart'; // Import the OTP Verification page

class phoneverification extends StatefulWidget {
  @override
  _phoneverificationState createState() => _phoneverificationState();
}

class _phoneverificationState extends State<phoneverification> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please verify your phone number",
              style: TextStyle(
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "we will send youa One-time password, please enter your mobile phone number.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            TextField(
              decoration: InputDecoration(
                hintText: "Phone number",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OTPVerificationphone()),
                ); // Navigate to OTP Verification Page
              },
              child: Text(
                "Send a code",
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

          ],
        ),
      ),
    );
  }
}

