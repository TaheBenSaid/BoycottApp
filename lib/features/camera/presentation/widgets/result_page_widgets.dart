import 'dart:io';
import 'package:flutter/material.dart';

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
  const AlternativesSection({super.key});

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
        const Row(
          children: [
            _AlternativeCard(),
            SizedBox(width: 12),
            _AlternativeCard(),
          ],
        ),
      ],
    );
  }
}

class _AlternativeCard extends StatelessWidget {
  const _AlternativeCard();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.icecream, size: 36, color: Colors.pink),
            SizedBox(height: 8),
            Text("Parad'Ice"),
          ],
        ),
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
