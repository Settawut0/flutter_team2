import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/onboarding.dart';
import 'package:flutter_application_1/pages/text_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
            fontSize: 25,
            fontWeight: FontWeight.bold,
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            SizedBox(height: 5.0),
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
                    backgroundColor: Colors.blueGrey[900],
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
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
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error :('),
            content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    signUserIn(context);
  }

  Future<void> signUserIn(BuildContext context) async {
    final apiUrl = Uri.parse(
        "http://dekdee2.informatics.buu.ac.th:8002/mongoose/insert/stts_tickets");

    String userId = TextUser().userid; // You need to implement TextUser class

    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    String ticketNumber =
        "TKT-${now.day.toString().padLeft(2, '0')}${now.month.toString().padLeft(2, '0')}${now.year}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}${now.millisecond.toString().padLeft(3, '0')}";

    Map<String, dynamic> ticketData = {
      "tkt_picture": null,
      "tkt_time": formattedDate,
      "tkt_last_update": formattedDate,
      "tkt_number": ticketNumber,
      "tkt_act": userId,
      "tkt_status": "Pending",
      "tkt_book": false,
      "tkt_delete": false,
      "tkt_title": _titleController.text,
      "tkt_description": _descriptionController.text,
      "tkt_types": _selectedType,
      "tkt_priorities": _selectedPriority,
    };

    try {
      http.Response response = await http.post(
        apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"data": ticketData}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Ticket submitted successfully!"),
        ));
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           Onboarding()

        //           ), // Assuming MyHomePage is the name of your home page class
        // );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to submit ticket!"),
        ));
      }

      print(response.body);
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("An error occurred while submitting ticket!"),
      ));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
