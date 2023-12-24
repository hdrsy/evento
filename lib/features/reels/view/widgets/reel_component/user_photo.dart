import 'package:flutter/material.dart';

Container userPhoto() {
    return Container(
      width: 50,
      height: 50,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.network(
        'https://picsum.photos/seed/913/600',
        fit: BoxFit.cover,
      ),
    );
  }
