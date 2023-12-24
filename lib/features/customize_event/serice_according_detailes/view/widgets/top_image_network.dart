import 'package:flutter/widgets.dart';

class TopImageWidget extends StatelessWidget {
  final String imageUrl;

  const TopImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: double.infinity,
      height: 340,
      fit: BoxFit.cover,
    );
  }
}
