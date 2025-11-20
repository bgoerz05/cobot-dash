import 'package:cobot_dashboard/features/controls/control_event.dart';
import 'package:cobot_dashboard/features/controls/control_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlBloc extends Bloc<ControlEvent, ControlState> {
  ControlBloc() : super(ControlState());
}
