import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/camera_repository_impl.dart';
import '../../domain/entities/captured_image.dart';
import '../../domain/usecases/take_picture_usecase.dart';

class CameraCubit extends Cubit<CapturedImage?> {
  final TakePictureUseCase takePictureUseCase;
  final CameraRepositoryImpl repository;
  CameraController? _cameraController;

  CameraCubit(this.takePictureUseCase, this.repository) : super(null);

  CameraController? get cameraController => _cameraController;

  Future<void> initializeCamera() async {
    _cameraController = await repository.initializeCamera();
    emit(null);
  }

  Future<void> takePicture() async {
    final image = await takePictureUseCase();
    emit(image);
  }

  Future<void> toggleFlash() async {
    await repository.toggleFlash();
    emit(null);
  }

  bool get isFlashOn => repository.isFlashOn;

  void clear() => emit(null);

  @override
  Future<void> close() {
    repository.dispose();
    return super.close();
  }
}
