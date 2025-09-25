import 'dart:io';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String imagePath;
  const ResultPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top carousel-like image
            AspectRatio(
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
            ),
            // Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Starbucks',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 4),
                                Text('owned by : Starbucks inc',
                                    style: TextStyle(color: Colors.black54)),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.black12,
                            child: const Icon(Icons.local_cafe,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Le boycott a pour but et pour effet de déranger et de nuire à autrui. Dans un État de droit fondés sur des préceptes comme « neminem laedere » qui interdisent de nuire à autrui, la question du boycott se trouve à la limite de la légalité et nécessite certaines formes de retenue.",
                        style: TextStyle(height: 1.35),
                      ),
                      const SizedBox(height: 12),
                      Opacity(
                        opacity: 0.5,
                        child: ElevatedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.warning_amber_rounded),
                          label: const Text('Open Proof'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 44),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(
                            child: Text('Alternatives',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text('next')),
                        ],
                      ),
                      Row(
                        children: [
                          _AlternativeCard(),
                          const SizedBox(width: 12),
                          _AlternativeCard(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFF5D8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const Text('You got the Power !',
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 6),
                            const Text(
                                'Share this Information with People so they make the right choice',
                                textAlign: TextAlign.center),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom navigation mimic
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(color: Colors.grey.shade200, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _NavItem(icon: Icons.home, label: 'Home', selected: true),
                  _NavItem(icon: Icons.favorite_border, label: 'Alternatives'),
                  _NavItem(icon: Icons.article_outlined, label: 'Articles'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AlternativeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.icecream, size: 36, color: Colors.pink),
            SizedBox(height: 8),
            Text("Parad'Ice"),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  const _NavItem(
      {required this.icon, required this.label, this.selected = false});

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
