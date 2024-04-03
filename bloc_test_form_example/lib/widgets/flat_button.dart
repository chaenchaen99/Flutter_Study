import 'package:flutter/material.dart';

class FlatButton extends StatelessWidget {
  final VoidCallback? onPressed; //VoidCallback : 입력 인자, 반환값이 없는 함수 지정 시 사용
  final String text;
  final bool isActive;

  const FlatButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth,
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.blue : Colors.grey,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
