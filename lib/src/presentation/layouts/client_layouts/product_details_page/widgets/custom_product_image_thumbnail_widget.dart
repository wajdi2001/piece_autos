import 'package:flutter/material.dart';
import 'package:piece_autos/core/utils/constants.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomProductImageThumbnailWidget extends StatefulWidget {
  final List<String> images;

  const CustomProductImageThumbnailWidget({
    super.key,
    required this.images,
  });

  @override
  State<CustomProductImageThumbnailWidget> createState() =>
      _CustomProductImageThumbnailWidgetState();
}

class _CustomProductImageThumbnailWidgetState
    extends State<CustomProductImageThumbnailWidget> {
  int _selectedImageIndex = 0; // Keeps track of the selected image index

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Image Display
        Container(
          height: ResponsiveBreakpoints.of(context).isDesktop ? 400 : 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(
                  '$baseUrl/${widget.images[_selectedImageIndex]}'), // Display selected image
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Thumbnails
        SizedBox(
          height: 60, // Fixed height for thumbnails
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedImageIndex = index; // Update selected image index
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 60, // Fixed width for thumbnails
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedImageIndex == index
                        ? Colors.blue
                        : Colors.transparent, // Highlight selected thumbnail
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage('$baseUrl/${widget.images[index]}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
