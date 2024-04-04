import 'package:bloc_test_form_example/bloc/email_bloc.dart';
import 'package:bloc_test_form_example/pages/step_two.dart';
import 'package:bloc_test_form_example/widgets/flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../regx.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Step 1'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<EmailBloc, EmailState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (email) =>
                        context.read<EmailBloc>().add(EmailChanged(email)),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: '이메일',
                        hintText: '이메일을 입력하세요',
                        border: const OutlineInputBorder(),
                        errorText: !state.isValid ? '유효하지 않은 이메일입니다.' : null
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              BlocBuilder<EmailBloc, EmailState>(
                buildWhen: (previous, current) =>
                  previous.isValid != current.isValid,
                builder: (context, state) {
                  return FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StepTwo(),
                          ),
                        );
                      },
                      text: 'Next',
                      isActive: state.isValid);
                },
              ),
            ],
          ),
        ),
      );
}
