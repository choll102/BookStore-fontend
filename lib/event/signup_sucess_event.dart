import 'package:da_muasachonline/base/base_event.dart';
import 'package:da_muasachonline/shared/model/user_data.dart';

class SignUpSuccessEvent extends BaseEvent {
  final UserData userData;
  SignUpSuccessEvent(this.userData);
}
