class CounterState {
  final int number;

  CounterState({required this.number});
}

class CounterInit extends CounterState {
  CounterInit() : super(number: 0);
}
