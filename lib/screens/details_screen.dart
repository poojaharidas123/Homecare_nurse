import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homecare_nurse/screens/home_screen.dart';
import 'package:homecare_nurse/screens/home_screen_sections/request_section.dart';
import 'package:homecare_nurse/widgets/custom_meditation.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => HomeScreen())));
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Details",
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFFAAD013),
          ),
        ),
      ),
      backgroundColor: Color(0xFFE3F3DF),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      20.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Krithya M P',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '5 months',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'F',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Text('Health Conditions'),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 800,
                  height: 150,
                  // padding: const EdgeInsets.all(20.0),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cough'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Fever'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Cold'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Text('Meditations'),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 800,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Text('OTC Cough medicine')),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomMeditation(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 800,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Text('Acetaminophen')),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomMeditation(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 800,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Text('Nasal Saline drops')),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomMeditation(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
