import 'package:bloc_test_form_example/widgets/flat_button.dart';
import 'package:flutter/material.dart';

class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isButtonActive = false;

  void _checkpasswordValidity() {
    final isPasswordMatch =
        _passwordController.text == _confirmPasswordController.text;
    final isPasswordNotEmpty = _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;

    setState(() {
      _isButtonActive = isPasswordMatch && isPasswordNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkpasswordValidity);
    _confirmPasswordController.addListener(_checkpasswordValidity);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Step3'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    hintText: '비밀번호를 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: '비밀번호 재입력',
                    hintText: '비밀번호를 다시 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                FlatButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  text: 'Complete Registration',
                  isActive: _isButtonActive,
                )
              ],
            )),
      );
}
