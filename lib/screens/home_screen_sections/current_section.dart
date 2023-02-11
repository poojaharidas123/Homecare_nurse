import 'package:flutter/material.dart';

import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_patient_card.dart';

class CurrentSection extends StatelessWidget {
  const CurrentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      children: [
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('01/05/2022'),
                    SizedBox(
                      width: 230,
                    ),
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
                        'Izha',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text('1 months'),
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
                    Text('03/05/2022'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('-'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('15/11/2022'),
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
