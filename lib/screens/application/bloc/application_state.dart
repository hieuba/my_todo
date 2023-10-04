class ApplicationState {
  final int index;
  ApplicationState({required this.index});
}

class InitialApplication extends ApplicationState {
  InitialApplication() : super(index: 0);
}
