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
      child:
          // model.event != null
          // ?
          Image.network(
        'https://picsum.photos/seed/913/600',
        fit: BoxFit.cover,
      )
      // : getImageNetwork(url: getReelImage(model), width: null, height: null),
      );
}

String getReelImage(ReelModel model) {
  if (model.event != null) {
    return model.event!.images[0];
  }
// else if(model.user!=null){
//   return model.user!.;
// }
// else if(model.venue!=null){
//   return model.venue!.;
// }
  else {
    return "https://picsum.photos/seed/913/600";
  }
}
