import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiledev/api/const.dart';
import 'package:mobiledev/helper/cach.dart';
import 'package:mobiledev/Orders/order_page.dart';
import 'package:mobiledev/screens/auth/cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Future<void> _saveUserInfo(String firstName, String lastName, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Text(
                "Sign up",
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),


              Row(
                children: [
                  Expanded(
                    child: buildTextField(
                      label: "First name",
                      hint: "First name",
                      controller: _firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: buildTextField(
                      label: "Last name",
                      hint: "Last name",
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),


              buildTextField(
                label: "Email",
                hint: "Example@gmail.com",
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  final emailRegex =
                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.02),

              // Password Field
              buildPasswordField(
                label: "Password",
                hint: "Enter a password",
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.05),

              // Terms and Privacy
              buildTermsAndPrivacy(),
              SizedBox(height: screenHeight * 0.05),

              // Sign Up Button with BlocConsumer
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state is RegisterStateGood) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Register Successful"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    await _saveUserInfo(
                      _firstNameController.text,
                      _lastNameController.text,
                      _emailController.text,
                    );
                    await CachHelper.putcache(
                      key: tokenCache,
                      value: state.model.data!.accessToken,
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false,
                    );
                  } else if (state is RegisterStateBad) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Sign up Failed"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state is ErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorModel.error?.description ?? "Error",
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLodinState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "first_name": _firstNameController.text,
                          "last_name": _lastNameController.text,
                          "email": _emailController.text,
                          "password": _passwordController.text,
                          'password_confirmation': _passwordController.text,
                        };
                        AuthCubit.get(context).registerUser(data: data);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D57FC),
                      minimumSize: Size(double.infinity, screenHeight * 0.065),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: screenHeight * 0.1),


              buildShipperPrompt(),
              SizedBox(height: screenHeight * 0.02),


              buildDividerWithText("Or sign up with"),
              SizedBox(height: screenHeight * 0.02),


              buildSocialMediaIcons(),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              controller: controller,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: validator,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Text(
                _isPasswordVisible ? "Hide" : "Show",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTermsAndPrivacy() {
    return RichText(
      text: const TextSpan(
        text: "By creating an account, I agree to the ",
        style: TextStyle(fontSize: 12, color: Colors.black),
        children: [
          TextSpan(
            text: "Terms of Service",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: " and "),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildShipperPrompt() {
    return Center(
      child: RichText(
        text: const TextSpan(
          text: "Already have an account? ",
          style: TextStyle(fontSize: 12, color: Colors.black),
          children: [
            TextSpan(
              text: "Sign In",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF6D57FC),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.grey)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(text),
        ),
        const Expanded(child: Divider(color: Colors.grey)),
      ],
    );
  }

  Widget buildSocialMediaIcons() {
    double iconWidth = MediaQuery.of(context).size.width * 0.20;
    double iconHeight = MediaQuery.of(context).size.height * 0.05;
    double iconSpacing = MediaQuery.of(context).size.width * 0.05;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSocialMediaIcon(
              FontAwesomeIcons.facebook, Colors.blue, iconWidth, iconHeight),
          SizedBox(width: iconSpacing),
          buildSocialMediaIcon(
              FontAwesomeIcons.google, Colors.red, iconWidth, iconHeight),
          SizedBox(width: iconSpacing),
          buildSocialMediaIcon(
              FontAwesomeIcons.apple, Colors.black, iconWidth, iconHeight),
        ],
      ),
    );
  }

  Widget buildSocialMediaIcon(
      IconData icon, Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: FaIcon(icon, color: color, size: width * 0.3),
        onPressed: () {},
      ),
    );
  }
}
