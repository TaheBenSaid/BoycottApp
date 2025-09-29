import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../../../services/tflite_service.dart';

class RecognitionOverlayWidget extends StatefulWidget {
  final CameraController? cameraController;

  const RecognitionOverlayWidget({
    super.key,
    required this.cameraController,
  });

  @override
  State<RecognitionOverlayWidget> createState() =>
      _RecognitionOverlayWidgetState();
}

class _RecognitionOverlayWidgetState extends State<RecognitionOverlayWidget> {
  Timer? _recognitionTimer;
  InferenceResult? _currentResult;
  bool _isProcessing = false;

  // Recognition box properties
  Rect? _recognitionBox;
  String? _recognizedProduct;
  bool _isBoycotted = false;

  @override
  void initState() {
    super.initState();
    _startRecognitionLoop();
  }

  @override
  void dispose() {
    _recognitionTimer?.cancel();
    super.dispose();
  }

  void _startRecognitionLoop() {
    _recognitionTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (widget.cameraController?.value.isInitialized == true &&
          !_isProcessing &&
          TFLiteService.instance.isInitialized) {
        _performRecognition();
      }
    });
  }

  Future<void> _performRecognition() async {
    if (_isProcessing || widget.cameraController == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final products = ['nestle', 'ariel', 'lux', 'nutella', 'lays', 'gliss'];
      final randomProduct = products[
          (DateTime.now().millisecondsSinceEpoch ~/ 3000) % products.length];

      final mockPrediction = Prediction(
        label: randomProduct,
        confidence: 0.75 + (DateTime.now().millisecondsSinceEpoch % 100) / 400,
        index: 0,
      );

      final mockResult = InferenceResult(
        predictions: [mockPrediction],
        topPrediction: mockPrediction,
        processingTime: DateTime.now().millisecondsSinceEpoch,
      );

      if (mockResult.topPrediction.confidence > 0.6) {
        setState(() {
          _currentResult = mockResult;
          _recognizedProduct = mockResult.topPrediction.label;
          _isBoycotted = mockResult.isBoycotted;
          _recognitionBox = _calculateRecognitionBox();
        });
      } else {
        setState(() {
          _currentResult = null;
          _recognizedProduct = null;
          _isBoycotted = false;
          _recognitionBox = null;
        });
      }
    } catch (e) {
      print('Recognition error: $e');
      setState(() {
        _currentResult = null;
        _recognizedProduct = null;
        _isBoycotted = false;
        _recognitionBox = null;
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Rect _calculateRecognitionBox() {
    final size = MediaQuery.of(context).size;
    final boxSize = size.width * 0.6;
    final left = (size.width - boxSize) / 2;
    final top = size.height * 0.3;

    return Rect.fromLTWH(left, top, boxSize, boxSize * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    if (_recognitionBox == null || _recognizedProduct == null) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: CustomPaint(
        painter: RecognitionBoxPainter(
          recognitionBox: _recognitionBox!,
          productName: _recognizedProduct!,
          isBoycotted: _isBoycotted,
          confidence: _currentResult?.topPrediction.confidence ?? 0.0,
        ),
      ),
    );
  }
}

class RecognitionBoxPainter extends CustomPainter {
  final Rect recognitionBox;
  final String productName;
  final bool isBoycotted;
  final double confidence;

  RecognitionBoxPainter({
    required this.recognitionBox,
    required this.productName,
    required this.isBoycotted,
    required this.confidence,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final boxColor = isBoycotted ? Colors.red : Colors.green;
    final boxPaint = Paint()
      ..color = boxColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawRect(recognitionBox, boxPaint);

    _drawCornerIndicators(canvas, recognitionBox, boxColor);

    final labelHeight = 60.0;
    final labelRect = Rect.fromLTWH(
      recognitionBox.left,
      recognitionBox.top - labelHeight,
      recognitionBox.width,
      labelHeight,
    );

    final labelPaint = Paint()..color = boxColor.withOpacity(0.8);

    final labelRRect = RRect.fromRectAndCorners(
      labelRect,
      topLeft: const Radius.circular(8),
      topRight: const Radius.circular(8),
    );

    canvas.drawRRect(labelRRect, labelPaint);

    final textPainter = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: productName.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '\n${(confidence * 100).toStringAsFixed(1)}% confidence',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          if (isBoycotted)
            const TextSpan(
              text: ' • BOYCOTTED',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout(maxWidth: recognitionBox.width - 16);

    final textOffset = Offset(
      recognitionBox.left + (recognitionBox.width - textPainter.width) / 2,
      recognitionBox.top - labelHeight + 8,
    );

    textPainter.paint(canvas, textOffset);
  }

  void _drawCornerIndicators(Canvas canvas, Rect box, Color color) {
    final cornerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final cornerLength = 20.0;

    canvas.drawLine(
      Offset(box.left, box.top + cornerLength),
      Offset(box.left, box.top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(box.left, box.top),
      Offset(box.left + cornerLength, box.top),
      cornerPaint,
    );

    canvas.drawLine(
      Offset(box.right - cornerLength, box.top),
      Offset(box.right, box.top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(box.right, box.top),
      Offset(box.right, box.top + cornerLength),
      cornerPaint,
    );

    canvas.drawLine(
      Offset(box.left, box.bottom - cornerLength),
      Offset(box.left, box.bottom),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(box.left, box.bottom),
      Offset(box.left + cornerLength, box.bottom),
      cornerPaint,
    );

    canvas.drawLine(
      Offset(box.right - cornerLength, box.bottom),
      Offset(box.right, box.bottom),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(box.right, box.bottom),
      Offset(box.right, box.bottom - cornerLength),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RecognitionBoxPainter oldDelegate) {
    return oldDelegate.recognitionBox != recognitionBox ||
        oldDelegate.productName != productName ||
        oldDelegate.isBoycotted != isBoycotted ||
        oldDelegate.confidence != confidence;
  }
}
