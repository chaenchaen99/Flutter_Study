import 'package:bloc_test_form_example/bloc/name_bloc.dart';
import 'package:bloc_test_form_example/pages/step_three.dart';
import 'package:bloc_test_form_example/widgets/flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Step 2'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<NameBloc, NameState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (name) =>
                        context.read<NameBloc>().add(NameChanged(name)),
                    decoration: InputDecoration(
                        labelText: '이름',
                        hintText: '이름을 입력하세요.',
                        border: const OutlineInputBorder(),
                        errorText: !state.isValid ? '유효하지 않은 이름입니다.' : null
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              BlocBuilder<NameBloc, NameState>(
                buildWhen: (previous,current) => previous.isValid != current.isValid,
                builder: (context, state) {
                  return FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StepThree(),
                          ),
                        );
                      },
                      text: 'Next',
                      isActive: state.isValid,);
                },
              ),
            ],
          ),
        ),
      );
}
