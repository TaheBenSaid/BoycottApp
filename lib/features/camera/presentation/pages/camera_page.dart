import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/camera_cubit.dart';
import 'result_page.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  void initState() {
    super.initState();
    // Initialize camera on startup
    context.read<CameraCubit>().initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera preview or captured image
            Positioned.fill(
              child: BlocListener<CameraCubit, dynamic>(
                listenWhen: (prev, curr) => curr != null,
                listener: (context, state) {
                  if (state != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ResultPage(imagePath: state.path),
                      ),
                    );
                  }
                },
                child: BlocBuilder<CameraCubit, dynamic>(
                  builder: (context, state) {
                    final cubit = context.read<CameraCubit>();
                    final controller = cubit.cameraController;

                    if (state == null &&
                        controller?.value.isInitialized == true) {
                      // Show live camera preview
                      return CameraPreview(controller!);
                    } else if (state == null) {
                      // Loading camera or no camera available
                      return Container(
                        color: Colors.black,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white70),
                              SizedBox(height: 16),
                              Text(
                                'Initializing Camera...',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Image.file(
                        File(state.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    }
                  },
                ),
              ),
            ),
            // Capture button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 200.0),
                child: BlocBuilder<CameraCubit, dynamic>(
                  builder: (context, state) {
                    if (state == null) {
                      return GestureDetector(
                        onTap: () => context.read<CameraCubit>().takePicture(),
                        child: Container(
                          width: 78,
                          height: 78,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 12,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                context.read<CameraCubit>().clear(),
                            child: Text('Retake'),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Image ready to send!')),
                              );
                            },
                            child: Text('Use this Photo'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
            // Info section above nav bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF5D8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'You got the Power !',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Share this Information with People so they make the right choice',
                        style: TextStyle(fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Row(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom navigation bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavBarItem(
                      icon: Icons.home,
                      label: 'Home',
                      selected: true,
                      onTap: () {},
                    ),
                    _NavBarItem(
                      icon: Icons.favorite_border,
                      label: 'Alternatives',
                      selected: false,
                      onTap: () {},
                    ),
                    _NavBarItem(
                      icon: Icons.article_outlined,
                      label: 'Articles',
                      selected: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.green : Colors.black54;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
