part of 'assign_requests_bloc.dart';

@immutable
abstract class AssignRequestsState {}

class AssignRequestsInitialState extends AssignRequestsState {}

class AssignRequestsLoadingState extends AssignRequestsState {}

class AssignRequestsSuccessState extends AssignRequestsState {
  final List<Map<String, dynamic>> assignRequests;

  AssignRequestsSuccessState({required this.assignRequests});
}

class AssignRequestsFailureState extends AssignRequestsState {
  final String message;

  AssignRequestsFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
