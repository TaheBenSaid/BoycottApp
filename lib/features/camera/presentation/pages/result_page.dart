import 'package:flutter/material.dart';
import '../widgets/result_page_widgets.dart';
import '../../../../services/tflite_service.dart';
import '../../../../services/boycott_database.dart' as boycott_db;

class ResultPage extends StatelessWidget {
  final String imagePath;
  final InferenceResult? inferenceResult;

  const ResultPage({
    super.key,
    required this.imagePath,
    this.inferenceResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            ProductImageHeader(imagePath: imagePath),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  child: _ResultContent(inferenceResult: inferenceResult),
                ),
              ),
            ),
            const ResultBottomNavigation(),
          ],
        ),
      ),
    );
  }
}

class _ResultContent extends StatelessWidget {
  final InferenceResult? inferenceResult;

  const _ResultContent({this.inferenceResult});

  @override
  Widget build(BuildContext context) {
    // Get boycott info from inference result or use default
    final boycottInfo = inferenceResult?.boycottInfo ??
        boycott_db.BoycottInfo(
          productName: 'Unknown Product',
          companyName: 'Unknown Company',
          description:
              'Unable to analyze the product. Please try again with a clearer image.',
          isBoycotted: false,
          alternatives: ['Try scanning again', 'Check product manually'],
        );

    return Column(
      children: [
        if (boycottInfo.isBoycotted) ...[
          const BoycottWarningBanner(),
          const SizedBox(height: 16),
        ] else ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE1F5E1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              inferenceResult != null
                  ? 'Product analyzed - No boycott information found.'
                  : 'Unable to analyze product. Please try again.',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductInfo(
                productName: boycottInfo.productName,
                companyName: boycottInfo.companyName,
              ),
              const SizedBox(height: 12),
              if (inferenceResult != null) ...[
                InferenceDetailsCard(inferenceResult: inferenceResult!),
                const SizedBox(height: 12),
              ],
              ProductDescription(
                description: boycottInfo.description,
              ),
              const SizedBox(height: 12),
              if (boycottInfo.isBoycotted) const OpenProofButton(),
              const SizedBox(height: 16),
              AlternativesSection(alternatives: boycottInfo.alternatives),
              const SizedBox(height: 20),
              const SharePanel(),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ],
    );
  }
}
