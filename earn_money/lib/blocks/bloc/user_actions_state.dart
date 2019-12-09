import 'package:equatable/equatable.dart';

abstract class UserActionsState extends Equatable {
  const UserActionsState();
}

class InitialUserActionsState extends UserActionsState {
  @override
  List<Object> get props => [];
}
