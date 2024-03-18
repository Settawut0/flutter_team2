import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home-page.dart';

class TicketForm extends StatefulWidget {
  @override
  _TicketFormState createState() => _TicketFormState();
}

class Ticket {
  final String title;
  final String description;

  Ticket({required this.title, required this.description});
}

class _TicketFormState extends State<TicketForm> {
  String? _selectedType; // Initialize as nullable
  String? _selectedPriority; // Initialize as nullable
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final List<String> _types = ['Hardware', 'Software', 'Service Request'];
  final List<String> _priorities = ['High', 'Medium', 'Low'];

  List<String> _selectedTypes = [];
  List<String> _selectedPriorities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Ticket',
          style: TextStyle(
            fontSize: 25, // เปลี่ยนขนาดตัวหนังสือ
            fontWeight: FontWeight.bold, // ทำให้ตัวหนังสือหนาขึ้น
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Type',
              style: TextStyle(
                fontSize: 18, // เปลี่ยนขนาดตัวหนังสือ
                fontWeight: FontWeight.bold,

                // ทำให้ตัวหนังสือหนาขึ้น
                // ตั้งสีข้อความเป็นสีขาว
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedType,
              hint: Text('Select Type'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue; // Update selected type
                });
              },
              items: _types.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 1.0),
            Text(
              'Priority',
              style: TextStyle(
                fontSize: 18, // เปลี่ยนขนาดตัวหนังสือ
                fontWeight: FontWeight.bold, // ทำให้ตัวหนังสือหนาขึ้น
                // ตั้งสีข้อความเป็นสีขาว
              ),
            ), // Adjusted height here
            DropdownButtonFormField<String>(
              value: _selectedPriority,
              hint: Text('Select Priority'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPriority = newValue; // Update selected priority
                });
              },
              items: _priorities.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 5.0), // Add space between Type and Description
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the current page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .blueGrey[900], // Set background color to blueGrey
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white, // Set text color to white
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10), // Add space between buttons
                ElevatedButton(
                  onPressed: _submitForm, // Call _submitForm function
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Set background color to green
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    String title = _titleController.text;
    String description = _descriptionController.text;

    // Check if any field is empty
    if (title.isEmpty ||
        description.isEmpty ||
        _selectedType == null ||
        _selectedPriority == null) {
      // Show alert dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error :('),
            content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Exit the function early
    }

    Ticket ticket = Ticket(title: title, description: description);
    Navigator.pop(context, ticket); // Return Ticket object to previous page
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
