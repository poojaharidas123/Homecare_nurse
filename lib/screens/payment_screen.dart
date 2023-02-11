import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homecare_nurse/screens/home_screen.dart';
import 'package:homecare_nurse/screens/home_screen_sections/profile_section.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => HomeScreen())));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Payment",
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFFAAD013),
          ),
        ),
      ),
      backgroundColor: Color(0xFFE3F3DF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(
                height: 75,
              ),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(45),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 30,
                    bottom: 30,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                          ),
                          Text(
                            'Pending',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text('Krithya M P'),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '14/11/2023',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                'to',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                '13/03/2023',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          Text(
                            '20,000',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(45),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 30,
                    bottom: 30,
                    right: 30,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                          ),
                          Text(
                            'Received',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text('Izha'),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '03/05/2023',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                'to',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                '15/11/2023',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          Text(
                            '90,000',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
