part of 'assign_requests_bloc.dart';

@immutable
abstract class AssignRequestsEvent {}

class HandleAssignRequestsEvent extends AssignRequestsEvent {
  final String? reason;
  final int assignRequestId;
  final int? amount, nurseRequestId;

  HandleAssignRequestsEvent({
    this.reason,
    required this.assignRequestId,
    this.amount,
    this.nurseRequestId,
  });
}

class GetAllAssignRequestsEvent extends AssignRequestsEvent {
  final String? query;

  GetAllAssignRequestsEvent({this.query});
}
