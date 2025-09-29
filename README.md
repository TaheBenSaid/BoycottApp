# Boycott App - TensorFlow Lite Integration

A Flutter app that uses TensorFlow Lite to analyze captured images and provide boycott information for detected products.

## Features

- **Camera Integration**: Capture images using device camera or pick from gallery
- **TensorFlow Lite Inference**: Real-time product recognition using a custom TFLite model
- **Boycott Information**: Display boycott status and alternatives for detected products
- **Clean Architecture**: Follows clean architecture principles with proper separation of concerns
- **Modern UI**: Beautiful and responsive user interface

## Architecture

The app follows clean architecture principles:

```
lib/
├── features/
│   └── camera/
│       ├── data/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
├── services/
│   └── tflite_service.dart
└── main.dart
```

## Key Components

### TensorFlow Lite Service (`lib/services/tflite_service.dart`)
- Singleton service that handles TFLite model initialization and inference
- Supports image preprocessing and result processing
- Provides boycott information based on detected products

### Camera Repository (`lib/features/camera/data/repositories/camera_repository_impl.dart`)
- Handles camera operations and image capture
- Integrates with TFLite service for inference
- Returns captured images with inference results

### Result Page (`lib/features/camera/presentation/pages/result_page.dart`)
- Displays captured image and inference results
- Shows boycott status and product information
- Provides alternatives for boycotted products

## Setup and Installation

1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Assets**:
   - Place your TensorFlow Lite model at `assets/best_float32.tflite`
   - Labels file is at `assets/labels.txt` (optional, defaults are provided)

3. **Run the App**:
   ```bash
   flutter run
   ```

## Usage Flow

1. **App Launch**: TensorFlow Lite model is initialized automatically
2. **Camera Screen**: Users can capture images using the camera
3. **Image Processing**: Captured images are automatically processed by the TFLite model
4. **Results Display**: Users are navigated to a results page showing:
   - The captured image
   - AI analysis results with confidence scores
   - Boycott status and information
   - Alternative product suggestions

## Model Integration

The app supports any TensorFlow Lite image classification model. Key requirements:

- **Model Format**: `.tflite` file
- **Input**: RGB images (automatically resized to match model requirements)
- **Output**: Classification probabilities

### Customizing for Your Model

1. Replace `assets/best_float32.tflite` with your model
2. Update `assets/labels.txt` with your model's class labels
3. Modify `BoycottInfo` logic in `tflite_service.dart` for your use case

## Dependencies

- `flutter_bloc`: State management
- `camera`: Camera functionality
- `image_picker`: Image selection
- `tflite_flutter`: TensorFlow Lite inference
- `image`: Image processing

## Performance Considerations

- Model is initialized once at app startup
- Images are preprocessed efficiently using the `image` package
- Results are cached in the `CapturedImage` entity
- UI updates are handled reactively using BLoC pattern

## Error Handling

- Graceful handling of missing model or labels files
- Fallback to default labels if `labels.txt` is not found
- Proper error messages for failed inference
- Camera permission handling

## Future Enhancements

- Offline database for boycott information
- Real-time camera preview with overlay
- Batch processing of multiple images
- Model quantization for better performance
- Cloud-based model updates

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License.