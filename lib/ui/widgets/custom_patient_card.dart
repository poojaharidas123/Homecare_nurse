import 'package:flutter/material.dart';
import 'package:homecare_nurse/blocs/manage_patients/manage_patients_bloc.dart';
import 'package:homecare_nurse/util/get_age.dart';

import 'custom_card.dart';
import 'label_with_text.dart';

class PatientCard extends StatelessWidget {
  final Map<String, dynamic> patientDetails;
  const PatientCard({
    super.key,
    required this.patientDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 320,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '#${patientDetails['id'].toString()}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                patientDetails['name'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                '${getAge(DateTime.parse(patientDetails['dob']))} ${patientDetails['gender']}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 15,
              ),
              LabelWithText(
                label: 'Phone No',
                text: patientDetails['phone'],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Address',
                text: patientDetails['address'],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Conditions',
                text: patientDetails['conditions'],
              ),
              if (patientDetails['medications'].isNotEmpty)
                const Divider(height: 30),
              if (patientDetails['medications'].isNotEmpty)
                const Text(
                  'Medications',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              if (patientDetails['medications'].isNotEmpty)
                const SizedBox(
                  height: 2.5,
                ),
              if (patientDetails['medications'].isNotEmpty)
                ...List<Widget>.generate(
                  patientDetails['medications'].length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          patientDetails['medications'][index]['medicine'],
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          patientDetails['medications'][index]['timing'],
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
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
    );
  }
}
