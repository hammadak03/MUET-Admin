import 'package:url_launcher/url_launcher.dart';

urlNewsLauncher(String link) {
  link = link;
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}

urlEventLauncher(String link) {
  link = link;
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}
