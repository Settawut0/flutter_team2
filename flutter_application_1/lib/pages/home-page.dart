import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/text_service.dart';
import 'package:flutter_application_1/pages/ticket.dart';
import 'package:flutter_application_1/pages/my_account.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  
    List<MyAccount>? myAccount;
  void initState() {
    super.initState();
    getDataTicket().then((acc)=>{myAccount=acc,print(acc[0].tktStatus)});
    print(myAccount);
  }

  Future<List<MyAccount>> getDataTicket() async {
    final userid = TextUser().userid; // ดึงค่า userid จาก TextUser class
    final apiUrl =
        Uri.parse("http://dekdee2.informatics.buu.ac.th:8002/mongoose/get/stts_tickets");
    final response = await http.post(
      apiUrl,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "where": {
          "tkt_act": userid, // ใช้ค่า userid จาก TextUser
          "tkt_delete": {"\$ne": "true"},
        },
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> Imposter=json.decode(response.body);
     
      return Imposter.map((check)=>MyAccount.fromJson(check)).toList();
    } else {
      throw Exception("Failed to load");
    }
  }



  int _ticketCount = 0; // Variable to store ticket count

  final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
    minimumSize: Size(200, 55),
    backgroundColor: const Color.fromRGBO(239, 83, 80, 1),
    elevation: 5,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(7.0), // ปรับขนาดตามต้องการ
          child: Image.asset(
            'lib/images/LogoSTTS.png',
            width: 30, // ปรับขนาดตามต้องการ
            height: 30, // ปรับขนาดตามต้องการ
          ),
        ),
        title: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 1.0), // ปรับตำแหน่งตามต้องการ
              child: Text(
                "Support Trouble Ticket System",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // ตำแหน่งอื่น ๆ ของรูปภาพหรือข้อความ
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: 135.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset(
                          'lib/images/Subtract.png',
                          height: 95.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_ticketCount',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'All Tickets',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: 135.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(55, 184, 121, 1),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset(
                          'lib/images/OpenTicket.png',
                          height: 95.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_ticketCount',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Open Tickets',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: 135.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset(
                          'lib/images/ClosedTicket.png',
                          height: 120.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Closed Tickets',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketForm(),
                  ),
                ).then((ticket) {
                  // Handle the returned Ticket object here
                  if (ticket != null) {
                    setState(() {
                      // Increment the ticket count
                      _ticketCount++;
                    });
                  }
                });
              },
              style: buttonPrimary,
              child: Text(
                "New Ticket",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
