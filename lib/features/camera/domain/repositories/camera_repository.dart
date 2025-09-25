import '../entities/captured_image.dart';

abstract class CameraRepository {
  Future<CapturedImage?> takePicture();
}