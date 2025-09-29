import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/camera_cubit.dart';
import '../widgets/camera_preview_widget.dart';
import '../widgets/flash_toggle_widget.dart';
import '../widgets/capture_button_widget.dart';
import '../widgets/info_panel_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import 'result_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  void initState() {
    super.initState();
    context.read<CameraCubit>().initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(
              child: _CameraViewWithNavigation(),
            ),
            const FlashToggleWidget(),
            const CaptureButtonWidget(),
            const InfoPanelWidget(),
            const BottomNavigationWidget(),
          ],
        ),
      ),
    );
  }
}

class _CameraViewWithNavigation extends StatelessWidget {
  const _CameraViewWithNavigation();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CameraCubit, dynamic>(
      listenWhen: (prev, curr) => curr != null,
      listener: (context, state) {
        if (state != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ResultPage(
                imagePath: state.path,
                inferenceResult: state.inferenceResult,
              ),
            ),
          );
        }
      },
      child: const CameraPreviewWidget(),
    );
  }
}
