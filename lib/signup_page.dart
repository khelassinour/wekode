import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiledev/api/const.dart';
import 'package:mobiledev/helper/cach.dart';
import 'package:mobiledev/Orders/order_page.dart';
import 'package:mobiledev/screens/auth/cubit/auth_cubit.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

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
                        width: screenWidth,
                        controller: _firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        }),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: buildTextField(
                        label: "Last name",
                        hint: "Last name",
                        width: screenWidth,
                        controller: _lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        }),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),


              buildTextField(
                label: "Email",
                hint: "Example@gmail.com",
                width: screenWidth,
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


              buildPasswordField(
                label: "Password",
                hint: "Enter a password",
                width: screenWidth,
                controller: _passwordController,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter a password';
                  }

                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.05),


              buildTermsAndPrivacy(),
              SizedBox(height: screenHeight * 0.05),

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state is RegisterStateGood) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Register Successful"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    await CachHelper.putcache(
                        key: tokenCache, value: state.model.data!.accessToken);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  HomePage()),
                        (route) => false);
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
                            state.errorModel.error?.description ?? "Error"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLodinState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
                        print(data);
                        AuthCubit.get(context).registerUser(data: data);

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => HomePage()),
                        // );
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
                      "Log in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: screenHeight * 0.1),

              // Shipper account prompt
              buildShipperPrompt(),
              SizedBox(height: screenHeight * 0.02),

              // Divider with "Or sign up with" text
              buildDividerWithText("Or sign up with"),
              SizedBox(height: screenHeight * 0.02),

              // Social media icons
              buildSocialMediaIcons(screenWidth, screenHeight),
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
    required double width,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: width * 0.035, color: Colors.grey[700]),
        ),
        SizedBox(height: width * 0.02),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
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
    required double width,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: width * 0.035, color: Colors.grey[700]),
        ),
        SizedBox(height: width * 0.02),
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 30,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    _isPasswordVisible ? "Hide" : "Show",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
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
        text: TextSpan(
          text: "Want to become a shipper? ",
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          children: const [
            TextSpan(
              text: "Sign up for a professional shipper account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
          child: Text(text,
              style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ),
        const Expanded(child: Divider(color: Colors.grey)),
      ],
    );
  }

  Widget buildSocialMediaIcons(double screenWidth, double screenHeight) {
    double iconWidth = screenWidth * 0.20;
    double iconHeight = screenHeight * 0.05;
    double iconSpacing = screenWidth * 0.05;

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
