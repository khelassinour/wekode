import 'package:flutter/material.dart';
import 'newproduct_page.dart';
import 'package:intl/intl.dart';
import 'package:mobiledev/Profil/profil_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Home')),
    OrderPage(),
    Center(child: Text('Trips')),
    Center(child: Text('Inbox')),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    print("Tapped index: $index");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child:BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/home_icon.ico'),
                size: 24,
                color: _selectedIndex == 0 ? Color(0xFF6D57FC) : Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/home_icon.ico'),
                size: 24,
                color: _selectedIndex == 1 ? Color(0xFF6D57FC) : Colors.grey,
              ),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/plane_icon.ico'),
                size: 24,
                color: _selectedIndex == 2 ? Color(0xFF6D57FC) : Colors.grey,
              ),
              label: 'Trips',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/inboxico.ico'),
                size: 24,
                color: _selectedIndex == 3 ? Color(0xFF6D57FC) : Colors.grey,
              ),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/person_icon.ico'),
                size: 24,
                color: _selectedIndex == 4 ? Color(0xFF6D57FC) : Colors.grey,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF6D57FC),
          unselectedItemColor: Colors.grey[600],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),

    );
  }
}

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController _dateController = TextEditingController();
  String? _selectedProduct;
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();


  @override
  Widget build(BuildContext context) {
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


          margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
            },
          ),
        ),

        title: Text(
          'New order',
          style: TextStyle(color: Colors.black , ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle('Transport details'),
            sectionSubtitle('Please specify the city of departure and arrival'),
            transportDetails(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            sectionTitle('Order details'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            sectionSubtitle('Order name'),
            orderDetails(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Divider(color: Colors.grey[300], ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            sectionTitle('Order cost'),
            orderCost(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            createOrderButton(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold),
    );
  }

  Widget sectionSubtitle(String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),

      child: Text(subtitle  ,style: TextStyle(color: Colors.grey), ),
    );
  }

  Widget transportDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  transportRow(context, 'From', 'Select country or city', Icons.flight_takeoff, _fromController),
                  Divider(),
                  transportRow(context, 'To', 'Select country or city', Icons.flight_land, _toController),
                ],
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.02,
              top: MediaQuery.of(context).size.height * 0.06,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 3,
                onPressed: () {
                  String temp = _fromController.text;
                  setState(() {
                    _fromController.text = _toController.text;
                    _toController.text = temp;
                  });
                },
                mini: true,
                child: Icon(Icons.swap_vert, color: Color(0xFF6D57FC)),
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        datePicker(context, 'When would you like to receive your order?'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Divider(color: Colors.grey[200]), // Divider added here
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    );
  }




  Widget transportRow(BuildContext context, String label, String placeholder, IconData icon, TextEditingController controller) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }


  Widget datePicker(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,  style: TextStyle(color: Colors.grey)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        GestureDetector(
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (selectedDate != null) {
              setState(() {
                _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
              });
            }
          },
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Expanded(
                  child: Text(
                    _dateController.text.isNotEmpty ? _dateController.text : 'Pick a date',
                    style: TextStyle(color: _dateController.text.isNotEmpty ? Colors.black : Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget orderDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Ex: Hair dryer for home use',
            hintStyle: TextStyle(color: Colors.grey , fontSize: 15 ),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(
          'Product',
          style: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width * 0.038,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            height: 25,
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedProduct,

              hint: Text('Select your product' ,style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width * 0.04,)
              ),
              items: ['Product 1', 'Product 2']
                  .map((product) => DropdownMenuItem<String>(
                value: product,
                child: Text(product),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProduct = value;
                });
              },
              underline: SizedBox(),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
                endIndent: 10,
              ),
            ),
            Center(
              child: Text(
                'OR',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
                indent: 10,
              ),
            ),
          ],
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewProductPage()),
            );
          },
          child: Text('Add a new product', style: TextStyle( color: Colors.black), ),
          style: ElevatedButton.styleFrom(

            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            minimumSize: Size(double.infinity, 48),
            elevation: 0,
            side: BorderSide(color: Colors.grey, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text('Have a note for the shipper?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width * 0.038,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        TextField(
          decoration: InputDecoration(
            hintText: 'Ex: Please handle my order with extra care',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          ),
          maxLines: 4,
          minLines: 1,
        ),

      ],
    );
  }

  Widget orderCost() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        costRow('Products count', '1'),
        costRow('Total weight', '190 g'),
        costRow('Shipper fees', '11.99\$'),
        costRow('Our fees', '4.99\$'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Divider(color: Colors.grey[300], ),

        costRow('Total to pay', '16.98\$', isTotal: true),
      ],
    );
  }

  Widget costRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? MediaQuery.of(context).size.width * 0.04 : MediaQuery.of(context).size.width * 0.035,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? MediaQuery.of(context).size.width * 0.04 : MediaQuery.of(context).size.width * 0.035,
            ),
          ),
        ],
      ),
    );
  }

  Widget createOrderButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF6D57FC),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: Text('Create order'),
    );
  }
}



