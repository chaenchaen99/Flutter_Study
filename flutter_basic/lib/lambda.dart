import 'dart:io';

void main() async {
  ///람다의 표현 설명

  /// (int 파라미터1, String 파라미터2) => 반환값

  int add(int a, int b) {
    return a + b;
  }

  (int a, int b) => a + b;

  ///람다의 특징 설명

  ///1.익명: 이름을 지을 수 없다. (변수에 담을 수 있다.)
  ///2.함수: Class에 의존하지 않고 독립적으로 사용 가능
  ///3.전달: 1급 객체로서 함수 파라미터로 전달, 변수에 저장 가능
  ///4.간결성: 익명 클래스처럼 많은 코드를 구현할 필요가 없다.

  /// List Sort 예제
  final list = [5, 2, 4, 1, 3];
  list.sort((a, b) => a == b
      ? 0
      : a > b
          ? 1
          : -1);
  print(list);

  add3(a) => (b) => a + b;
  print(add3(1)(2)); // 출력: 3
}
