class Ticker {
  const Ticker();

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1);
    //주어진 초(ticks)에서 시작하여 매 초마다 1씩 감소하는 값을 발생시키는 스트림.
  }
}