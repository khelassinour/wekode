import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiledev/Paasword/SuccessPage.dart';
import 'package:mobiledev/api/const.dart';
import 'package:mobiledev/api/const_api.dart';
import 'package:mobiledev/helper/cach.dart';
import 'package:mobiledev/Orders/order_page.dart';
import 'package:mobiledev/screens/auth/cubit/auth_cubit.dart';
import '../../signup_page.dart';
import '../../Paasword/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  // Adding the hand emoji next to "Hello"
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Hello ",
                          style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.waving_hand,
                            size: screenWidth * 0.07,
                            color: Colors.amber,
                          ),
                        ),
                        TextSpan(
                          text: "\nHappy to see you again!",
                          style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Email Field with Label
                  buildTextField(
                    label: "Email",
                    hint: "Example@gmail.com",
                    width: screenWidth,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      // Regular expression for email validation
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null; // No error if the email is valid
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Password Field with Label
                  buildPasswordField(
                    label: "Password",
                    hint: "Enter a password",
                    width: screenWidth,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Aligning "Forgot password?" to the right and navigating to PasswordPage
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => PasswordPage()),
                          );
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Login button

                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) async {
                      if (state is LoginStateGood) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login Successful"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        await CachHelper.putcache(
                            key: tokenCache,
                            value: state.model.data!.accessToken);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  HomePage()),
                            (route) => false);
                      } else if (state is LoginStateBad) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login Failed"),
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
                      if (state is LoginLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> data = {
                              "email": _emailController.text,
                              "password": _passwordController.text,
                              "device_name": "mobile"
                            };
                            AuthCubit.get(context)
                                .login(data: data, path: LOGINUSER);

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => HomePage()),
                            // );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6D57FC),
                          minimumSize:
                              Size(double.infinity, screenHeight * 0.065),
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

                  SizedBox(height: screenHeight * 0.03),

                  // Divider with "Or log in with" text
                  buildDividerWithText("Or log in with"),
                  SizedBox(height: screenHeight * 0.02),

                  // Social login buttons (Responsive)
                  buildSocialMediaIcons(),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),

            // "New to TPCMI? Sign up now" text with "Sign up now" as a button
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New to TPCMI?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()),
                      );
                    },
                    child: Text(
                      "Sign up now",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required double width,
    required TextEditingController controller,
    required String? Function(String?)? validator, // Add validator parameter
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
          validator: validator, // Set validator
        ),
      ],
    );
  }

  Widget buildPasswordField({
    required String label,
    required String hint,
    required double width,
    required TextEditingController controller,
    required String? Function(String?)? validator, // Add validator parameter
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
              validator: validator, // Set validator
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
