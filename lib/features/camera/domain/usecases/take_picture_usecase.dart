import '../entities/captured_image.dart';
import '../repositories/camera_repository.dart';

class TakePictureUseCase {
  final CameraRepository repository;
  TakePictureUseCase(this.repository);

  Future<CapturedImage?> call() async {
    return await repository.takePicture();
  }
}