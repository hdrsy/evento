import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

class CustomDeepLinkService {
  Future<void> initUniLinks() async {
    // Handle the initial link if the app is opened with a link
    final initialLink = await getInitialLink();
    _handleLink(initialLink);

    // Listen for new links if the app is already opened
    linkStream.listen((String? link) {
      _handleLink(link);
    }, onError: (err) {
      // Handle error scenarios
    });
  }

  void _handleLink(String? link) {
    if (link != null && link.contains('/#/ShowReelScreen')) {
      Uri uri = Uri.parse(link);
      String? id = uri.queryParameters['id'];
      if (id != null) {
        // Use GetX's navigation method to navigate
        Get.toNamed('/ShowReelScreen', parameters: {'id': id});
        print("Navigate to ShowReelScreen with ID: $id");
      }
    }
  }
}
