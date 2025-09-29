import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'boycott_database.dart';

class TFLiteService {
  static TFLiteService? _instance;
  static TFLiteService get instance => _instance ??= TFLiteService._();
  TFLiteService._();

  Interpreter? _interpreter;
  List<String>? _labels;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<bool> initialize() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/best_float32.tflite');

      _labels = await _loadLabels();

      _isInitialized = true;
      print('TFLite model initialized successfully');
      return true;
    } catch (e) {
      print('Error initializing TFLite model: $e');
      _isInitialized = false;
      return false;
    }
  }

  Future<List<String>> _loadLabels() async {
    try {
      final labelsData = await rootBundle.loadString('assets/labels.txt');
      return labelsData.split('\n').where((line) => line.isNotEmpty).toList();
    } catch (e) {
      print('Labels file not found, using default labels');
      return [
        'Starbucks',
        'McDonald\'s',
        'Coca-Cola',
        'Pepsi',
        'Nike',
        'Adidas',
        'Apple',
        'Samsung',
        'Unknown Product',
        'Other Brand'
      ];
    }
  }

  Future<InferenceResult?> runInference(String imagePath) async {
    if (!_isInitialized || _interpreter == null || _labels == null) {
      print('TFLite service not initialized');
      return null;
    }

    try {
      final imageData = await _preprocessImage(imagePath);
      if (imageData == null) {
        print('Failed to preprocess image');
        return null;
      }

      final inputShape = _interpreter!.getInputTensor(0).shape;
      final outputShape = _interpreter!.getOutputTensor(0).shape;

      print('Input shape: $inputShape');
      print('Output shape: $outputShape');

      final input = [imageData];
      final output =
          List.filled(outputShape[1], 0.0).reshape([1, outputShape[1]]);

      _interpreter!.run(input, output);
      final predictions = output[0] as List<double>;
      return _processResults(predictions);
    } catch (e) {
      print('Error during inference: $e');
      return null;
    }
  }

  Future<List<List<List<double>>>?> _preprocessImage(String imagePath) async {
    try {
      final imageFile = File(imagePath);
      final imageBytes = await imageFile.readAsBytes();

      img.Image? image = img.decodeImage(imageBytes);
      if (image == null) return null;

      final inputShape = _interpreter!.getInputTensor(0).shape;
      final inputHeight = inputShape[1];
      final inputWidth = inputShape[2];
      final inputChannels = inputShape[3];

      print('Expected input size: ${inputWidth}x${inputHeight}x$inputChannels');

      image = img.copyResize(image, width: inputWidth, height: inputHeight);

      final imageMatrix = List.generate(
        inputHeight,
        (y) => List.generate(
          inputWidth,
          (x) => List.generate(inputChannels, (c) {
            final pixel = image!.getPixel(x, y);
            if (inputChannels == 3) {
              switch (c) {
                case 0:
                  return pixel.r / 255.0;
                case 1:
                  return pixel.g / 255.0;
                case 2:
                  return pixel.b / 255.0;
                default:
                  return 0.0;
              }
            } else {
              return (pixel.r * 0.299 + pixel.g * 0.587 + pixel.b * 0.114) /
                  255.0;
            }
          }),
        ),
      );

      return imageMatrix;
    } catch (e) {
      print('Error preprocessing image: $e');
      return null;
    }
  }

  InferenceResult _processResults(List<double> predictions) {
    double maxConfidence = predictions[0];

    for (int i = 1; i < predictions.length; i++) {
      if (predictions[i] > maxConfidence) {
        maxConfidence = predictions[i];
      }
    }

    final indexedPredictions = predictions
        .asMap()
        .entries
        .map((entry) => Prediction(
              label: _labels![entry.key % _labels!.length],
              confidence: entry.value,
              index: entry.key,
            ))
        .toList();

    indexedPredictions.sort((a, b) => b.confidence.compareTo(a.confidence));
    final topPredictions = indexedPredictions.take(3).toList();

    return InferenceResult(
      predictions: topPredictions,
      topPrediction: topPredictions.first,
      processingTime: DateTime.now().millisecondsSinceEpoch,
    );
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _labels = null;
    _isInitialized = false;
  }
}

class Prediction {
  final String label;
  final double confidence;
  final int index;

  Prediction({
    required this.label,
    required this.confidence,
    required this.index,
  });

  @override
  String toString() => '$label (${(confidence * 100).toStringAsFixed(1)}%)';
}

class InferenceResult {
  final List<Prediction> predictions;
  final Prediction topPrediction;
  final int processingTime;

  InferenceResult({
    required this.predictions,
    required this.topPrediction,
    required this.processingTime,
  });

  bool get isBoycotted {
    return BoycottDatabase.instance.isProductBoycotted(topPrediction.label);
  }

  BoycottInfo get boycottInfo {
    final productInfo =
        BoycottDatabase.instance.getProductInfo(topPrediction.label);

    if (productInfo != null) {
      return productInfo.toBoycottInfo();
    } else {
      return BoycottInfo(
        productName: topPrediction.label,
        companyName: 'Unknown Company',
        description:
            'Product detected but no specific information available in our database. Please verify manually.',
        isBoycotted: false,
        alternatives: [
          'Research this product',
          'Check ethical alternatives',
          'Look for local brands'
        ],
      );
    }
  }
}
