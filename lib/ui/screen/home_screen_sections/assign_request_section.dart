import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecare_nurse/blocs/manage_patients/manage_patients_bloc.dart';
import 'package:homecare_nurse/ui/widgets/custom_alert_dialog.dart';
import 'package:homecare_nurse/ui/widgets/custom_button.dart';
import 'package:homecare_nurse/ui/widgets/custom_card.dart';
import 'package:homecare_nurse/ui/widgets/label_with_text.dart';
import 'package:homecare_nurse/util/value_validators.dart';
import 'package:intl/intl.dart';

import '../../../blocs/assign_requests/assign_requests_bloc.dart';
import '../../../blocs/manage_nurse_requests/manage_nurse_request_bloc.dart';
import '../../widgets/custom_add_button.dart';
import '../../widgets/custom_patient_card.dart';

class AssignRequestSection extends StatefulWidget {
  const AssignRequestSection({super.key});

  @override
  State<AssignRequestSection> createState() => _AssignRequestSectionState();
}

class _AssignRequestSectionState extends State<AssignRequestSection> {
  final AssignRequestsBloc managePatientsBloc = AssignRequestsBloc();

  @override
  void initState() {
    super.initState();
    managePatientsBloc.add(GetAllAssignRequestsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssignRequestsBloc>.value(
      value: managePatientsBloc,
      child: BlocConsumer<AssignRequestsBloc, AssignRequestsState>(
        listener: (context, state) {
          if (state is AssignRequestsFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                message: state.message,
                primaryButtonLabel: 'Retry',
                primaryOnPressed: () {
                  managePatientsBloc.add(GetAllAssignRequestsEvent());
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 100,
            ),
            children: [
              state is AssignRequestsSuccessState
                  ? state.assignRequests.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => AssignRequestCard(
                            assignRequest: state.assignRequests[index],
                            assignRequestsBloc:
                                BlocProvider.of<AssignRequestsBloc>(context),
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: state.assignRequests.length,
                        )
                      : const Center(
                          child: Text(
                            'No AssignRequests found',
                          ),
                        )
                  : const Padding(
                      padding: EdgeInsets.all(100),
                      child: CupertinoActivityIndicator(),
                    ),
            ],
          );
        },
      ),
    );
  }
}

class AssignRequestCard extends StatelessWidget {
  final dynamic assignRequest;
  final AssignRequestsBloc assignRequestsBloc;
  const AssignRequestCard({
    super.key,
    required this.assignRequest,
    required this.assignRequestsBloc,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '#${assignRequest['assign_request']['id']}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${assignRequest['request']['patient']['name']}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        insetPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: PatientCard(
                          patientDetails: assignRequest['request']['patient'],
                        ),
                      ),
                    );
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelWithText(
                  label: 'Date From',
                  text: DateFormat('dd/MM/yyyy').format(
                      DateTime.parse(assignRequest['request']['date_start'])),
                ),
                LabelWithText(
                  alignment: CrossAxisAlignment.end,
                  label: 'Date To',
                  text: DateFormat('dd/MM/yyyy').format(
                      DateTime.parse(assignRequest['request']['date_end'])),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelWithText(
                  label: 'Time From',
                  text: TimeOfDay.fromDateTime(DateTime.parse(
                          '2000-10-10 ${assignRequest['request']['time_start']}'))
                      .format(context),
                ),
                LabelWithText(
                  alignment: CrossAxisAlignment.end,
                  label: 'Time To',
                  text: TimeOfDay.fromDateTime(DateTime.parse(
                          '2000-10-10 ${assignRequest['request']['time_end']}'))
                      .format(context),
                ),
              ],
            ),
            const Divider(height: 30),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Accept',
                    onPressed: () {
                      int hourlyRate = assignRequest['nurse']['hourly_rate'];

                      DateTime startDate = DateTime.parse(
                          assignRequest['request']['date_start']);
                      DateTime endDate =
                          DateTime.parse(assignRequest['request']['date_end']);

                      DateTime startTime = DateTime.parse(
                          '2000-10-10 ${assignRequest['request']['time_start']}');
                      DateTime endTime = DateTime.parse(
                          '2000-10-10 ${assignRequest['request']['time_end']}');

                      int dateDifference = endDate.difference(startDate).inDays;
                      int timeDifference =
                          endTime.difference(startTime).inHours;

                      int amount = dateDifference * timeDifference * hourlyRate;

                      assignRequestsBloc.add(
                        HandleAssignRequestsEvent(
                          assignRequestId: assignRequest['assign_request']
                              ['id'],
                          nurseRequestId: assignRequest['request']['id'],
                          amount: amount,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    label: 'Reject',
                    buttonColor: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ReasonForm(
                          assignRequestsBloc: assignRequestsBloc,
                          requestId: assignRequest['assign_request']['id'],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReasonForm extends StatefulWidget {
  final AssignRequestsBloc assignRequestsBloc;
  final int requestId;
  const ReasonForm({
    super.key,
    required this.assignRequestsBloc,
    required this.requestId,
  });

  @override
  State<ReasonForm> createState() => _ReasonFormState();
}

class _ReasonFormState extends State<ReasonForm> {
  final TextEditingController reasonController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Reason',
      message: 'Enter a reason to reject the request',
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: reasonController,
          minLines: 3,
          maxLines: 5,
          validator: alphaNumericValidator,
          decoration: const InputDecoration(
            hintText: 'Reason',
            prefixIcon: Icon(
              Icons.receipt_outlined,
            ),
          ),
        ),
      ),
      primaryButtonLabel: 'Reject',
      primaryOnPressed: () {
        if (formKey.currentState!.validate()) {
          widget.assignRequestsBloc.add(
            HandleAssignRequestsEvent(
              assignRequestId: widget.requestId,
              reason: reasonController.text.trim(),
            ),
          );
          Navigator.pop(context);
        }
      },
    );
  }
}
