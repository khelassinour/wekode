import 'package:flutter/material.dart';
import 'package:mobiledev/Paasword/SuccessPage.dart';

class NewPasswordPage extends StatefulWidget {
  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  // State variables
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLengthValid = false;
  bool _hasUpperCaseAndNumber = false;

  // Validate password based on criteria
  void _validatePassword(String password) {
    setState(() {
      _isLengthValid = password.length >= 8 && password.length <= 16;
      _hasUpperCaseAndNumber = password.contains(RegExp(r'[A-Z]')) &&
          password.contains(RegExp(r'[0-9]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create a New Password",
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            _buildPasswordField(
              controller: _passwordController,
              label: "New Password",
              onChanged: _validatePassword,
              isObscured: !_showPassword,
              toggleVisibility: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildPasswordField(
              controller: _confirmPasswordController,
              label: "Confirm Password",
              isObscured: !_showConfirmPassword,
              toggleVisibility: () {
                setState(() {
                  _showConfirmPassword = !_showConfirmPassword;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildPasswordCriteria(screenWidth),
            SizedBox(height: screenHeight * 0.05),
            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    bool isObscured = true,
    Function()? toggleVisibility,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        TextField(
          controller: controller,
          obscureText: isObscured,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: "Enter your password",
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            suffixIcon: GestureDetector(
              onTap: toggleVisibility,
              child: Text(
                isObscured ? "Show" : "Hide",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordCriteria(double screenWidth) {
    return Column(
      children: [
        _buildCriteriaRow(
          _isLengthValid,
          "8 - 16 characters minimum",
          screenWidth,
        ),
        SizedBox(height: 8),
        _buildCriteriaRow(
          _hasUpperCaseAndNumber,
          "Must contain upper case and number",
          screenWidth,
        ),
      ],
    );
  }

  Widget _buildCriteriaRow(bool isValid, String text, double screenWidth) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: screenWidth * 0.05,
        ),
        SizedBox(width: screenWidth * 0.02),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontSize: screenWidth * 0.04,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_passwordController.text == _confirmPasswordController.text &&
            _isLengthValid &&
            _hasUpperCaseAndNumber) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SuccessPage()),
          );
        } else {
          print("Passwords do not match or do not meet criteria.");
        }
      },
      child: Text(
        "Save Password",
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6D57FC),
        minimumSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.065),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
