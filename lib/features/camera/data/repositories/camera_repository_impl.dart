import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/captured_image.dart';
import '../../domain/repositories/camera_repository.dart';

class CameraRepositoryImpl implements CameraRepository {
  final ImagePicker picker;
  CameraController? _controller;

  CameraRepositoryImpl(this.picker);

  Future<CameraController?> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return null;

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );

    await _controller!.initialize();
    return _controller;
  }

  CameraController? get controller => _controller;

  @override
  Future<CapturedImage?> takePicture() async {
    if (_controller?.value.isInitialized == true) {
      try {
        final XFile file = await _controller!.takePicture();
        return CapturedImage(file.path);
      } catch (e) {
        print('Error taking picture: $e');
      }
    }

    // Fallback to image picker if camera fails
    final XFile? file = await picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      return CapturedImage(file.path);
    }
    return null;
  }

  void dispose() {
    _controller?.dispose();
  }
}
