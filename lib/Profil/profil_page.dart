import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobiledev/Profil/identityverification_page.dart';
import 'package:mobiledev/Profil/phoneverification.dart';
import '../api/const.dart';
import '../helper/cach.dart';
import '../screens/auth/login_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _profileImage;

  String? _firstName;
  String? _lastName;
  String? _email;


  static const String firstName = 'Nour';
  static const String lastName = 'K';
  static const String email = 'nour@gmail.com';
  static const String phone = '+312-549727920';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = prefs.getString('firstName');
      _lastName = prefs.getString('lastName');
      _email = prefs.getString('email');
    });
  }





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
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileImage(),
            SizedBox(height: paddingSize),
            _buildProfileField(context, 'First Name', _firstName ?? 'N/A'),
            _buildProfileField(context, 'Last Name', _lastName ?? 'N/A'),
            _buildProfileField(context, 'Email', _email ?? 'N/A'),
            _buildProfileField(context, 'Phone', phone),
            _buildChangePasswordButton(context),
            SizedBox(height: paddingSize),
            _buildProfileVerificationSection(context),
            SizedBox(height: paddingSize),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _profileImage != null
                ? FileImage(File(_profileImage!.path))
                : const AssetImage('assets/person.png') as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.edit,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
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
        const SizedBox(height: 10),
        TextField(
          controller: TextEditingController(text: value),
          enabled: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: MediaQuery.of(context).size.width * 0.038,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {

          },
          child: const Text('Change Password'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF6D57FC),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileVerificationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Verification',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: MediaQuery.of(context).size.width * 0.038,
          ),
        ),
        const SizedBox(height: 10),
        _buildClickableTextField('Identity Verification', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerificationScreen()),
          );
        }),
        const SizedBox(height: 20),
        _buildClickableTextField('Phone Number Verification', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => phoneverification()),
          );
        }),
      ],
    );
  }

  Widget _buildClickableTextField(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        CachHelper.removdata(key: tokenCache);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
        );
      },
      child: const Text('Logout'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF6D57FC),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
