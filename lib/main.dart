import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/camera/data/repositories/camera_repository_impl.dart';
import 'features/camera/domain/usecases/take_picture_usecase.dart';
import 'features/camera/presentation/bloc/camera_cubit.dart';
import 'features/camera/presentation/pages/camera_page.dart';
import 'package:image_picker/image_picker.dart';
import 'services/tflite_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Pre-initialize TensorFlow Lite service
  await TFLiteService.instance.initialize();

  final cameraRepository = CameraRepositoryImpl(ImagePicker());
  final takePictureUseCase = TakePictureUseCase(cameraRepository);

  runApp(
    BlocProvider(
      create: (_) => CameraCubit(takePictureUseCase, cameraRepository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boycott App',
      home: CameraPage(),
    );
  }
}
