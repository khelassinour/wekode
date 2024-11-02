import 'package:flutter/material.dart';
import 'OnboardingPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/plane.jpg'), // Add your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logo.png',
                  width:
                      screenWidth * 0.9, // Adjusts width based on screen size
                ),
                SizedBox(
                    height: screenHeight * 0.15), // Responsive vertical spacing
                // Text content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Worldwide delivery\nHassle free!',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: screenWidth * 0.07, // Responsive font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Experience seamless global shopping\nwith effortless delivery to your doorstep.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, // Responsive font size
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: screenHeight * 0.05), // Responsive vertical spacing
                // Get Started button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Onboarding()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF6D57FC), // Updated to #6D57FC
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.25,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Get started',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
