import '../../../../services/tflite_service.dart';

class CapturedImage {
  final String path;
  final InferenceResult? inferenceResult;

  CapturedImage(this.path, {this.inferenceResult});
}
