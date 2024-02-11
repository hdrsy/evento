import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopImageWidget extends StatelessWidget {
  final String imageUrl;

  const TopImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: double.infinity,
      height: 340.h,
      fit: BoxFit.cover,
    );
  }
}
