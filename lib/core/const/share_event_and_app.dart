import 'package:share_plus/share_plus.dart';

shareApp(int? eventId) async {
  const String message = "Check out this event in Evento";
  final String url = eventId != null
      ? "http://evento.sy/#/eventDetailes?id=$eventId&isOffer=false&offerPercent=0"
      : "http://evento.sy"; // Replace with your event link
  final String shareContent = "$message\n\nFor more details, visit: $url";

  await Share.share(shareContent);
}
