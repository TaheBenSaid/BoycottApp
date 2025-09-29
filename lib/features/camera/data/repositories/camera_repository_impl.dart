import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/captured_image.dart';
import '../../domain/repositories/camera_repository.dart';
import '../../../../services/tflite_service.dart';

class CameraRepositoryImpl implements CameraRepository {
  final ImagePicker picker;
  CameraController? _controller;

  CameraRepositoryImpl(this.picker);

  Future<bool> initializeTensorFlow() async {
    return await TFLiteService.instance.initialize();
  }

  Future<CameraController?> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return null;

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );

    await _controller!.initialize();
    await _controller!.setFlashMode(FlashMode.off);
    return _controller;
  }

  CameraController? get controller => _controller;

  Future<void> toggleFlash() async {
    if (_controller?.value.isInitialized == true) {
      final currentFlashMode = _controller!.value.flashMode;
      final newFlashMode =
          currentFlashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
      await _controller!.setFlashMode(newFlashMode);
    }
  }

  bool get isFlashOn => _controller?.value.flashMode == FlashMode.torch;

  @override
  Future<CapturedImage?> takePicture() async {
    String? imagePath;

    if (_controller?.value.isInitialized == true) {
      try {
        final XFile file = await _controller!.takePicture();
        imagePath = file.path;
      } catch (e) {
        print('Error taking picture: $e');
      }
    }

    if (imagePath == null) {
      final XFile? file = await picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        imagePath = file.path;
      }
    }

    if (imagePath == null) {
      return null;
    }

    // Run inference on the captured image
    InferenceResult? inferenceResult;
    try {
      if (TFLiteService.instance.isInitialized) {
        inferenceResult = await TFLiteService.instance.runInference(imagePath);
      } else {
        print('TFLite service not initialized, initializing now...');
        await initializeTensorFlow();
        inferenceResult = await TFLiteService.instance.runInference(imagePath);
      }
    } catch (e) {
      print('Error running inference: $e');
    }

    return CapturedImage(imagePath, inferenceResult: inferenceResult);
  }

  void dispose() {
    _controller?.dispose();
  }
}
