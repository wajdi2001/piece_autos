import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piece_autos/core/utils/constants.dart';
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
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // Adjust quality if needed
    );

    if (pickedFile != null) {
      // Dispatch the event with the selected image file
      // ignore: use_build_context_synchronously
      context
          .read<DashboardBloc>()
          .add(DashboardSelectImageEvent(imageFile: File(pickedFile.path)));
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
            /*if (state.selectedImageBytes == null && defaultNetworkImage != null)
              Image.network(
                "$baseUrl/$defaultNetworkImage",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),*/
            if (state.selectedImageBytes != null)
              Column(
                children: [
                  const Text("Selected Image:"),
                  const SizedBox(height: 8),
                  Image.memory(
                    state.selectedImageBytes!,
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
