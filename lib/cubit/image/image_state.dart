abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {}

class ImageError extends ImageState {
  final String message;
  ImageError({required this.message});
}
