import 'package:flutter/material.dart';
import '../widgets/result_page_widgets.dart';

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
            ProductImageHeader(imagePath: imagePath),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: const SingleChildScrollView(
                  child: _ResultContent(),
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
  const _ResultContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BoycottWarningBanner(),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductInfo(
                productName: 'Starbucks',
                companyName: 'Starbucks inc',
              ),
              SizedBox(height: 12),
              ProductDescription(
                description:
                    "Le boycott a pour but et pour effet de déranger et de nuire à autrui. Dans un État de droit fondés sur des préceptes comme « neminem laedere » qui interdisent de nuire à autrui, la question du boycott se trouve à la limite de la légalité et nécessite certaines formes de retenue.",
              ),
              SizedBox(height: 12),
              OpenProofButton(),
              SizedBox(height: 16),
              AlternativesSection(),
              SizedBox(height: 20),
              SharePanel(),
              SizedBox(height: 70),
            ],
          ),
        ),
      ],
    );
  }
}
