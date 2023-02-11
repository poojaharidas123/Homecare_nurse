import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homecare_nurse/screens/details_screen.dart';

import '../../widgets/custom_button.dart';

class RequestSection extends StatelessWidget {
  const RequestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('11/11/2022'),
                        SizedBox(
                          width: 180,
                        ),
                        Expanded(
                            child: CustomButton(
                          label: "Details",
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => DetailsScreen())));
                          },
                          buttonColor: Colors.white,
                          textColor: Color(0xFFAAD013),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "https://amritammu.com/wp-content/uploads/2020/04/Newborn-Baby-Photoshoot-Amrit-Ammu-Photography-90.jpg",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 15),
                        Column(children: [
                          Text(
                            'Krithya M P',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text('5 months'),
                              SizedBox(
                                width: 5,
                              ),
                              Text('F'),
                            ],
                          )
                        ])
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text('Date Range :'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('14/11/2022'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('-'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('31/03/2023'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Time Range :'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('01:00 PM'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('-'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('04:00 PM'),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            label: 'Rejected',
                            onPressed: () {},
                            buttonColor: Color.fromARGB(255, 240, 152, 20),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child:
                              CustomButton(label: 'Accepted', onPressed: () {}),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
