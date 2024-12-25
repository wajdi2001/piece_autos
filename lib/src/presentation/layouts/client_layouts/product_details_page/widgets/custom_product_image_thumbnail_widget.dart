import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomProductImageThumbnailWidget extends StatelessWidget {
  const CustomProductImageThumbnailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height:ResponsiveBreakpoints.of(context).isDesktop? 400:300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: NetworkImage(
                  'https://th.bing.com/th?id=OIP.eSDfFo94Nagel-5Xp7HOjQAAAA&w=250&h=250&c=8&rs=1&qlt=90&o=6&dpr=1.1&pid=3.1&rm=2'), // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Thumbnail
        SizedBox(
          height: ResponsiveBreakpoints.of(context).isDesktop?50:50,
          width: ResponsiveBreakpoints.of(context).isDesktop?50:50,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://th.bing.com/th?id=OIP.eSDfFo94Nagel-5Xp7HOjQAAAA&w=250&h=250&c=8&rs=1&qlt=90&o=6&dpr=1.1&pid=3.1&rm=2'), // Replace with your thumbnail URL
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
