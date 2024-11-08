import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mobiledev/Profil/identityverification_page.dart';
import 'package:mobiledev/Profil/profil_page.dart';

import '../Orders/order_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TakeIDPage(),
    );
  }
}

class TakeIDPage extends StatefulWidget {
  @override
  _TakeIDPageState createState() => _TakeIDPageState();
}

class _TakeIDPageState extends State<TakeIDPage> {
  CameraController? _cameraController;
  late Future<void> _initializeControllerFuture;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(camera, ResolutionPreset.high);
    _initializeControllerFuture = _cameraController!.initialize();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _cameraController!.takePicture();

      setState(() {
        imagePath = image.path;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => IdSubmittedPage(imagePath: image.path),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.35,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                border: Border.all(color: Colors.white, width: 1.0),
              ),
              child: _cameraController != null
                  ? FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_cameraController!);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "Front of your ID card",
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            "Center your ID and check for good lighting\nand no glares, then tap the shutter",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.white70,
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.06),
            child: GestureDetector(
              onTap: _takePicture,
              child: Container(
                width: screenWidth * 0.25,
                height: screenWidth * 0.25,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IdSubmittedPage extends StatelessWidget {
  final String? imagePath;

  IdSubmittedPage({this.imagePath});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: imagePath != null
                  ? Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
              )
                  : Center(
                child: Icon(
                  Icons.insert_photo,
                  size: screenWidth * 0.2,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
          Text(
            "Is the photo of your ID clear?",
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            "Make sure it’s well-lit, clear and nothing is cut-off",
            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.035),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.09),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IdentityVerificationPage(),
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6D57FC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              minimumSize: Size(double.infinity, screenHeight * 0.07),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.09),
              child: Text(
                "Submit the photo",
                style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Retake",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}


class IdentityVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.3),
          Icon(
            Icons.face,
            size: screenWidth * 0.2,
            color: Colors.white,
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            'Next take a photo of yourself',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'We\'ll check that it matches the photo on ID',
            style: TextStyle(
              color: Colors.white70,
              fontSize: screenWidth * 0.035,
            ),
          ),
          SizedBox(height: screenHeight * 0.01)
          ,Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6D57FC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
                minimumSize: Size(double.infinity, screenHeight * 0.07),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SelfiePage(),
                ));
              },
              child: Text(
                'Continue',
                style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelfiePage extends StatefulWidget {
  @override
  _SelfiePageState createState() => _SelfiePageState();
}

class _SelfiePageState extends State<SelfiePage> {
  CameraController? _cameraController;
  late Future<void> _initializeControllerFuture;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();

    final frontCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(frontCamera, ResolutionPreset.high);
    _initializeControllerFuture = _cameraController!.initialize();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _takeSelfie() async {
    try {
      await _initializeControllerFuture;
      final image = await _cameraController!.takePicture();

      setState(() {
        imagePath = image.path;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelfieSubmittedPage(imagePath: image.path),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.03),
          Center(
            child: Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.9),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: _cameraController != null
                  ? FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_cameraController!);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            'Device tilted, hold it straight',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.04,
            ),
          ),
          SizedBox(height: screenHeight * 0.2),
          GestureDetector(
            onTap: _takeSelfie,
            child: Container(
              width: screenWidth * 0.25,
              height: screenWidth * 0.25,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelfieSubmittedPage extends StatelessWidget {
  final String? imagePath;

  SelfieSubmittedPage({this.imagePath});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.9),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: imagePath != null
                  ? Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
              )
                  : Center(
                child: Icon(
                  Icons.insert_photo,
                  size: screenWidth * 0.2,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            'Is your photo clear?',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.04,
            ),
          ),
          SizedBox(height: screenHeight * 0.09),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6D57FC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              minimumSize: Size(double.infinity, screenHeight * 0.07),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.09),
              child: Text(
                "Submit the photo",
                style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Retake",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}




class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.all(screenWidth * 0.02),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ProfilePage()),
              );
            },
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.05),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.access_time,
                  size: screenWidth * 0.3,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Thanks, we’re reviewing your submitted infos",
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Our team are carrying out checks on your infos,\n"
                  "We’ll send you a notification once it’s over.\n\n"
                  "In the meantime, you can pick-up where you left off.",
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.black54,
              ),
              textAlign: TextAlign.start,
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7B61FF),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));

                },
                child: Text(
                  "Got it",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.white,
                  ),
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


