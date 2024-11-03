import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobiledev/Profil/identityverification_page.dart';
import 'package:mobiledev/Profil/phoneverification.dart';
import '../api/const.dart';
import '../helper/cach.dart';
import '../screens/auth/login_page.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _profileImage;

  static const String firstName = 'Nour';
  static const String lastName = 'K';
  static const String email = 'nour@gmail.com';
  static const String phone = '+312-549727920';

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double paddingSize = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(

                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(File(_profileImage!.path))
                          : AssetImage('assets/person.png') as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.edit,
                            color: Colors.grey,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: paddingSize),
              _buildProfileField(context, 'First Name', firstName),
              _buildProfileField(context, 'Last Name', lastName),
              _buildProfileField(context, 'Email', email),
              _buildProfileField(context, 'Phone', phone),
              Text(
                'Password',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: MediaQuery.of(context).size.width * 0.038,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {

                },
                child: Text('Change Password'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF6D57FC),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: paddingSize),
              Text(
                'Profile Verification',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: MediaQuery.of(context).size.width * 0.038,
                ),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildClickableTextField('Identity verification', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerificationScreen()),
                    );
                  }),
                  SizedBox(height: 20),
                  _buildClickableTextField('Phone number verification', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => phoneverification()),
                    );

                  }),
                ],
              ),
              SizedBox(height: paddingSize),
              ElevatedButton(
                onPressed: () {
                  CachHelper.removdata(key: tokenCache);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                          (route) => false);
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF6D57FC),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: MediaQuery.of(context).size.width * 0.038,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: TextEditingController(text: value),
          enabled: false,
          decoration: InputDecoration(
            hintText: '',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          ),
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }

  Widget _buildClickableTextField(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
