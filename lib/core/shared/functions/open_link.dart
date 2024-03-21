import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String link) async {
  try {
    if (!await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch $link');
    }
  } catch (e) {}
}
