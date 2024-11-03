import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'screens/auth/login_page.dart';

class ContentModel {
  final String image;
  final String title;
  final String description;

  ContentModel(
      {required this.image, required this.title, required this.description});
}

List<ContentModel> contents = [
  ContentModel(
    image: 'assets/onBoardingImage01.png',
    title: "What's TPMCI?",
    description:
    "TCPMI is an app that connects travelers with shoppers to deliver internationally. It allows travelers to make money by delivering items, while shoppers can get items from abroad without high shipping costs.",
  ),
  ContentModel(
    image: 'assets/onBoardingImage02.png',
    title: "Top-notch service",
    description:
    "Short on time for shopping or tracking shipments? Let TPCMI take care of it. Just tell us what you need, and we'll handle the rest for you.",
  ),
  ContentModel(
    image: 'assets/onBoardingImage03.png',
    title: "Seamless shopping",
    description:
    "Browse products from around the world and request delivery. Our travelers will shop for you and bring your items to your doorstep for hassle-free shopping.",
  ),
  ContentModel(
    image: 'assets/onBoardingImage04.png',
    title: "Travel more & Earn more",
    description:
    "Traveling soon? Join TPCMI as a traveler and earn rewards while you help others. Make your trips more rewarding by delivering items to shoppers along your route. It's a win-win!",
  ),
];

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showCustomPopup(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      builder: (BuildContext context) {
        return Container(

          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(

            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "How would you describe \nyourself?",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6D57FC),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "I'm new to the app",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.042,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  minimumSize: Size(double.infinity, 50),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.042,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = screenSize.width * 0.05;
    final titleFontSize = screenSize.width * 0.07;
    final descriptionFontSize = screenSize.width * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return SingleChildScrollView(  // Scrollable widget
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: screenSize.height * 0.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                                (index) => buildDot(index, context),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.05),
                        Text(
                          contents[i].title,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          contents[i].description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: descriptionFontSize,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: screenSize.height * 0.06,
            margin: EdgeInsets.only(
              left: padding,
              right: padding,
              bottom: 15,
            ),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6D57FC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                currentIndex == contents.length - 1 ? "Continue" : "Next",
                style: TextStyle(fontSize: screenSize.width * 0.045, color: Colors.white),
              ),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  showCustomPopup(context);
                } else {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: padding,
              right: padding,
              bottom: 20,
            ),
            child: TextButton(
              onPressed: () {
                showCustomPopup(context);
              },
              child: Text(
                "Skip",
                style: TextStyle(color: Colors.grey, fontSize: screenSize.width * 0.04),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 6,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Color(0xFF6D57FC) : Colors.grey,
      ),
    );
  }
}
