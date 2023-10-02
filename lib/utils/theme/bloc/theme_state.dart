class ThemeState {
  final bool switchValue;

  ThemeState({required this.switchValue});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'switchValue': switchValue,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      switchValue: map['switchValue'] as bool,
    );
  }
}

class ThemeInit extends ThemeState {
  ThemeInit({required bool switchValue}) : super(switchValue: false);
}
