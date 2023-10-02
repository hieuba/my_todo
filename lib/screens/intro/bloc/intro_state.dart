// ignore_for_file: public_member_api_docs, sort_constructors_first
class IntroState {
  int page;
  IntroState({
    required this.page,
  });
}

class IntroInit extends IntroState {
  IntroInit() : super(page: 0);
}
