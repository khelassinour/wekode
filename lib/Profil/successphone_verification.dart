import 'package:flutter/material.dart';
import 'package:mobiledev/Profil/profil_page.dart';
import 'package:mobiledev/screens/auth/login_page.dart';

class Successverification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: screenWidth * 0.25,
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                "Phone number verified!",
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Your phone number has been changed successfully verified.",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.05),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Text(
                  "Back to Profil",
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
            ],
          ),
        ),
      ),
    );
  }
}
