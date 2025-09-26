import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/camera_cubit.dart';

class FlashToggleWidget extends StatelessWidget {
  const FlashToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 10,
      child: BlocBuilder<CameraCubit, dynamic>(
        builder: (context, state) {
          final cubit = context.read<CameraCubit>();
          final controller = cubit.cameraController;

          if (controller?.value.isInitialized != true) {
            return const SizedBox.shrink();
          }

          return GestureDetector(
            onTap: () => cubit.toggleFlash(),
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                cubit.isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 20,
              ),
            ),
          );
        },
      ),
    );
  }
}
