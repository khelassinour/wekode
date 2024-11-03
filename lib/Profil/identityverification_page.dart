import 'package:flutter/material.dart';
import 'package:mobiledev/Profil/take_pictures.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerificationScreen(),
    );
  }
}

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.all(screenWidth * 0.02),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.04),
            Icon(
              Icons.lock_open,
              size: screenWidth * 0.3,
              color: Colors.deepPurpleAccent,
            ),
            SizedBox(height: screenHeight * 0.04),
            Text(
              "Verifying your identity",
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "This helps us check that you’re really you.\nID check is one of the ways we keep TPMCI secure",
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.grey,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: screenHeight * 0.04),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Row(
                children: [
                  Icon(Icons.perm_identity, size: screenWidth * 0.08, color: Colors.black54),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Take a picture of a valid ID",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          "Please submit a valid driver’s licence or\nnational ID document to process your application.",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Row(
                children: [
                  Icon(Icons.camera_alt, size: screenWidth * 0.08, color: Colors.black54),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Take a selfie of yourself",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          "This will help us match your face with your submitted document.",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              children: [
                Icon(Icons.lock, color: Colors.grey, size: screenWidth * 0.04),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  "Your info’s will be encrypted and stored securely",
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showPreparationSheet(context, screenWidth, screenHeight);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                ),
                child: Text(
                  "Get started",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }

  void _showPreparationSheet(BuildContext context, double screenWidth, double screenHeight) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(screenWidth * 0.05)),
      ),
      builder: (context) {

        return Padding(

          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    "Prepare for the picture",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildPreparationStep(
                "1  Start with good lighting",
                "Take the photo in a well-lit space. Flash light may cause a glare on your ID.",
                screenWidth,
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildPreparationStep(
                "2  Find a flat surface",
                "Place your ID on a flat, solid-colored surface that contrasts with your passport.",
                screenWidth,
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildPreparationStep(
                "3  The photo will be taken automatically",
                "Once your document ID is in the frame, take a photo.",
                screenWidth,
              ),
              SizedBox(height: screenHeight * 0.04),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TakeIDPage()),
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6D57FC),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.3,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                  ),
                  child: Text(
                    "Got it",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        );
      },
    );
  }


  Widget _buildPreparationStep(String title, String description, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        Text(
          description,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
