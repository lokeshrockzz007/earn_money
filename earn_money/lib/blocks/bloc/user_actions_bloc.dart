import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class UserActionsBloc extends Bloc<UserActionsEvent, UserActionsState> {
  @override
  UserActionsState get initialState => InitialUserActionsState();

  @override
  Stream<UserActionsState> mapEventToState(
    UserActionsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
