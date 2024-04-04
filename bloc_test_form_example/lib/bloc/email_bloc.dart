

import 'package:bloc_test_form_example/regx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super (const EmailState(email:'', isValid: false)) {

  }

  void _onEmailChanged(EmailChanged event, Emitter<EmailState> emit){
    final email = event.email;
    final isValid = emailRegExp.hasMatch(email);
    emit(EmailState(email: email, isValid: isValid));
  }
}