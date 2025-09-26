import 'package:flutter/material.dart';

class InfoPanelWidget extends StatelessWidget {
  const InfoPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 70.0),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFDFF5D8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _InfoTitle(),
              SizedBox(height: 4),
              _InfoSubtitle(),
              SizedBox(height: 8),
              _SocialIcons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTitle extends StatelessWidget {
  const _InfoTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'You got the Power !',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}

class _InfoSubtitle extends StatelessWidget {
  const _InfoSubtitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Share this Information with People so they make the right choice',
      style: TextStyle(
        color: Color(0xFF568F59),
        fontSize: 13,
        fontFamily: 'Source Sans Pro',
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _SocialIcons extends StatelessWidget {
  const _SocialIcons();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.facebook, size: 24),
        SizedBox(width: 14),
        Icon(Icons.link, size: 24),
        SizedBox(width: 14),
        Icon(Icons.share, size: 24),
        SizedBox(width: 14),
        Icon(Icons.camera_alt, size: 24),
      ],
    );
  }
}
