import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'assign_requests_event.dart';
part 'assign_requests_state.dart';

class AssignRequestsBloc
    extends Bloc<AssignRequestsEvent, AssignRequestsState> {
  AssignRequestsBloc() : super(AssignRequestsInitialState()) {
    on<AssignRequestsEvent>((event, emit) async {
      emit(AssignRequestsLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable =
          supabaseClient.from('nurse_assign_requests');
      List<Map<String, dynamic>> assignRequestWithNurseRequestList = [];
      try {
        if (event is GetAllAssignRequestsEvent) {
          List<dynamic> temp = await queryTable
              .select()
              .eq('nurse_id', supabaseClient.auth.currentUser!.id)
              .eq('status', 'pending')
              .order(
                'created_at',
              );

          List<Map<String, dynamic>> assignRequests =
              temp.map((e) => e as Map<String, dynamic>).toList();

          Map<String, dynamic> assignRequestWithNurseRequest = {};

          for (Map<String, dynamic> assignReq in assignRequests) {
            List<dynamic> tempTest = await supabaseClient.rpc(
              'get_nurse_requests',
              params: {
                'search_nurse_request_id': assignReq['nurse_request_id'],
              },
            );

            Map<String, dynamic> nurse = await supabaseClient
                .from('nurses')
                .select()
                .eq('user_id', supabaseClient.auth.currentUser!.id)
                .single();

            Map<String, dynamic> req = tempTest.first as Map<String, dynamic>;

            assignRequestWithNurseRequest = {
              'assign_request': assignReq,
              'request': req,
              'nurse': nurse,
            };

            assignRequestWithNurseRequestList
                .add(assignRequestWithNurseRequest);
          }
          Logger().d(assignRequestWithNurseRequestList);
          emit(
            AssignRequestsSuccessState(
              assignRequests: assignRequestWithNurseRequestList,
            ),
          );
        } else if (event is HandleAssignRequestsEvent) {
          if (event.reason != null) {
            await queryTable.update(
              {
                'reason': event.reason,
                'status': 'rejected',
              },
            ).eq('id', event.assignRequestId);
          } else {
            await queryTable.update(
              {
                'status': 'accepted',
              },
            ).eq('id', event.assignRequestId);

            await supabaseClient.from('nurse_requests').update({
              'assigned_nurse_id': supabaseClient.auth.currentUser!.id,
              'amount': event.amount,
              'status': 'active',
            }).eq('id', event.nurseRequestId);
          }

          add(GetAllAssignRequestsEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(AssignRequestsFailureState());
      }
    });
  }
}
