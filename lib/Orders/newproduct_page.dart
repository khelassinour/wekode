import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NewProductPage extends StatefulWidget {
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  int _selectedToggleIndex = 0;
  File? _selectedImage;
  int _productQuantity = 1;
  String _selectedCategory = 'Electronics';
  final List<String> _classes = [
    'Fragile',
    'Important',
    'High value',
    'Important'
  ];
  final List<bool> _isSelectedClass = [false, false, false, false];

  // Measurement fields
  String _weightUnit = 'KG';
  String _heightUnit = 'cm';
  String _lengthUnit = 'cm';
  String _widthUnit = 'cm';

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null && await pickedFile.length() <= 5242880) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image less than 5 MB.')),
      );
    }
  }

  void _incrementQuantity() {
    setState(() {
      _productQuantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_productQuantity > 1) {
        _productQuantity--;
      }
    });
  }

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
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text('New product', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double fieldWidth = constraints.maxWidth * 0.9;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('How would you like to proceed with your shipment?', style: TextStyle(fontSize: 13)),
                const SizedBox(height: 20),
                ToggleSwitch(
                  minWidth: 160.0,
                  minHeight: 45.0,
                  cornerRadius: 10.0,
                  activeBgColor: [Colors.white],
                  activeFgColor: Colors.black,
                  inactiveBgColor: Colors.grey[200],
                  inactiveFgColor: Colors.grey,
                  initialLabelIndex: _selectedToggleIndex,
                  totalSwitches: 2,
                  labels: ['Purchase item', 'Ship owned item'],
                  icons: [Icons.shopping_bag, Icons.local_shipping],
                  onToggle: (index) {
                    setState(() {
                      _selectedToggleIndex = index!;
                    });
                  },
                ),

                const Divider(height: 30),
                const SizedBox(height: 10),
                const Text('Item details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                _buildLabelTextField('', 'Ex: Hair dryer for home use', fieldWidth),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Product quantity'),
                    const Spacer(),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: _decrementQuantity,
                    ),
                    Text('$_productQuantity'),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: _incrementQuantity,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildMeasurementField('Product\'s weight', 'Weight ', _weightUnit, ['KG', 'g'], fieldWidth),
                const SizedBox(height: 10),
                _buildMeasurementField('Product\'s height', 'Height ', _heightUnit, ['cm', 'ft', 'in'], fieldWidth),
                const SizedBox(height: 10),
                _buildMeasurementField('Product\'s length', 'Length ', _lengthUnit, ['cm', 'm', 'in'], fieldWidth),
                const SizedBox(height: 10),
                _buildMeasurementField('Product\'s width', 'Width ', _widthUnit, ['cm', 'm'], fieldWidth),
                const SizedBox(height: 20),

                // Added label for product's image
                const Text("Product's image", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 10),

                _buildImageUploadField(),
                const SizedBox(height: 16),

                // Changed the label for product's category to Text widget above the dropdown
                const Text("Product's category", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey )),
                const SizedBox(height: 4),
                _buildCategoryDropdown(),
                const SizedBox(height: 16),
                _buildProductClasses(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF6D57FC),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Create product'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabelTextField(String label, String hint, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12), // Decreased height
          ),
        ),
      ],
    );
  }

  Widget _buildMeasurementField(String label, String hint, String selectedUnit, List<String> units, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 4),
          Container(
            height: 50,
            child: InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: TextStyle(fontSize: 15),
                        border: InputBorder.none,

                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedUnit,
                    underline: const SizedBox(),
                    items: units.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        if (label == 'Product\'s weight') {
                          _weightUnit = newValue!;
                        } else if (label == 'Product\'s height') {
                          _heightUnit = newValue!;
                        } else if (label == 'Product\'s length') {
                          _lengthUnit = newValue!;
                        } else if (label == 'Product\'s width') {
                          _widthUnit = newValue!;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadField() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF6D57FC), style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            const Icon(Icons.upload_file, color: Color(0xFF6D57FC)),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(text: 'Drag your image', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  TextSpan(text: ' or ', style: TextStyle(color: Colors.black)),
                  TextSpan(text: 'browse', style: TextStyle(color: Color(0xFF6D57FC))),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Text('Max 5 MB image is allowed', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
      value: _selectedCategory,
      items: ['Electronics', 'Furniture', 'Clothing', 'Toys'].map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue!;
        });
      },
    );
  }

  Widget _buildProductClasses() {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Wrap(
        spacing: 8.0, // Horizontal spacing between chips
        runSpacing: 8.0, // Vertical spacing between rows
        children: List<Widget>.generate(_classes.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _isSelectedClass[index] = !_isSelectedClass[index];
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _isSelectedClass[index] ? const Color(0xFF6D57FC) : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _classes[index],
                style: TextStyle(
                  color: _isSelectedClass[index] ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }






}
