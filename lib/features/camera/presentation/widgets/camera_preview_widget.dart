import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/camera_cubit.dart';
import 'recognition_overlay_widget.dart';

class CameraPreviewWidget extends StatelessWidget {
  const CameraPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CameraCubit>();
        final controller = cubit.cameraController;

        if (state == null && controller?.value.isInitialized == true) {
          return Stack(
            fit: StackFit.expand,
            children: [
              CameraPreview(controller!),
              RecognitionOverlayWidget(cameraController: controller),
            ],
          );
        } else if (state == null) {
          return _LoadingView();
        } else {
          return _CapturedImageView(imagePath: state.path);
        }
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white70),
            SizedBox(height: 16),
            Text(
              'Initializing Camera...',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _CapturedImageView extends StatelessWidget {
  final String imagePath;

  const _CapturedImageView({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(imagePath),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
