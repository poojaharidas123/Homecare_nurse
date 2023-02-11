import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text(
          'Feedback',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFFAAD013),
          ),
        ),
      ),
      backgroundColor: Color(0xFFE3F3DF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 125,
              ),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 100.0,
                    left: 100.0,
                    top: 75,
                    bottom: 75,
                  ),
                  child: Text(
                    'Feedback/Complaints',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
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
