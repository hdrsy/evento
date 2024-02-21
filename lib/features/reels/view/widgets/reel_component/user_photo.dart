import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/features/reels/model/reels_model.dart';
import 'package:flutter/material.dart';

Container userPhoto(ReelModel model) {
  return Container(
    width: 50,
    height: 50,
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
    ),
    child: getReelImage(model) == null
        ? Image.network(
            'https://picsum.photos/seed/913/600',
            fit: BoxFit.cover,
          )
        : getImageNetworkforCahing(
            url: getReelImage(model)!, width: null, height: null),
  );
}

String? getReelImage(ReelModel model) {
  if (model.event != null) {
    return model.event!.images[0];
  } else if (model.user != null) {
    return model.user!.image;
  } else if (model.venue != null) {
    return model.venue!.profile!;
  } else {
    return null;
  }
}
