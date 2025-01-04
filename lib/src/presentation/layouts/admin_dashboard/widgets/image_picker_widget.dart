import 'dart:developer';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_state.dart';

class ImagePickerWidget extends StatelessWidget {
  final String? defaultNetworkImage;
  const ImagePickerWidget({
    super.key,
    this.defaultNetworkImage,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Adjust quality if needed
      );

      if (pickedFile != null) {
        Uint8List imageBytes = await pickedFile.readAsBytes();

        // Extract the name and extension
        String imageName;
        String imageExtension;

        if (kIsWeb) {
          imageName = pickedFile.name; // `name` is available on web
          imageExtension = imageName.split('.').last;
        } else {
          // On mobile, extract from the file path
          final filePath = pickedFile.path;
          imageName = filePath.split('/').last;
          imageExtension = imageName.split('.').last;
        }

        log("Selected image: name=$imageName, extension=$imageExtension");

        context.read<DashboardBloc>().add(
              DashboardSelectImageEvent(
                imageBytes: imageBytes,
                imageName: imageName,
                imageExtension: imageExtension,
              ),
            );
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () => _pickImage(context),
              child: const Text("Pick an Image"),
            ),
            const SizedBox(height: 16),

            if (state.imageData != null)
              Column(
                children: [
                  const Text("Selected Image:"),
                  const SizedBox(height: 8),
                  Image.memory(
                    state.imageData!.data,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
