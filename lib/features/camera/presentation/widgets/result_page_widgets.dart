import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../services/tflite_service.dart';

class ProductImageHeader extends StatelessWidget {
  final String imagePath;

  const ProductImageHeader({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(File(imagePath), fit: BoxFit.cover),
          Positioned(
            top: 8,
            left: 8,
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

class BoycottWarningBanner extends StatelessWidget {
  const BoycottWarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE1E1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'this product is boycotted. Open proof to know The reason!',
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final String productName;
  final String companyName;

  const ProductInfo({
    super.key,
    required this.productName,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'owned by : $companyName',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
        const CircleAvatar(
          radius: 18,
          backgroundColor: Colors.black12,
          child: Icon(Icons.local_cafe, color: Colors.black54),
        ),
      ],
    );
  }
}

class ProductDescription extends StatelessWidget {
  final String description;

  const ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(height: 1.35),
    );
  }
}

class OpenProofButton extends StatelessWidget {
  const OpenProofButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: ElevatedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.warning_amber_rounded),
        label: const Text('Open Proof'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 44),
        ),
      ),
    );
  }
}

class AlternativesSection extends StatelessWidget {
  final List<String> alternatives;

  const AlternativesSection({
    super.key,
    this.alternatives = const ['Local Alternative', 'Ethical Brand'],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Alternatives',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('next')),
          ],
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: alternatives
              .take(4)
              .map((alternative) => _AlternativeCard(name: alternative))
              .toList(),
        ),
      ],
    );
  }
}

class _AlternativeCard extends StatelessWidget {
  final String name;

  const _AlternativeCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 56) / 2, // Responsive width
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getIconForAlternative(name),
            size: 36,
            color: Colors.pink,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForAlternative(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('coffee') || lowerName.contains('café')) {
      return Icons.local_cafe;
    } else if (lowerName.contains('burger') || lowerName.contains('food')) {
      return Icons.fastfood;
    } else if (lowerName.contains('ice') || lowerName.contains('cream')) {
      return Icons.icecream;
    } else if (lowerName.contains('local') || lowerName.contains('shop')) {
      return Icons.store;
    } else {
      return Icons.shopping_bag;
    }
  }
}

class InferenceDetailsCard extends StatelessWidget {
  final InferenceResult inferenceResult;

  const InferenceDetailsCard({super.key, required this.inferenceResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.analytics_outlined,
                  size: 16, color: Colors.blue),
              const SizedBox(width: 6),
              Text(
                'AI Analysis Results',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Top prediction
          _PredictionRow(
            prediction: inferenceResult.topPrediction,
            isTop: true,
          ),

          // Show additional predictions if confidence is low
          if (inferenceResult.topPrediction.confidence < 0.8 &&
              inferenceResult.predictions.length > 1) ...[
            const SizedBox(height: 4),
            ...inferenceResult.predictions
                .skip(1)
                .take(2)
                .map((pred) => _PredictionRow(prediction: pred)),
          ],
        ],
      ),
    );
  }
}

class _PredictionRow extends StatelessWidget {
  final Prediction prediction;
  final bool isTop;

  const _PredictionRow({
    required this.prediction,
    this.isTop = false,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (prediction.confidence * 100).toStringAsFixed(1);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              prediction.label,
              style: TextStyle(
                fontWeight: isTop ? FontWeight.w600 : FontWeight.normal,
                fontSize: isTop ? 14 : 12,
                color: isTop ? Colors.black87 : Colors.grey.shade600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isTop ? Colors.blue.shade100 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isTop ? Colors.blue.shade700 : Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SharePanel extends StatelessWidget {
  const SharePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF5D8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Text(
            'You got the Power !',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6),
          Text(
            'Share this Information with People so they make the right choice',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.facebook),
              SizedBox(width: 12),
              Icon(Icons.link),
              SizedBox(width: 12),
              Icon(Icons.share),
              SizedBox(width: 12),
              Icon(Icons.camera_alt),
            ],
          ),
        ],
      ),
    );
  }
}

class ResultBottomNavigation extends StatelessWidget {
  const ResultBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home, label: 'Home', selected: true),
          _NavItem(icon: Icons.favorite_border, label: 'Alternatives'),
          _NavItem(icon: Icons.article_outlined, label: 'Articles'),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = selected ? Colors.green : Colors.black54;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}
