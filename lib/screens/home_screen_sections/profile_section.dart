import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homecare_nurse/screens/payment_screen.dart';
import '../../widgets/custom_button.dart';

import '../../widgets/payment_item.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      children: [
        Column(
          children: [
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '01/05/2022',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 105,
                        ),
                        SizedBox(
                          height: 60,
                          width: 100,
                          child: CustomButton(
                            label: 'Edit',
                            iconData: Icons.edit,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Darshana M',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('abc house,P.O.Morazha'),
                              ],
                            ),
                            Row(
                              children: [Text('via Mottammal,Kannur')],
                            ),
                            Row(
                              children: [
                                Text('32'),
                                SizedBox(width: 30),
                                Text('F'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('SSLC,Plus Two,BSc Nursing'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('1 year(General)'),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 800,
              child: CustomButton(
                  label: 'Payment',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PaymentScreen())));
                  }),
            ),
            SizedBox(height: 30),
            Container(
              width: 800,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'Feedback/Complaint',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
