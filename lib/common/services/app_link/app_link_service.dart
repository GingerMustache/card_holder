import 'package:app_links/app_links.dart';

class AppLinkService {
  late final AppLinks appLinks;

  AppLinkService() : appLinks = AppLinks();

  Stream<Uri?> get uriStream => appLinks.uriLinkStream;
}
