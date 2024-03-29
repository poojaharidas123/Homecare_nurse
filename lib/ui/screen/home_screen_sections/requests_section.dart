import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecare_nurse/blocs/manage_nurse_requests/manage_nurse_request_bloc.dart';
import 'package:homecare_nurse/ui/widgets/complaints/add_complaint_dialog.dart';
import 'package:homecare_nurse/ui/widgets/custom_button.dart';
import 'package:homecare_nurse/ui/widgets/custom_icon_button.dart';
import 'package:homecare_nurse/ui/widgets/label_with_text.dart';
import 'package:homecare_nurse/util/postgres_time_to_time_of_day.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../util/get_age.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_patient_card.dart';

class RequestSection extends StatefulWidget {
  const RequestSection({super.key});

  @override
  State<RequestSection> createState() => _RequestSectionState();
}

class _RequestSectionState extends State<RequestSection> {
  String selecteStatus = 'active';
  @override
  void initState() {
    super.initState();
    getNurseRequests();
  }

  void getNurseRequests() {
    BlocProvider.of<ManageNurseRequestBloc>(context).add(
      GetAllNurseRequestEvent(
        status: selecteStatus,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageNurseRequestBloc, ManageNurseRequestState>(
      listener: (context, state) {
        if (state is ManageNurseRequestFailureState) {
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              title: 'Failure',
              message: state.message,
              primaryButtonLabel: 'Retry',
              primaryOnPressed: () {
                getNurseRequests();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            // const SizedBox(height: 20),
            // CupertinoSlidingSegmentedControl<String>(
            //   children: const {
            //     'active': Text('Active'),
            //     'pending': Text('Pending'),
            //     'rejected': Text('Rejected'),
            //   },
            //   onValueChanged: (status) {
            //     selecteStatus = status ?? 'active';
            //     setState(() {});
            //     getNurseRequests();
            //   },
            //   groupValue: selecteStatus,
            // ),
            Expanded(
              child: state is ManageNurseRequestSuccessState
                  ? state.requests.isNotEmpty
                      ? ListView.separated(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                            bottom: 20,
                          ),
                          itemBuilder: (context, index) => RequestItem(
                            requestDetails: state.requests[index],
                          ),
                          itemCount: state.requests.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                        )
                      : const Center(
                          child: Text(
                            'No Requests found',
                          ),
                        )
                  : const Padding(
                      padding: EdgeInsets.all(100),
                      child: CupertinoActivityIndicator(),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class RequestItem extends StatefulWidget {
  final dynamic requestDetails;
  const RequestItem({
    Key? key,
    this.requestDetails,
  }) : super(key: key);

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  @override
  void initState() {
    Logger().wtf(widget.requestDetails);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '#${widget.requestDetails['id']}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                  ),
                ),
                Text(
                  widget.requestDetails['status'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                ),
                if (widget.requestDetails['status'] == 'active')
                  const SizedBox(width: 10),
                if (widget.requestDetails['status'] == 'active')
                  CustomIconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddComplaintDialog(
                          requestId: widget.requestDetails['id'],
                        ),
                      );
                    },
                    iconData: Icons.report_gmailerrorred,
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.requestDetails['patient']['name'],
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${getAge(DateTime.parse(widget.requestDetails['patient']['dob']))} ${widget.requestDetails['patient']['gender']}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                      ),
                    ],
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
                          patientDetails: widget.requestDetails['patient'],
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'View Details',
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date Range :',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black45,
                      ),
                ),
                const SizedBox(width: 5),
                Text(
                  '${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.requestDetails['date_start']))} to ${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.requestDetails['date_end']))}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time Range :',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black45,
                      ),
                ),
                const SizedBox(width: 5),
                Text(
                  '${convertPostgresTimeToTimeOfDay(widget.requestDetails['time_start']).format(context)} to ${convertPostgresTimeToTimeOfDay(widget.requestDetails['time_end']).format(context)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
