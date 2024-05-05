import 'package:share_plus/share_plus.dart';

shareApp(int? eventId) async {
  const String message = "Check out this event in Evento";
  final String url = eventId != null
      ? "https://evento.sy/#/eventDetailes?id=$eventId"
      : "https://evento.sy"; // Replace with your event link
  final String shareContent = "$message\n\nFor more details, visit: $url";

  await Share.share(shareContent);
}

shareReel(int reelIndex) async {
  final String url = "https://evento.sy/#/ShowReelScreen?id=$reelIndex";
  final String shareContent = url;

  await Share.share(shareContent);
}

shareTicket(int ticketId) async {
  final String url = "https://evento.sy/#/ShowSingleTicketScreen?id=$ticketId";
  final String shareContent = url;

  await Share.share(shareContent);
}
