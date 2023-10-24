import 'package:hydrated_bloc/hydrated_bloc.dart';

class AvatarState {
  final String imagePath; // Store the path to the selected image.

  AvatarState({
    required this.imagePath,
  });
}

class AvatarCubit extends HydratedCubit<AvatarState> {
  AvatarCubit()
      : super(
          AvatarState(
            imagePath: '',
          ),
        );

  void setImage(String imagePath) {
    emit(AvatarState(imagePath: imagePath));
  }

  @override
  AvatarState? fromJson(Map<String, dynamic> json) {
    return AvatarState(imagePath: json['imagePath']);
  }

  @override
  Map<String, dynamic>? toJson(AvatarState state) {
    return {
      'imagePath': state.imagePath,
    };
  }
}
